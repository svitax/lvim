local M = {}

M.config = function()
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  nls.config {
    debounce = 150,
    save_after_format = false,
    sources = {
      -- nls.builtins.code_actions.gitsigns,
      -- nls.builtins.hover.dictionary,
      -----[[------------]]-----
      ---     Formatting     ---
      -----]]------------[[-----
      nls.builtins.formatting.black.with { extra_args = { "--fast" } }, -- args = { "--fast" }
      -- nls.builtins.formatting.cmake_format,
      nls.builtins.formatting.eslint_d.with {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      },
      -- nls.builtins.formatting.fnlfmt,
      nls.builtins.formatting.fixjson,
      nls.builtins.formatting.gofumpt,
      -- nls.builtins.formatting.goimports,
      nls.builtins.formatting.golines,
      nls.builtins.formatting.isort.with { extra_args = { "--profile", "black" } }, -- args = {"--profile"}, {"black"}
      -- nls.builtins.formatting.json_tool,
      nls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "css",
          "scss",
          "html",
          -- "json",
          "yaml",
          "markdown",
        },
      },
      -- nls.builtins.formatting.rustywind,
      -- nls.builtins.formatting.scalafmt,
      nls.builtins.formatting.shellharden,
      nls.builtins.formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } },
      nls.builtins.formatting.stylelint.with {
        filetypes = { "scss", "less", "css", "sass" },
      },
      nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.sqlformat,
      nls.builtins.formatting.taplo,
      -- nls.builtins.formatting.terraform_fmt,
      -- nls.builtins.formatting.trim_newlines.with {filetypes = {"go"}}
      -- nls.builtins.formatting.trim_whitespace.with {filetypes = {"go"}}
      -- nls.builtins.formatting.yapf

      -----[[------------]]-----
      ---     Diagnostics    ---
      -----]]------------[[-----
      -- nls.builtins.diagnostics.chktex,
      nls.builtins.diagnostics.eslint_d.with {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      },
      -- nls.builtins.diagnostics.flake8,
      -- nls.builtins.diagnostics.golangci_lint,
      nls.builtins.diagnostics.hadolint,
      -- nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.markdownlint,
      -- nls.builtins.diagnostics.mypy,
      nls.builtins.diagnostics.pylint,
      -- nls.builtins.diagnostics.pylama,
      -- nls.builtins.diagnostics.revive,
      nls.builtins.diagnostics.selene.with { filetypes = { "lua" } },
      nls.builtins.diagnostics.shellcheck,
      -- nls.builtins.diagnostics.staticcheck,
      nls.builtins.diagnostics.stylelint.with {
        filetypes = { "scss", "less", "css", "sass" },
      },
      -- nls.builtins.diagnostics.vale,
      nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.yamllint,

      -----[[------------]]-----
      ---    Code Actions    ---
      -----]]------------[[-----
      -- nls.builtins.code_actions.eslint_d,
      -- nls.builtins.code_actions.refactoring,
    },
  }
end

return M

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   {
--     exe = "prettier",
--     filetypes = {
--       "javascriptreact",
--       "javascript",
--       "typescriptreact",
--       "typescript",
--       "json",
--       "markdown",
--     },
--   },
--   {

--   }
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   {
--     exe = "eslint",
--     filetypes = {
--       "javascriptreact",
--       "javascript",
--       "typescriptreact",
--       "typescript",
--       "vue",
--     },
--   },
-- }
