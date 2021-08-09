lvim.lang.python.formatters = {
  {
    -- @usage black or yapf
    exe = "black",
    args = {},
    -- args = { "--quiet", "--fast", "-" } -- for black
  },
  {
    exe = "isort",
    args = {},
    -- args = { "--stdout", "--profile", "black", "-" }
  },
}
lvim.lang.python.linters = {
  {
    -- @usage pylint or flake8
    exe = "pylint",
    args = {},
  },
}
