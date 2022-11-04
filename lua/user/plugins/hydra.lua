local M = {}

function M.config()
  require("user.keymaps").set_buffers_keymaps()
  require("user.keymaps").set_windows_keymaps()
  require("user.keymaps").set_gitsigns_keymaps()
end

return M
