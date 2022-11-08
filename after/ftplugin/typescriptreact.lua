-- TODO: look into xo and eslint_d codeactions
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   require("user.lsp.code_actions").eslintd,
--   require("user.lsp.code_actions").xo,
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").prettierd,
  require("user.lsp.formatters").eslintd,
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  require("user.lsp.linters").eslintd,
  require("user.lsp.linters").tsc,
  -- require("user.lsp.linters").xo,
}

local utils = require "user.utils"

if utils.project_has_tailwindcss_dependency() then
  local tailwind_opts = require "user.lsp.tailwindcss"
  require("lvim.lsp.manager").setup("tailwindcss", tailwind_opts)

  formatters.setup {
    require("user.lsp.formatters").rustywind,
  }
end

if utils.is_web_project() then
  local emmet_opts = require "user.lsp.emmet_ls"
  require("lvim.lsp.manager").setup("emmet_ls", emmet_opts)
end

require("user.keymaps").set_typescript_keymaps()
