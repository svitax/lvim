-- make a command :Chmod: Change the permissions of the current file.
-- make a filter/search command

-- lir can't handle opening paths with ~ the first time round
-- once I close the buffer and redo the command, it works once then it stops working again
-- symlinking to avoid having a path with ~s lets be open the directory consistently

return function()
  local status_ok, lir = pcall(require, "lir")
  if not status_ok then
    return
  end

  local api = vim.api

  local actions = require "lir.actions"
  local mark_actions = require "lir.mark.actions"
  local clipboard_actions = require "lir.clipboard.actions"

  local edit_nosplit = require "user.lir.actions.edit_nosplit"
  local input_newfile = require "user.lir.actions.input_newfile"
  local gomi = require "user.lir.actions.gomi"
  local goto_git_root = require "user.lir.actions.goto_git_root"
  local home = require "user.lir.actions.home"

  local open_terminal = require "user.lir.actions.open_terminal"

  local bkm_actions = require "lir.bookmark.actions"

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
      ["d"] = gomi.wipeout,
      ["D"] = gomi.wipeout_marked,
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
      ["M"] = require("lir.mmv.actions").mmv,
      -- ["n"] = ""
      -- ["o"] = ""
      ["P"] = clipboard_actions.paste,
      ["q"] = actions.quit,
      ["r"] = actions.rename,
      ["S"] = actions.split,
      ["t"] = open_terminal, -- make this open a toggleterm in the cwd
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
      -- ["<space>"] = function()
      --   mark_actions.toggle_mark()
      --   vim.cmd "normal! j"
      -- end,
    },
    float = {
      winblend = lvim.winblend,
      win_opts = require("user.lir.utils").construct_win_opts,
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
      lir = {
        icon = "",
        color = "#6d8086",
        name = "lir",
      },
    },
  }

  -- use visual mode to mark files in lir
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
    -- api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
  end

  vim.cmd [[augroup lir-settings]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
  vim.cmd [[augroup END]]
end
