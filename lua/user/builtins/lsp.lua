local M = {}

M.config = function()
  lvim.lsp.diagnostics.signs.values = {
    -- { name = "LspDiagnosticsSignError", text = " " },
    -- { name = "LspDiagnosticsSignWarning", text = "" },
    -- { name = "LspDiagnosticsSignHint", text = "" },
    -- { name = "LspDiagnosticsSignInformation", text = "" },
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn", text = " " },
    { name = "DiagnosticSignHint", text = " " },
    { name = "DiagnosticSignInfo", text = " " },
  }
  lvim.lsp.diagnostics.virtual_text = false
  lvim.lsp.document_highlight = true
  lvim.lsp.code_lens_refresh = true
  lvim.lsp.automatic_servers_installation = false

  vim.diagnostic.config {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
end

return M
