local M = {}

M.config = function()
  local status_ok, nvim_surround = pcall(require, "nvim-surround")
  if not status_ok then
    return
  end

  nvim_surround.setup {
    keymaps = {
      -- I just don't want this to conflict with visual S for leap backward
      visual = "gX",
    },
  }
  -- TODO: change default highlight group for NvimSurroundHighlight to same as matching pair.
  -- highlight default link NvimSurroundHighlight --matching pair?
end

return M
