-- ~/.config/lvim/ftplugin/cpp.lua
local dap_install = require "dap-install"
dap_install.config("ccppr_vsc", {})
-- local dap_install = require "dap-install"
-- dap_install.config("ccppr_vsc", {
--   adapters = {
--     type = "executable",
--   },
--   configurations = {
--     {
--       type = "cpptools",
--       request = "launch",
--       name = "Launch with pretty-print",
--       program = function()
--         return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
--       end,
--       cwd = "${workspaceFolder}",
--       stopOnEntry = true,
--       setupCommands = {
--         {
--           description = "Enable pretty-printing",
--           text = "-enable-pretty-printing",
--         },
--       },
--     },
--   },
-- })

-- ~/.config/lvim/ftplugin/python.lua
local dap_install = require "dap-install"
dap_install.config("python", {
  "python",
  {
    adapters = {
      type = "executable",
      command = "python3.9",
      args = { "-m", "debugpy.adapter" },
    },
    configurations = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/usr/bin/python3.9") == 1 then
            return cwd .. "/usr/bin/python3.9"
          elseif vim.fn.executable(cwd .. "/usr/bin/python3.9") == 1 then
            return cwd .. "/usr/bin/python3.9"
          else
            return "/usr/bin/python3.9"
          end
        end,
      },
    },
  },
})

-- ~/.config/lvim/ftplugin/go.lua
local dap_install = require "dap-install"
dap_install.config("go_delve", {})
