local M = {}

M.config = function()
  lvim.builtin.nvimtree.setup.view.side = "left"
  lvim.builtin.nvimtree.show_icons.git = 0
end

return M
