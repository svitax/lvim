local M = {}

M.config = function()
  local status_ok, package_info = pcall(require, "package-info")
  if not status_ok then
    return
  end

  package_info.setup {}
  -- NOTE: I've set this to be registered only when we enter a .json file.
  -- require("user.keymaps").set_package_info_keymaps()
end

return M
