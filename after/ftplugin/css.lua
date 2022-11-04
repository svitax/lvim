require("lvim.lsp.manager").setup("emmet_ls", {
  filetypes = { "css" },
})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    filetypes = { "css" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "stylelint",
    filetypes = { "css" },
  },
}
