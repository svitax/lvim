local M = {}

M.run = function()
  vim.fn["fzf#install"]()
end

return M
