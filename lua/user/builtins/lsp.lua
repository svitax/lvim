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
end

return M
