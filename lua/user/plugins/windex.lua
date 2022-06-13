local M = {}

M.config = function()
  local status_ok, windex = pcall(require, "windex")
  if not status_ok then
    return
  end

  windex.setup {
    default_keymaps = false,
  }
  require("user.keymaps").set_windex_keymaps()
end

return M
