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
  }
end

return M
