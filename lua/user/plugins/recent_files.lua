local M = {}

M.config = function()
  -- local status_ok, recent_files = pcall(require, "telescope-recent-files")
  -- if not status_ok then
  --   return
  -- end

  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  telescope.load_extension "recent_files"
end

return M
