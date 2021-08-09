-- TODO refactor lir.lua into multiple files
-- TODO make a command :Delete: where it deletes a buffer and the file on disk simultaneously.
-- make a command :Chmod: Change the permissions of the current file.
-- make a filter/search command
local M = {}

-- TODO lir can't handle opening paths with ~ the first time round
-- once I close the buffer and redo the command, it works once then it stops working again

-- symlinking to avoid having a path with ~s lets be open the directory consistently

M.config = function()
  local status_ok, lir = pcall(require, "lir")
  if not status_ok then
    return
  end
  local api = vim.api
  local config = require "lir.config"
  local actions = require "lir.actions"
  local mark_actions = require "lir.mark.actions"
  local clipboard_actions = require "lir.clipboard.actions"
  local history = require "lir.history"
  local lirvim = require "lir.vim"
  local utils = require "lir.utils"
  local Path = require "plenary.path"
  local get_context = lirvim.get_context

  -- Lir Plugins
  local bkm_actions = require "lir.bookmark.actions"

  -- Custom Lir actions

  -- edit without splitting (builtin edit splits sometimes)
  -- =========================================
  local function edit_nosplit()
    local ctx = get_context()
    local dir, file = ctx.dir, ctx:current_value()
    if not file then
      return
    end

    local keepalt = (vim.w.lir_is_float and "") or "keepalt"

    if vim.w.lir_is_float and not ctx:is_dir_current() then
      -- 閉じてから開く
      actions.quit()
    end

    -- local cmd = (vim.api.nvim_buf_get_option(0, "modified") and "split") or "edit"
    local cmd = "edit"

    vim.cmd(string.format("%s %s %s", keepalt, cmd, vim.fn.fnameescape(dir .. file)))
    history.add(dir, file)
  end
  -- =========================================

  -- go to home dir
  -- =========================================
  local function home()
    vim.cmd("edit " .. vim.fn.expand "$HOME")
  end

  -- gomi (rm replacement)
  -- TODO: make gomi work with no files marked
  -- =========================================
  local function esc_path(path)
    return vim.fn.shellescape(vim.fn.fnamemodify(path, ":p"), true)
  end
  -- https://github.com/b4b4r07/gomi
  local function gomi()
    local ctx = lir.get_context()

    local marked_items = ctx:get_marked_items()
    if #marked_items == 0 then
      utils.error "Please mark one or more."
      return
    end

    local path_list = vim.tbl_map(function(items)
      return esc_path(items.fullpath)
    end, marked_items)

    if vim.fn.confirm("Delete files?", "&Yes\n&No", 2) ~= 1 then
      return
    end
    vim.fn.system("gomi " .. vim.fn.join(path_list))
    -- vim.fn.system("gomi -f" .. vim.fn.join(path_list))
    actions.reload()
  end
  -- =========================================

  -- local function nop() end

  -- go to git root
  -- =========================================
  local function goto_git_root()
    local dir = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd())
    if dir == nil or dir == "" then
      return
    end
    vim.cmd("e " .. dir)
  end

  -- input new file (create dirctories and files with the same command)
  -- If the input value ends with '/', the directory will be created and
  -- If the input value contains '/', and the directory does not exist, it will be created recursively
  -- If the input file name does not contain '.' or '/', check if it is a directory.
  -- If the first string is '.' and show_hidden_files is false, set it to true and display it again.
  -- =========================================
  local no_confirm_patterns = {
    "^LICENSE$",
    "^Makefile$",
  }
  local lcd = function(path)
    vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], path))
  end
  local need_confirm = function(filename)
    for _, pattern in ipairs(no_confirm_patterns) do
      if filename:match(pattern) then
        return false
      end
    end
    return true
  end

  local function input_newfile()
    local save_curdir = vim.fn.getcwd()
    lcd(lir.get_context().dir)
    local name = vim.fn.input("New file: ", "", "file")
    lcd(save_curdir)

    if name == "" then
      return
    end

    if name == "." or name == ".." then
      utils.error("Invalid file name: " .. name)
      return
    end

    -- If I need to check, I will.
    if need_confirm(name) then
      -- '.' is not included or '/' is not included, then
      -- I may have entered it as a directory, I'll check.
      if not name:match "%." and not name:match "/" then
        if vim.fn.confirm("Directory?", "&No\n&Yes", 1) == 2 then
          name = name .. "/"
        end
      end
    end

    local path = Path:new(lir.get_context().dir .. name)
    if string.match(name, "/$") then
      -- mkdir
      name = name:gsub("/$", "")
      path:mkdir {
        parents = true,
        mode = tonumber("700", 8),
        exists_ok = false,
      }
    else
      -- touch
      path:touch {
        parents = true,
        mode = tonumber("644", 8),
      }
    end

    -- If the first character is '.' and show_hidden_files is false, set it to true
    if name:match [[^%.]] and not config.values.show_hidden_files then
      config.values.show_hidden_files = true
    end

    actions.reload()

    -- Jump to a line in the parent directory of the file you created.
    local lnum = lir.get_context():indexof(name:match "^[^/]+")
    if lnum then
      vim.cmd(tostring(lnum))
    end
  end
  -- =========================================
  -- END input new file

  -- Construct the Lir floating window options according to the window we are
  -- currently in. The position of the window will be centered in the current
  -- window, thus not blocking other windows if opened.
  ---@return table<string, any>
  local function construct_win_opts()
    local winpos = api.nvim_win_get_position(0)
    local winwidth = api.nvim_win_get_width(0)
    local winheight = api.nvim_win_get_height(0)

    local width = math.min(80, winwidth - 14)
    local height = winheight - 6
    local row = (winheight / 2) - (height / 2) - 1
    local col = (winwidth / 2) - (width / 2)

    return {
      width = width,
      height = height,
      row = row + winpos[1],
      col = col + winpos[2],
      border = "single",
    }
  end

  lir.setup {
    show_hidden_files = false,
    devicons_enable = true,
    mappings = {
      ["@"] = actions.cd,
      [";"] = edit_nosplit,
      ["."] = actions.toggle_show_hidden,
      ["<cr>"] = edit_nosplit,
      ["<esc>"] = actions.quit,

      ["a"] = input_newfile,
      ["ba"] = bkm_actions.add,
      -- ["b"] = ""
      -- ["B"] = "",
      -- ["c"] = ""
      -- ["d"] = ""
      ["D"] = gomi,
      -- ["e"] = ""
      -- ["f"] = ""
      ["g"] = bkm_actions.list, -- opens a writeable buffer with all added bookmarks
      ["G"] = goto_git_root, -- navigates to the git root
      ["h"] = home, -- navigates to home dir
      -- ["i"] = ""
      ["l"] = actions.up,
      ["m"] = function()
        mark_actions.toggle_mark()
        vim.cmd "normal! j"
      end,
      -- ["n"] = ""
      -- ["o"] = ""
      ["P"] = clipboard_actions.paste,
      ["q"] = actions.quit,
      ["r"] = actions.rename,
      ["S"] = actions.split,
      -- ["t"] = "" -- make this open a toggleterm in the cwd
      -- ["u"] = ""
      ["V"] = actions.vsplit,
      -- ["w"] = ""
      ["X"] = clipboard_actions.cut,
      ["y"] = actions.yank_path,
      ["Y"] = clipboard_actions.copy,
      -- ["z"] = ""

      ["<C-s>"] = actions.split,
      ["<C-t>"] = actions.tabedit,
      ["<C-v>"] = actions.vsplit,
      ["<space>"] = function()
        mark_actions.toggle_mark()
        vim.cmd "normal! j"
      end,

      -- ["R"] = actions.reload,
      -- TODO: get lir.mmv to work (i think something is wrong with nvr)
      -- ["R"] = require("lir.mmv.actions").mmv,
      -- ["A"] = actions.mkdir,
      -- ["a"] = actions.newfile,
      -- ["d"] = actions.delete,
      -- ["w"] = actions.wipeout,
      -- [";"] = actions.edit,
    },
    float = {
      -- winblend = 8,
      winblend = lvim.winblend,
      -- -- You can define a function that returns a table to be passed as the third
      -- -- argument of nvim_open_win().
      win_opts = construct_win_opts,
      -- win_opts = function()
      --   --   local width = math.floor(vim.o.columns * 0.8)
      --   --   local height = math.floor(vim.o.lines * 0.8)
      --   return {
      --     border = "single",
      --     -- border = require("lir.float.helper").make_border_opts({
      --     --   "+",
      --     --   "─",
      --     --   "+",
      --     --   "│",
      --     --   "+",
      --     --   "─",
      --     --   "+",
      --     --   "│",
      --     -- }, "Normal"),
      --     --     width = width,
      --     --     height = height,
      --     --     row = 1,
      --     --     col = math.floor((vim.o.columns - width) / 2),
      --   }
      -- end,
    },
    hide_cursor = false,
  }

  -- custom folder icon
  require("nvim-web-devicons").setup {
    override = {
      lir_folder_icon = {
        icon = "",
        color = "#a9b665",
        name = "LirFolderNode",
      },
    },
  }

  -- use visual mode
  function _G.LirSettings()
    -- Close on lose focus
    vim.cmd [[augroup LirCloseOnWinLeave]]
    vim.cmd [[  autocmd!]]
    vim.cmd [[  autocmd WinLeave <buffer> if get(w:, 'lir_is_float', v:false) | call nvim_win_close(0, v:true) | endif]]
    vim.cmd [[augroup END]]
    -- Visual mode marks
    api.nvim_buf_set_keymap(
      0,
      "x",
      "m",
      ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
      { noremap = true, silent = true }
    )

    -- echo cwd
    api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
  end

  vim.cmd [[augroup lir-settings]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
  vim.cmd [[augroup END]]

  -- TODO add to fennec-gruvbox theme
  -- Highlight groups
  -- hi LirFloatNormal guibg=#32302f -- The highlight for float window
  -- Default: `highlight def link LirFloatNormal Normal``

  -- hi LirDir guifg=#7ebae4 -- The highlighting a directory when `devicons_enable` is `false`
  -- Default: `highlight def link LirDir PreProc`

  -- hi LirSymLink guifg=#7c6f64 -- The highlighting for sym links
  -- Default: `highlight def link LirSymLink PreProc`

  -- hi LirEmptyDirText guifg=#7c6f64 -- The highlighting for text to be displayed when the directory is empt
  -- Default: `highlight def link LirEmptyDirText BlueSign`
end

return M
