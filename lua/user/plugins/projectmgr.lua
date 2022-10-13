local M = {}

M.config = function()
  local status_ok, projectmgr = pcall(require, "projectmgr")
  if not status_ok then
    return
  end

  projectmgr.setup {
    -- session = { enabled = false, file = "Session.vim" },
    -- shada = { enabled = true, file = "main.shada" },
  }
end

return M
