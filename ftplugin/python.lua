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
    exe = "flake8",
  },
}

-- if lvim.builtin.dap.active then
--   local dap_install = require "dap-install"
--   dap_install.config("python_dbg", {})
-- end
