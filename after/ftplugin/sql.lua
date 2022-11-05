require("lvim.lsp.manager").setup "sqls"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").sqlfluff,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").stylelint,
}
