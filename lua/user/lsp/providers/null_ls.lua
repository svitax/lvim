local M = {}

M.config = function()
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  -- you can either config null-ls itself
  nls.config {
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          -- "css",
          -- "scss",
          "html",
          "json",
          "yaml",
          "markdown",
        },
      },
      nls.builtins.formatting.eslint_d.with {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      },

      nls.builtins.formatting.stylelint.with {
        filetypes = { "scss", "less", "css", "sass" },
      },
      -- nls.builtins.formatting.rustywind,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.gofumpt,
      nls.builtins.formatting.golines,
      -- nls.builtins.formatting.eslint_d,
      -- nls.builtins.formatting.goimports,
      -- nls.builtins.formatting.cmake_format,
      -- nls.builtins.formatting.scalafmt,
      -- nls.builtins.formatting.sqlformat,
      -- nls.builtins.formatting.terraform_fmt,
      -- nls.builtins.formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } },
      -- nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.stylelint.with {
        filetypes = { "scss", "less", "css", "sass" },
      },
      nls.builtins.diagnostics.eslint_d.with {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      },
      -- nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.luacheck,
      -- nls.builtins.diagnostics.vint,
      -- nls.builtins.diagnostics.chktex,
    },
  }

  -- or use the lunarvim syntax

  -- Formatters
  -- ==================================================================
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
  -- lvim.lang.python.formatters = {
  --   { exe = "black", args = { "--fast" } },
  --   { exe = "isort", args = { "--profile", "black" } },
  -- }
  -- -- -- lvim.lang.scala.formatters = { { exe = "scalafmt" } }
  lvim.lang.sh.formatters = {
    { exe = "shfmt", args = { "-i", "2", "-ci" } },
    { exe = "shellharden" },
  }
  -- lvim.lang.solidity.formatters = { { exe = "prettierd" } }
  -- -- lvim.lang.sql.formatters = { { exe = "sqlformat" } }
  -- -- lvim.lang.terraform.formatters = { { exe = "terraform_fmt" } }
  -- lvim.lang.typescript.formatters = { { exe = "prettierd" } }
  -- lvim.lang.typescriptreact.formatters = { { exe = "prettierd" } }
  -- -- lvim.lang.vue.formatters = { { exe = "prettierd" } }
  -- lvim.lang.yaml.formatters = { { exe = "prettierd" } }

  -- Linters
  -- ==================================================================
  -- lvim.lang.css.linters = { { exe = "eslint_d" } }
  -- lvim.lang.javascript.linters = { { exe = "eslint_d" } }
  -- lvim.lang.javascriptreact.linters = { { exe = "eslint_d" } }
  -- lvim.lang.json.linters = { { exe = "eslint_d" } }
  -- lvim.lang.lua.linters = { { exe = "luacheck" } }
  lvim.lang.markdown.linters = {
    { exe = "markdownlint" },
    -- { exe = "vale", },
  }
  lvim.lang.python.linters = { { exe = "flake8" } }
  lvim.lang.sh.linters = { { exe = "shellcheck" } }
  -- lvim.lang.typescript.linters = { { exe = "eslint_d" } }
  -- lvim.lang.typescriptreact.linters = { { exe = "eslint_d" } }
end

return M

-- lvim.lang.nginx.formatters = { { exe = "nginx_beautifier" } }
-- lvim.lang.perl.formatters = { { exe = "perltidy" } }
-- lvim.lang.php.formatters = { { exe = "phpcbf" } }

-- lvim.lang.tex.linters = { { exe = "chktex" } }
-- lvim.lang.vim.linters = { { exe = "vint" } }
