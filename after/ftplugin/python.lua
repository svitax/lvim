local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  -- { command = "reorder_python_imports", filetypes = { "python" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "pylint", filetypes = { "python" } },
  -- { command = "flake8", filetypes = { "python" } },
  -- { command = "mypy", filetypes = { "python" }, extra_args = { "--strict" } },
  -- { command = "pydocstyle", filetypes = { "python" } },
  -- { command = "pylama", filetypes = { "python" } },
  -- { command = "vulture", filetypes = { "python" } },
}
