local M = {}

M.config = function()
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end
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
      -- nls.builtins.formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } },
      -- nls.builtins.formatting.shellharden,
      nls.builtins.formatting.stylelint.with {
        filetypes = { "scss", "less", "css", "sass" },
      },
      nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.sqlformat,
      -- nls.builtins.formatting.terraform_fmt,
      -----[[------------]]-----
      ---     Diagnostics    ---
      -----]]------------[[-----
      nls.builtins.diagnostics.eslint_d.with {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      },
      -- nls.builtins.diagnostics.chktex,
      -- nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.stylelint.with {
        filetypes = { "scss", "less", "css", "sass" },
      },
      -- nls.builtins.diagnostics.vale,
      -- nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.yamllint,
    },
  }

  -- WARN: do not redfine or reuse formatter/linters in this format
  -- or use the lang specific format

  -- Formatters
  -- ==================================================================
  lvim.lang.sh.formatters = {
    { exe = "shfmt", args = { "-i", "2", "-ci" } },
    { exe = "shellharden" },
  }
  lvim.lang.python.linters = { { exe = "flake8" } }
  -- lvim.lang.markdown.linters = {
  --   { exe = "markdownlint" },
  --   -- { exe = "vale", },
  -- }
  -- lvim.lang.python.formatters = {
  --   { exe = "black", args = { "--fast" } },
  --   { exe = "isort", args = { "--profile", "black" } },
  -- }
  -- lvim.lang.sh.linters = { { exe = "shellcheck" } }
  -- -- lvim.lang.asm.formatters = { { exe = "asmfmt" } }
  -- -- lvim.lang.cmake.formatters = { { exe = "cmake_format" } }
  -- lvim.lang.css.formatters = { { exe = "prettierd" } }
  -- -- lvim.lang.dockerfile.linters = { { exe = "hadolint" } }
  -- lvim.lang.go.formatters = {
  --   -- @usage gofmt or gofumpt
  --   { exe = "gofumpt" },
  --   -- this already uses goimports by default
  --   { exe = "golines" },
  --   -- { exe = "goimports", },
  -- }
  -- FIX: html breaks prettierd on everything else
  -- lvim.lang.html.formatters = { { exe = "prettier" } }
  -- lvim.lang.javascript.formatters = { { exe = "prettierd" } }
  -- lvim.lang.javascriptreact.formatters = { { exe = "prettierd" } }
  -- lvim.lang.json.formatters = { { exe = "prettierd" } }
  -- lvim.lang.less.formatters = { { exe = "prettierd" } }
  -- lvim.lang.lua.formatters = { { exe = "stylua" } }
  -- lvim.lang.markdown.formatters = { { exe = "prettierd" } }
  -- -- -- lvim.lang.scala.formatters = { { exe = "scalafmt" } }
  -- lvim.lang.solidity.formatters = { { exe = "prettierd" } }
  -- -- lvim.lang.sql.formatters = { { exe = "sqlformat" } }
  -- -- lvim.lang.terraform.formatters = { { exe = "terraform_fmt" } }
  -- lvim.lang.typescript.formatters = { { exe = "prettierd" } }
  -- lvim.lang.typescriptreact.formatters = { { exe = "prettierd" } }
  -- -- lvim.lang.vue.formatters = { { exe = "prettierd" } }
  -- lvim.lang.yaml.formatters = { { exe = "prettierd" } }
  -- lvim.lang.nginx.formatters = { { exe = "nginx_beautifier" } }
  -- lvim.lang.perl.formatters = { { exe = "perltidy" } }
  -- lvim.lang.php.formatters = { { exe = "phpcbf" } }

  -- Linters
  -- ==================================================================
  -- lvim.lang.css.linters = { { exe = "eslint_d" } }
  -- lvim.lang.javascript.linters = { { exe = "eslint_d" } }
  -- lvim.lang.javascriptreact.linters = { { exe = "eslint_d" } }
  -- lvim.lang.json.linters = { { exe = "eslint_d" } }
  -- lvim.lang.lua.linters = { { exe = "luacheck" } }
  -- lvim.lang.typescript.linters = { { exe = "eslint_d" } }
  -- lvim.lang.typescriptreact.linters = { { exe = "eslint_d" } }
  -- lvim.lang.tex.linters = { { exe = "chktex" } }
  -- lvim.lang.vim.linters = { { exe = "vint" } }
end

return M
