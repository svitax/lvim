local M = {}

M.config = function()
  local status_ok, markdown_preview = pcall(require, "markdown-preview")
  if not status_ok then
    return
  end

  vim.g.mkdp_filetypes = { "markdown" }
  -- markdown_preview.setup {}
  require("user.keymaps").set_markdown_preview_keymaps()
end

return M
