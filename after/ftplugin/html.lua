local emmet_opts = require "user.lsp.emmet_ls"
require("lvim.lsp.manager").setup("emmet_ls", emmet_opts)

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").prettierd,
  require("user.lsp.formatters").rustywind,
}
