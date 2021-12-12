local M = {}

M.config = function()
  --   -- vim lastplace like functionality
  --   vim.cmd [[
  --   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  -- ]]
  -- NOTE Autocommands (https://neovim.io/doc/user/autocmd.html)
  -- BufEnter *.tex :lua require('texwhichkey')]], false
  lvim.autocommands.custom_groups = {
    -- { "BufEnter", "*.json", ":lua require('user.autocommands').json_package_mappings()" },
    { "BufWinEnter", ".sol", "setlocal filetype=solidity" },
    { "BufRead", "*.sol", "setlocal filetype=solidity" },
    { "BufEnter", "*.md", "setlocal conceallevel=2" },
    { "BufEnter", "*.md", "nnoremap <silent> <buffer> <cr> :WikiLinkFollow<CR>" },
    -- vim.api.nvim_buf_set_keymap("n", "<cr>", "", { noremap = false })

    -- { "BufEnter", "*.norg", "setlocal conceallevel=2" },
    { "FileType", "spectre_panel", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "harpoon", "nnoremap <silent> <buffer> q :q<CR>" },
    -- { "BufEnter", "*.md", "setlocal spell" },
    -- { "BufEnter", "*.md", "setlocal spellcapcheck=" },
    -- { "BufEnter", "*.norg", "setlocal spell" },
    -- { "BufEnter", "*.norg", "setlocal spellcapcheck=" },

    { "FileType", "org", "setlocal conceallevel=2" },

    -- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
    -- { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics()" },

    -- { "CursorHold", "*", "lua require 'nvim-lightbulb'.update_lightbulb({sign={enabled=true}})" },
    -- { "CursorHoldI", "*", "lua require 'nvim-lightbulb'.update_lightbulb({sign={enabled=true}})" },
    -- { "CursorHoldI", "*", "lua require 'nvim-lightbulb'.update_lightbulb()" },
    -- * lua require'nvim-lightbulb'.update_lightbulb()]]

    { "BufWritePost", ".tmux.conf", "execute ':!tmux source-file %'" },
    { "BufWritePost", ".tmux.local.conf", "execute ':!tmux source-file %'" },
    -- # autocmd bufwritepost .tmux.conf execute ':!tmux source-file %'
    -- # autocmd bufwritepost .tmux.local.conf execute ':!tmux source-file %'

    -- python
    --     {
    --       "Filetype",
    --       "python",
    --       "nnoremap <leader>R <cmd>lua require('lvim.lvim.core.terminal')._exec_toggle('python " .. vim.fn.expand "%" .. ";read')<CR>",
    --     },
    --     {
    --       "Filetype",
    --       "python",
    --       "nnoremap <leader>M <cmd>lua require('lvim.lvim.core.terminal')._exec_toggle('echo \"compile :pepelaugh:\";read')<CR>",
    --     },
  }
end

return M
