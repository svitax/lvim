local M = {}

M.config = function()
  local status_ok, lazygit = pcall(require, "lazygit")
  if not status_ok then
    return
  end

  require("user.keymaps").set_lazygit_keymaps()
end

return M
