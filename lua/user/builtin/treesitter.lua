lvim.builtin.treesitter.matchup = true
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
  "vim",
  "regex",
  "markdown",
  "markdown_inline",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell", "python" }
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

lvim.builtin.treesitter.on_config_done = function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.sql = {
    install_info = {
      url = "https://github.com/m-novikov/tree-sitter-sql",
      revision = "main",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "sql",
  }

  -- TODO: get rest.nvim to work someday
  -- parser_config.http = {
  --   install_info = {
  --     url = "https://github.com/NTBBloodbath/tree-sitter-http",
  --     files = { "src/parser.c" },
  --     branch = "main",
  --   },
  -- }
end
