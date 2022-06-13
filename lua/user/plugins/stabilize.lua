local M = {}

M.config = function()
  local status_ok, stabilize = pcall(require, "stabilize")
  if not status_ok then
    return
  end

  stabilize.setup {
    ignore = { -- do not manage windows matching these file/buftypes
      filetype = { "help", "list", "Trouble" },
      buftype = { "terminal", "quickfix", "loclist" },
    },
    nested = "QuickFixCmdPost,DiagnosticChanged *",
  }
end

return M
