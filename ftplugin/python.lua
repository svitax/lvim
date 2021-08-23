lvim.lang.python.formatters = {
  {
    -- @usage black or yapf
    exe = "black",
    args = { "--fast" },
  },
  {
    exe = "isort",
    args = {
      "--profile",
      "black",
    },
  },
}
lvim.lang.python.linters = {
  {
    -- @usage pylint or flake8
    exe = "pylint",
  },
}
