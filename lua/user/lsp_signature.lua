local M = {}

M.config = function()
  local status_ok, lsp_signature = pcall(require, "lsp_signature")
  if not status_ok then
    return
  end

  local cfg = {
    bind = true,
    doc_lines = 10,
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    -- floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_above_cur_line = true,
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    -- hint_enable = false, -- virtual hint enable
    hint_enable = true, -- virtual hint enable
    hint_prefix = " ",
    hint_scheme = "String",
    -- hi_parameter = "Search", -- how your parameter will be highlight
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    -- to view the hiding contents
    max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    -- transpancy = 80,
    -- extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    debug = false, -- set to true to enable debug logging
    log_path = "debug_log_file_path", -- debug log path
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  }
  lsp_signature.setup(cfg)
end

return M

-- {
--   "ray-x/lsp_signature.nvim",
--   config = function()
--     require("lsp_signature").on_attach {
--       bind = true,
--       doc_lines = 10,
--       floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
--       floating_window_above_cur_line = true,
--       fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
--       hint_enable = false, -- virtual hint enable
--       max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
--       -- hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
--       hi_parameter = "Search", -- how your parameter will be highlight
--       -- to view the hiding contents
--       max_width = 40, -- max_width of signature floating_window, line will be wrapped if exceed max_width
--       handler_opts = {
--         border = "single", -- double, single, shadow, none
--       },
--     }
--   end,
--   event = "InsertEnter",
-- },
