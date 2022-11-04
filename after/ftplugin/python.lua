local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "pylint", filetypes = { "python" } },
  -- { command = "flake8", filetypes = { "python" } },
  -- { command = "mypy", filetypes = { "python" }, extra_args = { "--strict" } },
}
