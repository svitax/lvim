local M = {}

M.config = function()
  --   -- vim lastplace like functionality
  --   vim.cmd [[
  --   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  -- ]]
  -- NOTE Autocommands (https://neovim.io/doc/user/autocmd.html)
  lvim.autocommands.custom_groups = {
    { "BufWinEnter", ".sol", "setlocal filetype=solidity" },
    { "BufRead", "*.sol", "setlocal filetype=solidity" },
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
    { "CursorHold", "*", "lua require 'nvim-lightbulb'.update_lightbulb()" },
    { "CursorHoldI", "*", "lua require 'nvim-lightbulb'.update_lightbulb()" },
    -- * lua require'nvim-lightbulb'.update_lightbulb()]]

    { "bufwritepost", ".tmux.conf", "execute ':!tmux source-file %'" },
    { "bufwritepost", ".tmux.local.conf", "execute ':!tmux source-file %'" },
    -- # autocmd bufwritepost .tmux.conf execute ':!tmux source-file %'
    -- # autocmd bufwritepost .tmux.local.conf execute ':!tmux source-file %'

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
  }
end

return M
