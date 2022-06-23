local M = {}

M.config = function()
  vim.cmd [[let test#strategy = "asyncrun"]]
  require("user.keymaps").set_vim_test_keymaps()
end

return M
