local M = {}

M.config = function()
  --   -- vim lastplace like functionality
  --   vim.cmd [[
  --   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  -- ]]
  -- NOTE Autocommands (https://neovim.io/doc/user/autocmd.html)
  lvim.autocommands.custom_groups = {
    { "BufEnter", "*.md", "setlocal conceallevel=2" },
    -- { "BufEnter", "*.norg", "setlocal conceallevel=2" },
    { "FileType", "spectre_panel", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "harpoon", "nnoremap <silent> <buffer> q :q<CR>" },
    -- { "BufEnter", "*.md", "setlocal spell" },
    -- { "BufEnter", "*.md", "setlocal spellcapcheck=" },
    -- { "BufEnter", "*.norg", "setlocal spell" },
    -- { "BufEnter", "*.norg", "setlocal spellcapcheck=" },
    -- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
    -- { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics()" },

    -- python
    --     {
    --       "Filetype",
    --       "python",
    --       "nnoremap <leader>R <cmd>lua require('core.terminal')._exec_toggle('python " .. vim.fn.expand "%" .. ";read')<CR>",
    --     },
    --     {
    --       "Filetype",
    --       "python",
    --       "nnoremap <leader>M <cmd>lua require('core.terminal')._exec_toggle('echo \"compile :pepelaugh:\";read')<CR>",
    --     },

    -- javascript
    {
      "Filetype",
      "javascript",
      "nnoremap <leader>lF <cmd>TSLspRenameFile<CR>",
    },
    {
      "Filetype",
      "javascript",
      "nnoremap <leader>lO <cmd>TSLspOrganize<CR>",
    },
    {
      "Filetype",
      "javascript",
      "nnoremap <leader>lI <cmd>TSLspImportAll<CR>",
    },

    -- javascriptreact
    {
      "Filetype",
      "javascriptreact",
      "nnoremap <leader>lF <cmd>TSLspRenameFile<CR>",
    },
    {
      "Filetype",
      "javascriptreact",
      "nnoremap <leader>lO <cmd>TSLspOrganize<CR>",
    },
    {
      "Filetype",
      "javascriptreact",
      "nnoremap <leader>lI <cmd>TSLspImportAll<CR>",
    },

    -- typescript
    {
      "Filetype",
      "typescript",
      "nnoremap <leader>lF <cmd>TSLspRenameFile<CR>",
    },
    {
      "Filetype",
      "typescript",
      "nnoremap <leader>lO <cmd>TSLspOrganize<CR>",
    },
    {
      "Filetype",
      "typescript",
      "nnoremap <leader>lI <cmd>TSLspImportAll<CR>",
    },

    -- typescriptreact
    {
      "Filetype",
      "typescriptreact",
      "nnoremap <leader>lF <cmd>TSLspRenameFile<CR>",
    },
    {
      "Filetype",
      "typescriptreact",
      "nnoremap <leader>lO <cmd>TSLspOrganize<CR>",
    },
    {
      "Filetype",
      "typescriptreact",
      "nnoremap <leader>lI <cmd>TSLspImportAll<CR>",
    },
  }
end

return M
