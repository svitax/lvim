local M = {}

M.config = function()
  vim.opt.timeoutlen = 200
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 20
  vim.opt.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.opt.fillchars = "fold: "
  vim.opt.foldnestmax = 3
  vim.opt.foldminlines = 1
  vim.opt.showtabline = 0
  vim.opt.relativenumber = true
  -- vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
  -- vim.opt.pumblend = 10 -- Popup blend auto_open
end

return M
