local M = {}

M.config = function()
  local status_ok, leap = pcall(require, "leap")
  if not status_ok then
    return
  end
  leap.setup {
    case_insensitive = true,
    -- Leaving the appropriate list empty effectively disables "smart" mode,
    -- and forces auto-jump to be on or off.
    safe_labels = { "s", "f", "g", "h", "t", "u", "n", "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z" },
    special_keys = {
      repeat_search = "<enter>",
      next_match = "<enter>",
      prev_match = "<tab>",
      next_group = "<space>",
      prev_group = "<tab>",
      eol = "<space>",
    },
  }

  -- Searching in all windows (including the current one) on the tab page:
  function leap_all_windows()
    require("leap").leap {
      ["target-windows"] = vim.tbl_filter(function(win)
        return vim.api.nvim_win_get_config(win).focusable
      end, vim.api.nvim_tabpage_list_wins(
        0
      )),
    }
  end

  -- Bidirectional search in the current window is just a specific case of the
  -- multi-window mode - set `target-windows` to a table containing the current
  -- window as the only element:
  function leap_bidirectional()
    require("leap").leap { ["target-windows"] = { vim.api.nvim_get_current_win() } }
  end

  -- Map them to your preferred key, like:
  require("leap").set_default_keymaps()
  vim.keymap.set("n", "s", leap_all_windows, { silent = true })
  vim.keymap.set("v", "s", leap_all_windows, { silent = true })
  vim.keymap.set("o", "z", leap_all_windows, { silent = true })
end

return M
