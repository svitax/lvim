-- TODO: look into shellcheck codeactions
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { command = "shellcheck", filetypes = { "sh" } },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "shfmt", filetypes = { "sh" } },
  { command = "shellharden", filetypes = { "sh" } },
  -- TODO: look into beautysh
  -- { command = "beautysh", filetypes = { "sh" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "shellcheck",
    extra_args = { "--severity", "warning" },
    filetypes = { "sh" },
  },
}
