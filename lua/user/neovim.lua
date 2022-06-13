local M = {}

M.config = function()
  vim.opt.laststatus = 3
  vim.opt.showtabline = 0
  vim.opt.relativenumber = true
  vim.o.guifont = "JetBrainsMono Nerd Font"
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_length = 0.2
  vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
  -- vim.opt.list = true
  -- vim.opt.listchars:append "eol:"

  vim.wo.foldlevel = 4
  -- vim.wo.foldtext =
  --   [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.wo.foldnestmax = 3
  vim.wo.foldminlines = 1
  vim.cmd [[set foldmethod=expr]]
  vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
end

return M
