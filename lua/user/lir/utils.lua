local M = {}

-- Construct the Lir floating window options according to the window we are
-- currently in. The position of the window will be centered in the current
-- window, thus not blocking other windows if opened.
---@return table<string, any>
M.construct_win_opts = function()
  local api = vim.api

  local winpos = api.nvim_win_get_position(0)
  local winwidth = api.nvim_win_get_width(0)
  local winheight = api.nvim_win_get_height(0)

  local width = math.min(80, winwidth - 14)
  local height = winheight - 6
  local row = (winheight / 2) - (height / 2) - 1
  local col = (winwidth / 2) - (width / 2)

  return {
    width = width,
    height = height,
    row = row + winpos[1],
    col = col + winpos[2],
    border = "single",
  }
end

return M
