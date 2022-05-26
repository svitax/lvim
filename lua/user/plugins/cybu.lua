local M = {}

M.config = function()
  local ok, cybu = pcall(require, "cybu")
  if not ok then
    return
  end

  cybu.setup {
    position = {
      max_win_height = 9,
    },
    style = {
      hide_buffer_id = true,
    },
    display_time = 1500,
  }
end

return M
