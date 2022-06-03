local M = {}

M.config = function()
  local status_ok, litee = pcall(require, "litee")
  if not status_ok then
    return
  end

  -- local gh_ok, gh = pcall(require, "litee.gh")
  -- if not gh_ok then
  --   return
  -- end

  -- local lib_ok, lib = pcall(require, "litee.lib")
  -- if not lib_ok then
  --   return
  -- end

  require("litee.lib").setup {
    tree = {
      icon_set = "default",
    },
    panel = {
      orientation = "right",
      panel_size = 40,
    },
  }
  require("litee.gh").setup {}
end

return M
