local M = {}

M.config = function()
  local status_ok, neodim = pcall(require, "neodim")
  if not status_ok then
    return
  end

  neodim.setup {
    blend_color = "#282828",
    alpha = 0.60,
  }
end

return M
