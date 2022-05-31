local M = {}

M.config = function()
  local status_ok, marks = pcall(require, "marks")
  if not status_ok then
    return
  end

  marks.setup {}
end

return M
