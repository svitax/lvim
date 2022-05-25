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
end

return M
