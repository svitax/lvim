local M = {}

M.config = function()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    return
  end

  dressing.setup {
    input = {
      enabled = false,
    },
    select = {
      telescope = require("telescope.themes").get_ivy {},
    },
  }
end

return M
