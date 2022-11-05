-- local bashls_opts = require "user.lsp.bashls"
-- require("lvim.lsp.manager").setup("bashls", bashls_opts)

-- -- TODO: look into shellcheck codeactions
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   require("user.lsp.code_actions").shellcheck,
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").shfmt,
  require("user.lsp.formatters").shellharden,
  -- require("user.lsp.formatters").beautysh,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").shellcheck,
}
