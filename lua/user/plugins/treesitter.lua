local M = {}

M.config = function()
  lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "cpp",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
  }

  lvim.builtin.treesitter.ignore_install = { "haskell", "python" }
  lvim.builtin.treesitter.highlight.enabled = true
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  }
  lvim.builtin.treesitter.endwise = { enable = true }
end

return M
