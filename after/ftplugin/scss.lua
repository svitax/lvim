local cssls_opts = require "user.lsp.cssls"
require("lvim.lsp.manager").setup("cssls", cssls_opts)

local emmet_opts = require "user.lsp.emmet_ls"
require("lvim.lsp.manager").setup("emmet_ls", emmet_opts)

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").prettierd,
  require("user.lsp.formatters").stylelint,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").stylelint,
}
