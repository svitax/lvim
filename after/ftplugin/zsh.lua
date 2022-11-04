-- TODO: look into shellcheck codeactions
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { command = "shellcheck", filetypes = { "zsh" } },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "shfmt", filetypes = { "zsh" } },
  { command = "shellharden", filetypes = { "zsh" } },
  -- TODO: look into beautysh
  -- { command = "beautysh", filetypes = { "zsh" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "shellcheck",
    extra_args = { "--severity", "warning" },
    filetypes = { "zsh" },
  },
  {
    command = "zsh",
    filetypes = { "zsh" },
  },
}
