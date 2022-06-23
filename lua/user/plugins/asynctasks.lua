local M = {}

M.config = function()
  vim.g.asyncrun_open = 8
  require("telescope").load_extension "asynctasks"
  require("user.keymaps").set_asynctasks_keymaps()
end

return M
