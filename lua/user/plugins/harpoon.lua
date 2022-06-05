local M = {}

M.config = function()
  local status_ok, harpoon = pcall(require, "harpoon")
  if not status_ok then
    return
  end

  harpoon.setup {
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
    },
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  }
  require("telescope").load_extension "harpoon"
end

return M
