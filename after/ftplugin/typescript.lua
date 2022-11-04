require("lvim.lsp.manager").setup("emmet_ls", {
  filetypes = { "typescriptreact" },
})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    filetypes = { "typescriptreact" },
  },
  {
    -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
    command = "eslint_d",
    filetypes = { "typescriptreact" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
    command = "eslint_d",
    filetypes = { "typescriptreact" },
  },
}
