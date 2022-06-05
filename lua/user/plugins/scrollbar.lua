local M = {}

M.config = function()
  local status_ok, scrollbar = pcall(require, "scrollbar")
  if not status_ok then
    return
  end

  scrollbar.setup {}
  require("scrollbar.handlers.search").setup()
end

return M
