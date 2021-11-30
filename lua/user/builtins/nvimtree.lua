local M = {}

M.config = function()
  lvim.builtin.nvimtree.on_config_done = function()
    lvim.builtin.which_key.mappings["e"] = nil
  end
  lvim.builtin.nvimtree.setup.disable_netrw = true
  lvim.builtin.nvimtree.setup.hijack_netrw = false
  -- lvim.builtin.nvimtree.disable_netrw = 0
  -- lvim.builtin.nvimtree.hijack_netrw = 0
  -- vim.g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
  -- vim.g.nvim_tree_hijack_netrw = 0 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  -- lvim.builtin.nvimtree.setup.auto_open = true
  lvim.builtin.nvimtree.setup.auto_close = false
  lvim.builtin.nvimtree.setup.view.side = "right"
  lvim.builtin.nvimtree.setup.view.width = 35
  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  lvim.builtin.nvimtree.setup.view.mappings.list = {
    { key = { ";", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "l", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
  }
  lvim.builtin.nvimtree.setup.diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  }
  lvim.builtin.nvimtree.icons = {
    default = "",
    symlink = "",
    git = {
      unstaged = "",
      staged = "",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "",
      ignored = "◌",
    },
    folder = {
      arrow_closed = "",
      arrow_open = "",
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
    },
  }
  lvim.builtin.nvimtree.git_hl = 0
end

return M
