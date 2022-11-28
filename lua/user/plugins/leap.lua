local M = {}

M.config = function()
  local leap = require "leap"
  leap.opts.case_sensitive = false
  leap.opts.highlight_unlabeled_phase_one_targets = true
  -- highlight_unlabeled = true,
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  -- safe_labels = { "s", "f", "g", "h", "t", "u", "n", "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z" },

  -- Searching in all windows (including the current one) on the tab page:
  local function leap_all_windows()
    leap.leap {
      target_windows = vim.tbl_filter(function(win)
        return vim.api.nvim_win_get_config(win).focusable
      end, vim.api.nvim_tabpage_list_wins(0)),
    }
  end

  -- Bidirectional search in the current window is just a specific case of the
  -- multi-window mode - set `target-windows` to a table containing the current
  -- window as the only element:
  local function leap_bidirectional()
    leap.leap { target_windows = { vim.fn.win_getid() } }
  end

  local function get_targets(winid)
    local wininfo = vim.fn.getwininfo(winid)[1]
    local cur_line = vim.fn.line "."
    -- Get targets.
    local targets = {}
    local lnum = wininfo.topline
    while lnum <= wininfo.botline do
      -- Skip folded ranges.
      local fold_end = vim.fn.foldclosedend(lnum)
      if fold_end ~= -1 then
        lnum = fold_end + 1
      else
        if lnum ~= cur_line then
          table.insert(targets, { pos = { lnum, 1 } })
        end
        lnum = lnum + 1
      end
    end
    -- Sort them by vertical screen distance from cursor.
    local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
    local function screen_rows_from_cursor(t)
      local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
      return math.abs(cur_screen_row - t_screen_row)
    end
    table.sort(targets, function(t1, t2)
      return screen_rows_from_cursor(t1) < screen_rows_from_cursor(t2)
    end)
    if #targets >= 1 then
      return targets
    end
  end

  -- Linewise motions
  local function leap_lines()
    winid = vim.api.nvim_get_current_win()
    leap.leap { targets = get_targets(winid), target_windows = { winid } }
  end

  local function leap_to_window()
    local target_windows = require("leap.util").get_enterable_windows()
    local targets = {}
    for _, win in ipairs(target_windows) do
      local wininfo = vim.fn.getwininfo(win)[1]
      local pos = { wininfo.topline, 1 } -- top/left corner
      table.insert(targets, { pos = pos, wininfo = wininfo })
    end

    leap.leap {
      target_windows = target_windows,
      targets = targets,
      action = function(target)
        vim.api.nvim_set_current_win(target.wininfo.winid)
      end,
    }
  end

  -- The following example showcases a custom action, using `multiselect`. We're
  -- executing a `normal!` command at each selected position (this could be even
  -- more useful if we'd pass in custom targets too).
  local function paranormal(targets)
    -- TODO: when live-command insert is fixed, change normal! to Norm!
    -- Get the :normal sequence to be executed.
    local input = vim.fn.input "normal! "
    if #input < 1 then
      return
    end

    local ns = vim.api.nvim_create_namespace ""

    -- Set an extmark as an anchor for each target, so that we can also execute
    -- commands that modify the positions of other targets (insert/change/delete).
    for _, target in ipairs(targets) do
      local line, col = unpack(target.pos)
      id = vim.api.nvim_buf_set_extmark(0, ns, line - 1, col - 1, {})
      target.extmark_id = id
    end

    -- Jump to each extmark (anchored to the "moving" targets), and execute the
    -- command sequence.
    for _, target in ipairs(targets) do
      local id = target.extmark_id
      local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
      vim.fn.cursor(pos[1] + 1, pos[2] + 1)
      vim.cmd("normal! " .. input)
    end

    -- Clean up the extmarks.
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  end

  -- Usage:
  local function multi_cursor_s()
    leap.leap {
      target_windows = { vim.fn.win_getid() },
      action = paranormal,
      multiselect = true,
    }
  end

  local function multi_cursor_lines()
    winid = vim.fn.win_getid()
    leap.leap { targets = get_targets(winid), target_windows = { winid }, multiselect = true }
  end

  -- Map them to your preferred key, like:
  leap.set_default_keymaps()
  require("user.keymaps").set_leap_keymaps(multi_cursor_s, multi_cursor_lines)
end

return M
