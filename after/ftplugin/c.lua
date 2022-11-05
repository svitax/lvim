local clangd_opts = require "user.lsp.clangd"
require("lspconfig").clangd.setup { clangd_opts }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").uncrustify,
  -- require("user.lsp.formatters").clang_format,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").cppcheck,
  -- require("user.lsp.linters").gccidag,
}
