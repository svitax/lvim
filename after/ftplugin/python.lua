local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").black,
  require("user.lsp.formatters").isort,
  require("user.lsp.formatters").reorder_python_imports,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").pylint,
  require("user.lsp.linters").flake8,
  require("user.lsp.linters").mypy,
  require("user.lsp.linters").pydocstyle,
  require("user.lsp.linters").pylama,
  require("user.lsp.linters").vulture,
}
