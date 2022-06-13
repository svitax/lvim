local M = {}

M.config = function()
  local status_ok, marks = pcall(require, "marks")
  if not status_ok then
    return
  end

  marks.setup {}
  require("user.keymaps").set_marks_keymaps()
end

return M
