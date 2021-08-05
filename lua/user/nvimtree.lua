local M = {}

M.config = function()
  lvim.builtin.nvimtree.side = "left"
  lvim.builtin.nvimtree.on_config_done = function()
    local tree_cb = require("nvim-tree.config").nvim_tree_callback
    vim.g.nvim_tree_bindings = {
      { key = { ";", "<CR>", "o" }, cb = tree_cb "edit" },
      { key = "l", cb = tree_cb "close_node" },
      { key = "v", cb = tree_cb "vsplit" },
    }
  end
end

return M
