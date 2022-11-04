lvim.builtin.dap.active = true

lvim.builtin.dap.on_config_done = function(dap)
  require("user.keymaps").set_dap_keymaps()
end

local icons = require "user.icons"
vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })
