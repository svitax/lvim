local M = {}

M.config = function()
  local status_ok, trouble = pcall(require, "trouble")
  if not status_ok then
    return
  end

  trouble.setup {}
  require("user.keymaps").set_trouble_keymaps()
end

return M
