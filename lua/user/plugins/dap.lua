local M = {}

M.config = function()
  lvim.builtin.dap.active = true
  lvim.builtin.dap.on_config_done = function(dap)
    lvim.builtin.which_key.mappings["d"] = {
      name = "+Debug",
      b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "create breakpoint" },
      B = {
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        "breakpoint condition",
      },
      c = { "<cmd>lua require('dap').continue()<CR>", "continue" },
      i = { "<cmd>lua require('dap').step_into()<CR>", "step into" },
      m = {
        "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
        "log point message",
      },
      o = { "<cmd>lua require('dap').step_out()<CR>", "step out" },
      r = {
        name = "+Repl",
        o = { "<cmd>lua require('dap').repl.open()<CR>", "open" },
        l = { "<cmd>lua require('dap').repl.run_last()<CR>", "run last" },
      },
      s = { "<cmd>lua require('dap.ui.variables').scopes()<CR>", "scopes" },
      t = { "<cmd>lua require('dapui').toggle()<CR>", "toggle" },
      v = { "<cmd>lua require('dap').step_over()<CR>", "step over" },
      V = {
        name = "+Variables",
        h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "hover" },
        v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "visual hover" },
      },
      w = {
        name = "+Widgets",
        h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "hover" },
        f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "float" },
      },
    }
  end
  local dap = require "dap"
  local dapui = require "dapui"
  -- local dap_status_ok, dap = pcall(require, "dap")
  -- if not dap_status_ok then
  --   return
  -- end

  -- local dap_ui_status_ok, dapui = pcall(require, "dapui")
  -- if not dap_ui_status_ok then
  --   return
  -- end

  dapui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    sidebar = {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        {
          id = "scopes",
          size = 0.25, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        -- { id = "stacks", size = 0.25 },
        -- { id = "watches", size = 00.25 },
      },
      size = 40,
      position = "right", -- Can be "left", "right", "top", "bottom"
    },
    tray = {
      elements = {},
      -- elements = { "repl" },
      -- size = 10,
      -- position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "rounded", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  }

  local icons = require "user.icons"

  vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

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
