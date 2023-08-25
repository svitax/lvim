return {
  -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
  eslintd = { command = "eslint_d" },
  xo = { command = "xo" },
  tsc = { command = "tsc" },
  stylelint = { command = "stylelint" },
  cppcheck = { command = "cppcheck" },
  gccdiag = { command = "gccdiag" },
  golangci_lint = { command = "golangci_lint" },
  selene = { command = "selene" },
  luacheck = { command = "luacheck" },
  markdownlint = { command = "markdownlint", extra_args = { "--disable", "MD013", "MD010" } },
  pylint = { command = "pylint" },
  flake8 = { command = "flake8" },
  mypy = { command = "mypy", extra_args = { "--strict" } },
  pydocstyle = { command = "pydocstyle" },
  pylama = { command = "pylama" },
  vulture = { command = "vulture" },
  shellcheck = { command = "shellcheck", extra_args = { "--severity", "warning" } },
  zsh = { command = "zsh" },
  sqlfluff = { command = "sqlfluff", extra_args = { "--dialect", "postgres" } },
  vint = { command = "vint" },
  yamllint = { command = "yamllint" },
}