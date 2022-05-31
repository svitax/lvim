local M = {}

M.config = function()
  local ok, marks = pcall(require, "marks")
  if not ok then
    return
  end

  marks.setup {}
end

return M
