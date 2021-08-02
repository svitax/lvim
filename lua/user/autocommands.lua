local M = {}

M.config = function()
  -- NOTE: Autocommands (https://neovim.io/doc/user/autocmd.html)
  lvim.autocommands.custom_groups = {
    { "BufWinEnter", "*.md", "set nospell" },
    -- { "BufWinEnter", "vimwiki", "set nospell" },
    -- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
  }
end

return M
