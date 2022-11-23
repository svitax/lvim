local M = {}

M.config = function()
  local status_ok, fm = pcall(require, "fm-nvim")
  if not status_ok then
    return
  end

  fm.setup {
    -- edit_cmd = "edit",
    -- ui = {
    --   default = "float",
    --   float = {
    --     border = "rounded",
    --     height = 0.90,
    --     width = 0.90,
    --   },
    -- },
  }
  require("user.keymaps").set_fm_keymaps()
end

return M
