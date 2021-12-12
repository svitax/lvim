local M = {}

M.config = function()
  -- lvim.builtin.terminal.open_mapping = [[…]] -- alt+; in macos
  -- lvim.builtin.terminal.open_mapping = [[<C-t>]]
  lvim.builtin.terminal.open_mapping = [[<A-g>]]

  -- vim.cmd [[nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>]]

  lvim.builtin.terminal.execs = {
    -- { "lazygit", "gg", "LazyGit" },
    -- { "cobib", "ob", "Bibliography (Cobib)" },
  }
  -- lvim.builtin.terminal.size = vim.fn.float2nr(vim.o.lines * 0.33)
  lvim.builtin.terminal.size = 15
  -- lvim.builtin.terminal.float_opts.width = vim.fn.float2nr(vim.o.columns * 0.99)
  -- lvim.builtin.terminal.float_opts.height = vim.fn.float2nr(vim.o.lines * 0.87)
  -- lvim.builtin.terminal.float_opts.winblend = 10
  lvim.builtin.terminal.float_opts.winblend = lvim.winblend
  lvim.builtin.terminal.float_opts.highlights.border = "Comment"
  lvim.builtin.terminal.shade_terminals = false
  -- lvim.builtin.terminal.direction = "window"
end

M.forgit_diff = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    cmd = "git diff",
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "tab",
    close_on_exit = false,
    on_open = function(term)
      -- quit with esc in terminal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- quit with q in terminal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    hidden = true,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = false,
  }
  terminal:toggle()
end

M.forgit_add = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    cmd = "git add",
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "tab",
    close_on_exit = false,
    on_open = function(term)
      -- quit with esc in terminal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- quit with q in terminal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    hidden = true,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = false,
  }
  terminal:toggle()
end

M.forgit_log = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    cmd = "git log",
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "tab",
    close_on_exit = false,
    on_open = function(term)
      -- quit with esc in terminal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- quit with q in terminal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    hidden = true,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = false,
  }
  terminal:toggle()
end

M.lazy_git = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    cmd = "lazygit",
    close_on_exit = true,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "tab",
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = false,
  }
  terminal:toggle()
end

M.toggle_term2 = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    count = 2,
    close_on_exit = false,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "horizontal",
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<A-h>",
        "<cmd>lua require('user.builtins.toggleterm').toggle_term2()<cr>",
        { noremap = true, silent = true }
      )
      -- esc for normal mode inside terminal
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      -- quit with esc in normal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }
  terminal:toggle()
end

M.toggle_term3 = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    count = 3,
    close_on_exit = false,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "horizontal",
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<A-d>",
        "<cmd>lua require('user.builtins.toggleterm').toggle_term3()<cr>",
        { noremap = true, silent = true }
      )
      -- esc for normal mode inside terminal
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      -- quit with esc in normal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }
  terminal:toggle()
end

M.toggle_term4 = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    count = 4,
    close_on_exit = false,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "horizontal",
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<A-s>",
        "<cmd>lua require('user.builtins.toggleterm').toggle_term4()<cr>",
        { noremap = true, silent = true }
      )
      -- esc for normal mode inside terminal
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      -- quit with esc in normal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }
  terminal:toggle()
end

M.toggle_term5 = function()
  local terminal = require("toggleterm.terminal").Terminal:new {
    count = 5,
    close_on_exit = false,
    hidden = true,
    -- when the dissapearing linenumber bug is fixed, switch to window
    direction = "horizontal",
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<A-a>",
        "<cmd>lua require('user.builtins.toggleterm').toggle_term5()<cr>",
        { noremap = true, silent = true }
      )
      -- esc for normal mode inside terminal
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      -- quit with esc in normal mode
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
      -- this is how you make it so that in a custom terminal you can quit with q
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
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
