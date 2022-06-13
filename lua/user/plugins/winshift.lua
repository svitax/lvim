local M = {}

M.config = function()
  local status_ok, winshift = pcall(require, "winshift")
  if not status_ok then
    return
  end

  winshift.setup {}
  require("user.keymaps").set_winshift_keymaps()
end

return M
