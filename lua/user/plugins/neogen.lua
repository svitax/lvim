local M = {}

M.config = function()
  local status_ok, neogen = pcall(require, "neogen")
  if not status_ok then
    return
  end

  neogen.setup {}
  require("user.keymaps").set_neogen_keymaps()
end

return M
