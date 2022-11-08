local M = {}

M.config = function()
  local status_ok, inc_rename = pcall(require, "inc_rename")
  if not status_ok then
    return
  end

  -- TODO: make a post_hook callback function that calls RenameState in jsx/tsx files?
  -- NOTE: nvim-rename-state doesn't play nice with inc_rename by default.
  -- https://github.com/olrtg/nvim-rename-state
  inc_rename.setup {}
  require("user.keymaps").set_inc_rename_keymaps()
end

return M
