local M = {}

M.config = function()
  local status_ok, lspsaga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  lspsaga.init_lsp_saga {
    border_style = "rounded",
    code_action_icon = "ﯦ",
    definition_action_keys = {
      edit = "<A-e>",
      vsplit = "<A-v>",
      split = "<A-s>",
      tabe = "<A-t>",
      quit = "q",
    },
  }
  require("user.keymaps").set_lspsaga_keymaps()
end

return M
