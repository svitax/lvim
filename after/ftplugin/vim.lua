local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").vint,
}
