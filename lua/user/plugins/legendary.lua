local M = {}

M.config = function()
  local status_ok, legendary = pcall(require, "legendary")
  if not status_ok then
    return
  end

  legendary.setup {}
  require("user.keymaps").set_legendary_keymaps()
end

return M
