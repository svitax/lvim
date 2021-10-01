local M = {}

M.config = function()
  -- lvim.builtin.nvimtree.disable_netrw = 0
  -- lvim.builtin.nvimtree.hijack_netrw = 0
  -- vim.g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
  -- vim.g.nvim_tree_hijack_netrw = 0 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  lvim.builtin.nvimtree.setup.auto_open = 1
  lvim.builtin.nvimtree.setup.view.side = "right"
  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  lvim.builtin.nvimtree.setup.view.mappings.list = {
    { key = { ";", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "l", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
  }
  -- lvim.builtin.nvimtree.on_config_done = function()
  --   local tree_cb = require("nvim-tree.config").nvim_tree_callback
  --   vim.g.nvim_tree_bindings = {
  --     { key = { ";", "<CR>", "o" }, cb = tree_cb "edit" },
  --     { key = "l", cb = tree_cb "close_node" },
  --     { key = "v", cb = tree_cb "vsplit" },
  --   }
end

return M
