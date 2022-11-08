local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").prettierd,
}

require("user.keymaps").set_package_info_keymaps()
