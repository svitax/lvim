local M = {}

M.config = function()
  -- local status_ok, code_action_menu = pcall(require, "nvim-code-action-menu")
  -- if not status_ok then
  --   return
  -- end

  -- code_action_menu.setup {}
  require("user.keymaps").set_code_action_menu_keymaps()
end

return M
