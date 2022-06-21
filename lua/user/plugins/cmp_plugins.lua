local M = {}

M.config = function()
  local status_ok, cmp_plugins = pcall(require, "cmp-plugins")
  if not status_ok then
    return
  end

  cmp_plugins.setup {
    files = { "plugins.lua" }, -- default
  }
end

return M
