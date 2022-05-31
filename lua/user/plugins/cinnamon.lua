local M = {}

M.config = function()
  local status_ok, cinnamon = pcall(require, "cinnamon")
  if not status_ok then
    return
  end

  cinnamon.setup { extra_keymaps = true, scroll_limit = 100 }
end

return M
