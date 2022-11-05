local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").stylua,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").selene,
  -- require("user.lsp.linters").luacheck,
}
