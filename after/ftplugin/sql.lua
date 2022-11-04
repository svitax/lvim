require("lvim.lsp.manager").setup "sqls"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "sqlfluff", filetypes = { "sql" }, extra_args = { "--dialect", "postgres" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "sqlfluff", filetypes = { "sql" }, extra_args = { "--dialect", "postgres" } },
}
