require("lvim.lsp.manager").setup("emmet_ls", {
  filetypes = { "javascript" },
})

-- TODO: look into xo and eslint_d codeactions
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   { command = "xo", filetypes = { "javascript" } },
--   {
--     -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
--     command = "eslint_d",
--     filetypes = { "javascript" },
--   },
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    filetypes = { "javascript" },
  },
  {
    -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
    command = "eslint_d",
    filetypes = { "javascript" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
    command = "eslint_d",
    filetypes = { "javascript" },
  },
  --   { command = "xo", filetypes = { "javascript" } },
}
