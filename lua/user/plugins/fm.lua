local M = {}

M.config = function()
  local status_ok, fm = pcall(require, "fm-nvim")
  if not status_ok then
    return
  end

  fm.setup {
    border = "rounded",
    edit_cmd = "edit",
    height = 0.90,
    width = 0.90,
    -- mappings = {
    --   vert_split = "<C-v>",
    --   horz_split = "<C-s>",
    --   tabedit = "<C-t>",
    --   edit = "<C-e>",
    -- },
  }
end

return M
