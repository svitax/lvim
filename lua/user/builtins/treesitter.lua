local M = {}

M.config = function()
  -- if you don't want all the parsers change this to a table of the ones you want
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.context_commentstring = {
    enable = true,
    config = {
      fennel = ";; %s",
    },
  }

  lvim.builtin.treesitter.ensure_installed = { "org" }

  lvim.builtin.treesitter.highlight = {
    enable = true,
    disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
  }
  -- lvim.builtin.treesitter.highlight.disable = { "org" }
  -- lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = { "org" }

  lvim.builtin.treesitter.ignore_install = { "haskell" }

  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-Tab>",
      node_incremental = "<A-Tab>",
      node_decremental = "<A-S-Tab>",
      -- scope_incremental = "<A-.>",
      -- scope_decremental = "<A-,>",
    },
  }

  lvim.builtin.treesitter.indent.disable = { "python", "go" }

  lvim.builtin.treesitter.matchup.enable = true

  lvim.builtin.treesitter.playground.enable = true

  lvim.builtin.treesitter.query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  }

  lvim.builtin.treesitter.textsubjects = {
    enable = true,
    keymaps = {
      ["<Tab>"] = "textsubjects-smart",
      -- ["<cr>"] = "textsubjects-container-outer",
    },
  }

  lvim.builtin.treesitter.textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>lwa"] = "@parameter.inner",
        ["<leader>lwf"] = "@function.outer",
        ["<leader>lwe"] = "@element",
      },
      swap_previous = {
        ["<leader>lwA"] = "@parameter.inner",
        ["<leader>lwF"] = "@function.outer",
        ["<leader>lwE"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to populate the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  }

  lvim.builtin.treesitter.on_config_done = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.org = {
      install_info = {
        url = "https://github.com/milisims/tree-sitter-org",
        revision = "main",
        files = { "src/parser.c", "src/scanner.cc" },
      },
      filetype = "org",
    }

    -- neorg treesitter syntax, maybe one day it will be builtin and we won't need this
    -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser_configs.norg = {
    --   install_info = {
    --     url = "https://github.com/vhyrro/tree-sitter-norg",
    --     files = { "src/parser.c" },
    --     branch = "main",
    --   },
    -- }
    -- solidity parser
    parser_config.solidity = {
      install_info = {
        url = "https://github.com/JoranHonig/tree-sitter-solidity",
        files = { "src/parser.c" },
        branch = "highlights",
        requires_generate_from_grammar = true,
      },
      filetype = "solidity",
    }
    parser_config.jsonc.used_by = "json"
    parser_config.markdown = {
      install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        files = { "src/parser.c", "src/scanner.cc" },
      },
    }
    -- parser_config.gomod = {
    --   install_info = {
    --     url = "https://github.com/camdencheek/tree-sitter-go-mod",
    --     files = { "src/parser.c" },
    --     branch = "main"
    --   },
    -- }
    -- TODO: get rest.nvim to work someday
    -- parser_config.http = {
    --   install_info = {
    --     url = "https://github.com/NTBBloodbath/tree-sitter-http",
    --     files = { "src/parser.c" },
    --     branch = "main",
    --   },
    -- }
  end
end

return M
