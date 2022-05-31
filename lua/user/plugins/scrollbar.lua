local M = {}

M.config = function()
  local ok, scrollbar = pcall(require, "scrollbar")
  if not ok then
    return
  end

  scrollbar.setup {}
  require("scrollbar.handlers.search").setup()
end

return M
