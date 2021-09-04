local M = {}

M.config = function()
  -- if you don't want all the parsers change this to a table of the ones you want
  -- lvim.builtin.treesitter.ensure_installed = {}
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.highlight.enabled = true
  lvim.builtin.treesitter.indent.disable = { "python" }
  lvim.builtin.treesitter.matchup.enable = true
  lvim.builtin.treesitter.textsubjects = {
    enable = true,
    keymaps = {
      ["<Tab>"] = "textsubjects-smart",
      ["<cr>"] = "textsubjects-container-outer",
    },
  }
  lvim.builtin.treesitter.playground.enable = true
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.context_commentstring = {
    enable = true,
    config = {
      fennel = ";; %s",
    },
  }
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-n>",
      node_incremental = "<A-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<A-p>",
    },
  }
  lvim.builtin.treesitter.query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  }
  -- neorg treesitter syntax, maybe one day it will be builtin and we won't need this
  lvim.builtin.treesitter.on_config_done = function()
    -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser_configs.norg = {
    --   install_info = {
    --     url = "https://github.com/vhyrro/tree-sitter-norg",
    --     files = { "src/parser.c" },
    --     branch = "main",
    --   },
    -- }
  end
end

return M
