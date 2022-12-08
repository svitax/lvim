return {
  prettierd = { command = "prettierd" },
  -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
  eslintd = { command = "eslint_d" },
  rustywind = { command = "rustywind" },
  stylelint = { command = "stylelint" },
  uncrustify = { command = "uncrustify" },
  clang_format = { command = "clang_format" },
  gofumpt = { command = "gofumpt" },
  golines = { command = "golines" },
  stylua = { command = "stylua" },
  black = { command = "black" },
  isort = { command = "isort" },
  reorder_python_imports = { command = "reorder_python_imports" },
  shfmt = { command = "shfmt", filetypes = { "sh", "zsh" } },
  shellharden = { command = "shellharden", filetypes = { "sh", "zsh" } },
  -- TODO: look into beautysh
  beautysh = { command = "beautysh" },
  sqlfluff = { command = "sqlfluff", extra_args = { "--dialect", "postgres" } },
  fnlfmt = { name = "fnlfmt" },
}
