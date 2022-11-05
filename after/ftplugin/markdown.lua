require("lvim.lsp.manager").setup "marksman"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").prettierd,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").markdownlint,
}
