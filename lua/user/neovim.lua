local M = {}

M.config = function()
  vim.opt.cmdheight = 2
  -- vim.opt.laststatus = 0
  -- vim.g.tpipeline_autoembed = 0

  vim.opt.laststatus = 3
  vim.opt.showtabline = 0
  vim.opt.relativenumber = true
  vim.o.guifont = "JetBrainsMono Nerd Font"
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_length = 0.2
  vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
  -- vim.opt.list = true
  -- vim.opt.listchars:append "eol:"
end

return M
