local M = {}

M.config = function()
  -- lvim.builtin.terminal.open_mapping = [[…]] -- alt+; in macos
  lvim.builtin.terminal.open_mapping = [[<C-t>]]
  lvim.builtin.terminal.execs = {
    { "lazygit", "gg", "LazyGit" },
    -- { "cobib", "ob", "Bibliography (Cobib)" },
    -- TODO sometimes different from just opening up a terminal and running gomi --restore, find out why and fix
    -- { "gomi --restore", "fr", "Restore deleted files (Gomi)" },
  }
  -- lvim.builtin.terminal.float_opts.width = vim.fn.float2nr(vim.o.columns * 0.99)
  -- lvim.builtin.terminal.float_opts.height = vim.fn.float2nr(vim.o.lines * 0.87)
  -- lvim.builtin.terminal.float_opts.winblend = 10
  lvim.builtin.terminal.float_opts.winblend = lvim.winblend
  lvim.builtin.terminal.float_opts.highlights.border = "Comment"
  lvim.builtin.terminal.shade_terminals = false
end

-- emacsclient -nw -e '(magit-status)' <cr>"
M.magit = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    cmd = "emacsclient -nw -e '(magit-status)'",
    close_on_exit = true,
    hidden = false,
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }
  return terminal
end

M._toggle_magit = function()
  magit = M.magit()
  magit:toggle()
end

-- An example of what a custom terminal would look like
-- M.algoexpert_runner = function()
--   vim.cmd "Neorg tangle"
--   -- <cmd>TermExec direction='horizontal' size=10 cmd='clear && python3 "temp.py" && rm "temp.py"'<cr>]],
--   local terminal = require("toggleterm.terminal").Terminal:new {
--     cmd = "clear && python3 'temp.py' && rm 'temp.py'",
--     close_on_exit = false,
--     hidden = true,
--     go_back = true,
--     direction = "horizontal",
--     on_open = function(term)
--       vim.cmd "startinsert!"
--       -- this is how you make it so that in a custom terminal you can quit with q
--       vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
--     end,
--   }
--   terminal:open(7)
-- end

return M
