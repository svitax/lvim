local M = {}

M.config = function()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    return
  end

  dressing.setup {
    input = {
      enabled = true,
      winblend = 0,
      override = function(conf)
        conf = {
          relative = "cursor",
          anchor = "SW",
          border = "rounded",
          height = 1,
          style = "minimal",
          -- noautocmd = true,
          row = 1,
          col = 0,
          width = 20,
        }
        return conf
      end,
    },
    select = {
      telescope = require("telescope.themes").get_ivy {},
    },
  }
end

return M
