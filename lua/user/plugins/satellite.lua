local M = {}

M.config = function()
  local status_ok, satellite = pcall(require, "satellite")
  if not status_ok then
    return
  end

  satellite.setup {
    handlers = {
      marks = {
        enable = false,
      },
    },
  }
end

return M
