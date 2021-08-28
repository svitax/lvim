local M = {}

M.config = function()
  -- lvim.builtin.terminal.open_mapping = [[…]] -- alt+; in macos
  -- lvim.builtin.terminal.open_mapping = [[<C-t>]]
  lvim.builtin.terminal.open_mapping = [[<A-1>]]

  -- vim.cmd [[nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>]]

  lvim.builtin.terminal.execs = {
    { "lazygit", "gg", "LazyGit" },
    -- { "cobib", "ob", "Bibliography (Cobib)" },
  }
  -- lvim.builtin.terminal.float_opts.width = vim.fn.float2nr(vim.o.columns * 0.99)
  -- lvim.builtin.terminal.float_opts.height = vim.fn.float2nr(vim.o.lines * 0.87)
  -- lvim.builtin.terminal.float_opts.winblend = 10
  lvim.builtin.terminal.float_opts.winblend = lvim.winblend
  lvim.builtin.terminal.float_opts.highlights.border = "Comment"
  lvim.builtin.terminal.shade_terminals = false
  -- lvim.builtin.terminal.direction = "window"
end

M.toggle_term2 = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    count = 2,
    size = 100,
    close_on_exit = false,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "horizontal",
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<A-2>",
        "<cmd>lua require('user.toggleterm').toggle_term2()<cr>",
        { noremap = true, silent = true }
      )
      -- quit with esc
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
  }
  terminal:toggle()
end

M.toggle_term3 = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    count = 3,
    size = 100,
    close_on_exit = false,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "horizontal",
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<A-3>",
        "<cmd>lua require('user.toggleterm').toggle_term3()<cr>",
        { noremap = true, silent = true }
      )
      -- quit with esc
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
  }
  terminal:toggle()
end

M.restore_files = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    cmd = "gomi --restore",
    close_on_exit = true,
    hidden = true,
    direction = "horizontal",
    size = 15,
    on_open = function(term)
      vim.cmd "startinsert!"
      -- quit with esc
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
  }
  terminal:toggle()
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
  local magit = M.magit()
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
