local M = {}

M.config = function()
  local status_ok, inc_rename = pcall(require, "inc_rename")
  if not status_ok then
    return
  end

  inc_rename.setup {}
  require("user.keymaps").set_inc_rename_keymaps()
end

return M
