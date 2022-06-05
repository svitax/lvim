local M = {}

M.config = function()
  lvim.builtin.terminal.active = true
  lvim.builtin.terminal.execs = {}
  lvim.builtin.terminal.open_mapping = [[<A-t>]]
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
        "<A-a>",
        "<cmd>lua require('user.plugins.toggleterm').toggle_term2()<cr>",
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
        "<A-s>",
        "<cmd>lua require('user.plugins.toggleterm').toggle_term3()<cr>",
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

-- M.toggle_term4 = function()
--   local terminal = require("toggleterm.terminal").Terminal:new {
--     count = 4,
--     close_on_exit = false,
--     hidden = true,
--     -- when the dissapearing linenumber bug is fixed, switch to window
--     direction = "horizontal",
--     on_open = function(term)
--       vim.cmd "startinsert!"
--       vim.api.nvim_buf_set_keymap(
--         term.bufnr,
--         "t",
--         "<A-d>",
--         "<cmd>lua require('user.plugins.toggleterm').toggle_term4()<cr>",
--         { noremap = true, silent = true }
--       )
--       -- esc for normal mode inside terminal
--       vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
--       -- quit with esc in normal mode
--       vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
--       -- this is how you make it so that in a custom terminal you can quit with q
--       vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
--     end,
--   }
--   terminal:toggle()
-- end

-- M.toggle_term5 = function()
--   local terminal = require("toggleterm.terminal").Terminal:new {
--     count = 5,
--     close_on_exit = false,
--     hidden = true,
--     -- when the dissapearing linenumber bug is fixed, switch to window
--     direction = "horizontal",
--     on_open = function(term)
--       vim.cmd "startinsert!"
--       vim.api.nvim_buf_set_keymap(
--         term.bufnr,
--         "t",
--         "<A-f>",
--         "<cmd>lua require('user.plugins.toggleterm').toggle_term5()<cr>",
--         { noremap = true, silent = true }
--       )
--       -- esc for normal mode inside terminal
--       vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
--       -- quit with esc in normal mode
--       vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
--       -- this is how you make it so that in a custom terminal you can quit with q
--       vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
--     end,
--   }
--   terminal:toggle()
-- end

return M
