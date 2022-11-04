require("lvim.lsp.manager").setup("emmet_ls", {
  filetypes = { "html" },
})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    filetypes = { "html" },
  },
  { command = "rustywind", filetypes = { "html" } },
}
