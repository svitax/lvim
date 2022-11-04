require("lvim.lsp.manager").setup "marksman"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    extra_args = { "--print-with", "100" },
    filetypes = { "markdown" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "markdownlint", filetypes = { "markdown" }, extra_args = { "--disable", "MD013", "MD010" } },
}
