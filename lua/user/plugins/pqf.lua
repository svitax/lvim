local M = {}

M.config = function()
  local status_ok, pqf = pcall(require, "pqf")
  if not status_ok then
    return
  end

  pqf.setup {}
end

return M
