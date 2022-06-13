local M = {}

M.config = function()
  local status_ok, textcase = pcall(require, "textcase")
  if not status_ok then
    return
  end

  textcase.setup {}
  require("user.keymaps").set_textcase_keymaps()
end

return M
