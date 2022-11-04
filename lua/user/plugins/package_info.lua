local M = {}

M.config = function()
  local status_ok, package_info = pcall(require, "package-info")
  if not status_ok then
    return
  end

  package_info.setup {}
  require("user.keymaps").set_package_info_keymaps()
end

return M
