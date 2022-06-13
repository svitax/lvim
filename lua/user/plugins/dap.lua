local M = {}

M.config = function()
  lvim.builtin.dap.active = true

  lvim.builtin.dap.on_config_done = function(dap)
    require("user.keymaps").set_dap_keymaps()
  end

  local icons = require "user.icons"
  vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

  local dap = require "dap"
  local dapui = require "dapui"
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
