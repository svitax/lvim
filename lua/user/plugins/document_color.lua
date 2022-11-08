local M = {}

M.config = function()
  local status_ok, document_colors = pcall(require, "document-color")
  if not status_ok then
    return
  end

  document_colors.setup {
    mode = "background", -- "background" | "foreground" | "single"
  }
end

return M
