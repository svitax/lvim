local M = {}

M.config = function()
  local status_ok, ufo = pcall(require, "ufo")
  if not status_ok then
    return
  end

  vim.o.foldcolumn = "1"
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  vim.wo.foldlevel = 99
  vim.wo.foldenable = true
  ufo.setup {}

  -- require("user.keymaps").set_ufo_keymaps()
end

return M
