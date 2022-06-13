local M = {}

M.config = function()
  local status_ok, bufjump = pcall(require, "bufjump")
  if not status_ok then
    return
  end

  bufjump.setup {}
  require("user.keymaps").set_bufjump_keymaps()
end

return M
