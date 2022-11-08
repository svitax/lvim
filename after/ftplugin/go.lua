local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").gofumpt,
  require("user.lsp.formatters").golines,
}

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
-- require("user.lsp.linters").golangci_lint,
-- }
