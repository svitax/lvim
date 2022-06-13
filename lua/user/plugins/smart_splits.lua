local M = {}

M.config = function()
  local status_ok, smart_splits = pcall(require, "smart-splits")
  if not status_ok then
    return
  end

  smart_splits.setup {}
  require("user.keymaps").set_smart_splits_keymaps()
end

return M
