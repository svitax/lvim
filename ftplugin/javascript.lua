-- lvim.lang.javascript.formatters = {
--   {
--     exe = "prettierd",
--   },
--   {
--     exe = "eslint_d",
--   },
-- }
-- lvim.lang.javascript.linters = {
--   {
--     exe = "eslint_d",
--   },
-- }
local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true }
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lF", ":TSLspRenameFile<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lI", ":TSLspImportAll<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lO", ":TSLspOrganize<CR>", opts)

-- local wk = require "which_key"
-- -- better keybindings for ts and tsx files
-- local langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
-- local ftype = vim.bo.filetype
-- if vim.tbl_contains(langs, ftype) then
--   local ts_keys = {
--     ["gA"] = { "<cmd>TSLspImportAll<CR>", "import all" },
--     ["gr"] = { "<cmd>TSLspRenameFile<CR>", "rename file" },
--     ["gS"] = { "<cmd>TSLspOrganize<CR>", "organize imports" },
--   }
--   wk.register(ts_keys, { mode = "n" })
-- end
