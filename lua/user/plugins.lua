local M = {}

-- Short configs are done inline,
-- longer configs are in a separate file in lua/user
M.config = function()
  lvim.plugins = {
    -----[[------------]]-----
    ---       Debug        ---
    -----]]------------[[-----
    -- { "jbyuki/one-small-step-for-vimkind" },
    -- { "mfussenegger/nvim-dap-python" },
    -- { "leoluz/nvim-dap-go" },
    -- {
    --   "rcarriga/nvim-dap-ui",
    --   config = function()
    --     require("dapui").setup()
    --   end,
    --   requires = { "mfussenegger/nvim-dap" },
    --   ft = { "python", "go", "rust", "lua", "javascript" },
    -- },
    -----[[------------]]-----
    ---       Tests        ---
    -----]]------------[[-----
    -- https://github.com/vim-test/vim-test
    -- {
    --   "vim-test/vim-test",
    --   cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    --   keys = { "<localleader>tf", "<localleader>tn", "<localleader>ts" },
    --   config = function()
    --     require("user.vim_test").config()
    --   end,
    -- },
    -- https://github.com/rcarriga/vim-ultest
    -- {
    --   "rcarriga/vim-ultest",
    --   cmd = { "Ultest", "UltestSummary", "UltestNearest" },
    --   wants = "vim-test",
    --   requires = { "vim-test/vim-test" },
    --   run = ":UpdateRemotePlugins",
    -- },
    -----[[------------]]-----
    ---        LSP         ---
    -----]]------------[[-----
    {
      "weilbith/nvim-code-action-menu",
      event = "BufRead",
    },
    {
      "kosayoda/nvim-lightbulb",
      event = "CursorHold",
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("user.lsp_signature").config()
      end,
      event = "BufRead",
    },
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
      config = function()
        require("trouble").setup {
          signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "",
          },
        }
      end,
    },
    -----[[------------]]-----
    ---        Java        ---
    -----]]------------[[-----
    -- { "mfussenegger/nvim-jdtls" },
    -- { "mfussenegger/nvim-jdtls", ft = "java" },
    -----[[------------]]-----
    ---     TypeScript     ---
    -----]]------------[[-----
    -- https://github.com/kozer/emmet-language-server
    {
      -- TODO: get TSLspOrganize and TSPLspImportAll to go off when formatting javascript files
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      before = "williamboman/nvim-lsp-installer",
      requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    },
    {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup {
          colors = {
            up_to_date = "#3C4048", -- Text color for up to date package virtual text
            outdated = "#d19a66", -- Text color for outdated package virtual text
          },
          icons = {
            enable = true, -- Whether to display icons
            style = {
              up_to_date = "|  ", -- Icon for up to date packages
              outdated = "|  ", -- Icon for outdated packages
            },
          },
          autostart = false, -- Whether to autostart when `package.json` is opened
          hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
          hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
          -- Can be `npm` or `yarn`. Used for `delete`, `install` etc...
          -- The plugin will try to auto-detect the package manager based on
          -- `yarn.lock` or `package-lock.json`. If none are found it will use the
          -- provided one, if nothing is provided it will use `yarn`
          package_manager = "yarn",
        }
      end,
      ft = { "json" },
    },
    -- TODO: does this break when I do event = "WinEnter"?
    { "b0o/schemastore.nvim" },
    -----[[------------]]-----
    ---        Lua         ---
    -----]]------------[[-----
    {
      "folke/lua-dev.nvim",
      ft = "lua",
      before = "williamboman/nvim-lsp-installer",
    },
    -----[[------------]]-----
    ---       Golang       ---
    -----]]------------[[-----
    -- https://github.com/Snyssfx/goerr-nvim
    -- https://github.com/ray-x/go.nvim
    -- TODO: copy the leetcode type snippets from vscode-go-snippets
    { "codetalks-new/vscode-go-snippets" },
    -- TODO: copy the fiber snippets from vscode-go-power
    -- { "Ja7ad/vscode-go-power" },
    -- https://github.com/honnamkuan/vscode-golang-snippets
    -- { "golang/vscode-go", ft = { "go" }, },
    -----[[------------]]-----
    ---        Rust        ---
    -----]]------------[[-----
    -- https://github.com/simrat39/rust-tools.nvim
    -----[[------------]]-----
    ---       Files        ---
    -----]]------------[[-----
    {
      "ThePrimeagen/harpoon",
      event = "WinEnter",
      config = function()
        require("harpoon").setup {
          global_settings = {
            save_on_toggle = true,
            save_on_change = true,
          },
        }
      end,
    },
    {
      "kazhala/close-buffers.nvim",
      event = "BufRead",
      -- cmd = { "BDelete", "BDelete!", "BWipeout", "BWipeout!" },
      config = function()
        require("close_buffers").setup {
          filetype_ignore = {}, -- Filetype to ignore when running deletions
          file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
          file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
          preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
          next_buffer_cmd = nil, -- Custom function to retrieve the next buffer when preserving window layout
        }
      end,
    },
    {
      -- TODO: needs to open in correct working directory and must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
      "is0n/fm-nvim",
      cmd = { "Lf", "Nnn", "Ranger" },
      config = function()
        require("fm-nvim").setup {
          border = "rounded",
          edit_cmd = "edit",
          height = 0.90,
          width = 0.90,
          -- mappings = {
          --   vert_split = "<C-v>",
          --   horz_split = "<C-s>",
          --   tabedit = "<C-t>",
          --   edit = "<C-e>",
          -- },
        }
      end,
    },
    -----[[------------]]-----
    ---       Syntax       ---
    -----]]------------[[-----
    -- { "ChristianChiarulli/vim-solidity" },
    -- {
    -- TODO: nvim-biscuits stops working sometimes, figure that out
    --   "code-biscuits/nvim-biscuits",
    --   -- event = "BufRead",
    --   config = function()
    --     require("nvim-biscuits").setup {
    --       cursor_line_only = true,
    --       default_config = {
    --         max_length = 50,
    --         -- trim_by_words = true,
    --         min_distance = 5,
    --         prefix_string = " 🍪 ",
    --       },
    --       -- language_config = {
    --       -- javascript = {
    --       --   -- prefix_string = "  // ",
    --       --   -- max_length = 80,
    --       -- },
    --       -- },
    --     }
    --   end,
    -- },
    -- {
    --   "nathom/filetype.nvim",
    --   config = function()
    --     require("filetype").setup {
    --       overrides = {
    --         extensions = {
    --           pn = "potion",
    --         },
    --         literal = {
    --           -- ["kitty.conf"] = "kitty",
    --           [".gitignore"] = "conf",
    --         },
    --       },
    --     }
    --   end,
    -- },
    {
      "romgrk/nvim-treesitter-context",
      event = "BufRead",
      require = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("treesitter-context").setup {
          enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
          throttle = true, -- Throttles plugin updates (may improve performance)
          max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
          patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
              "class",
              "function",
              "method",
              "for", -- These won't appear in the context
              "while",
              "if",
              "switch",
              "case",
            },
            -- Example for a specific filetype.
            -- If a pattern is missing, *open a PR* so everyone can benefit.
            --   rust = {
            --       'impl_item',
            --   },
          },
        }
      end,
    },
    { "VebbNix/lf-vim", event = "BufRead" },
    { "fladson/vim-kitty", event = "BufRead" },
    -- {
    --   "JoosepAlviste/nvim-ts-context-commentstring",
    --   event = "BufRead",
    -- },
    {
      "nvim-treesitter/playground",
      after = "nvim-treesitter",
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    },
    -----[[------------]]-----
    ---        Git         ---
    -----]]------------[[-----
    -- TODO find a comfier way to integrate magit into my config (toggleterm config)
    -- waiting for diff file history in diffview.nvim (there's an issue already put up)
    -- { "ThePrimeagen/git-worktree.nvim" },
    -- { "ruifm/gitlinker.nvim", event = "BufRead"},
    -- { "mattn/vim-gist", event = "BufRead" },
    -- {
    --   "pwntester/octo.nvim",
    --   cmd = "Octo",
    --   config = function()
    --     require("octo").setup()
    --   end,
    -- },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      -- module = "diffview",
      -- keys = "<leader>gd",
      -- setup = function()
      --   require("which-key").register { ["<leader>gd"] = "diffview: diff HEAD" }
      -- end,
      config = function()
        require("diffview").setup {
          enhanced_diff_hl = true,
          file_panel = {
            position = "right",
          },
          key_bindings = {
            file_panel = { q = "<Cmd>DiffviewClose<CR>" },
            view = { q = "<Cmd>DiffviewClose<CR>" },
          },
        }
      end,
    },
    -- {
    --   "TimUntersberger/neogit",
    --   requires = {
    --     "nvim-lua/plenary.nvim",
    --     "sindrets/diffview.nvim",
    --   },
    --   config = function()
    --     local neogit = require "neogit"
    --     neogit.setup {
    --       disable_context_highlighting = true,
    --       disable_commit_confirmation = true,
    --       integrations = {
    --         diffview = true,
    --       },
    --     }
    --     neogit.config.use_magit_keybindings()
    --   end,
    -- },
    -- NOTE: using this for merge conflict resolution from lazygit
    { "tpope/vim-fugitive", event = "WinEnter" },
    -----[[------------]]-----
    ---        Notes       ---
    -----]]------------[[-----
    -- {
    --   "dkarter/bullets.vim",
    --   config = function()
    --     vim.g.bullets_enabled_file_types = { "markdown" }
    --   end,
    -- }, -- https://github.com/dkarter/bullets.vim
    {
      "plasticboy/vim-markdown",
      config = function()
        -- " Configuration for vim-markdown
        vim.g.vim_markdown_conceal = 2
        vim.g.vim_markdown_conceal_code_blocks = 0
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_toml_frontmatter = 1
        vim.g.vim_markdown_frontmatter = 1
        vim.g.vim_markdown_strikethrough = 1
        vim.g.vim_markdown_autowrite = 1
        vim.g.vim_markdown_edit_url_in = "tab"
        vim.g.vim_markdown_follow_anchor = 1
        vim.g.vim_markdown_auto_insert_bullets = 1
        vim.g.vim_markdown_new_list_item_indent = 0
      end,
      ft = "markdown",
    },
    {
      -- I'm only using this for norg until it gets builtin link creation/following
      -- remove norg and use only for markdown when that happens
      -- find a way to disable local mappings but keep <cr> as link follow
      "lervag/wiki.vim",
      config = function()
        vim.g.wiki_root = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax"
        -- vim.g.wiki_filetypes = { "norg" }
        -- vim.g.wiki_filetypes = { "norg", "md" }
        vim.g.wiki_filetypes = { "md" }
        -- vim.g.wiki_link_extension = ".norg"
        vim.g.wiki_link_target_type = "md" -- md style links or wiki style links
        vim.g.wiki_mappings_use_defaults = "local" -- all, local, global, or none
        -- BUG neorg needs compe to load first, so on init we can't jump to a .norg index with <plug>wiki-index
        -- unless we load compe first (InsertEnter)
      end,
    },
    -- {
    --   -- BUG compe gets unloaded once I open a .norg file?
    --   "vhyrro/neorg",
    --   branch = "unstable",
    --   config = require("user.neorg").config,
    --   requires = { "nvim-lua/plenary.nvim", "vhyrro/neorg-telescope" },
    -- },
    -- {
    --   "iamcco/markdown-preview.nvim",
    --   run = "cd app && npm install",
    --   ft = "markdown",
    -- },
    -----[[------------]]-----
    ---         UI         ---
    -----]]------------[[-----
    {
      "gelguy/wilder.nvim",
      event = { "CursorHold", "CmdlineEnter" },
      rocks = { "luarocks-fetch-gitrec", "pcre2" },
      -- rocks = { "luarocks-fetch-gitrec" },
      requires = { "romgrk/fzy-lua-native" },
      config = function()
        vim.cmd(string.format("source %s", "~/.config/lvim/vimscript/wilder.vim"))
      end,
      run = ":UpdateRemotePlugins",
    },
    {
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic", -- Default easing function
          mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
        }
      end,
    },
    -- {
    --   "luukvbaal/stabilize.nvim",
    --   config = function()
    --     require("stabilize").setup()
    --   end,
    -- },
    -- {
    --   "folke/zen-mode.nvim",
    --   config = function()
    --     require("user.zen").config()
    --   end,
    --   event = "BufRead",
    -- },
    -- {
    --   "folke/twilight.nvim",
    --   config = function()
    --     require("user.twilight").config()
    --   end,
    --   event = "BufRead",
    -- },
    -- {
    --   "Mathijs-Bakker/zoom-vim",
    --   event = "BufRead",
    -- },
    -- {
    --   "lukas-reineke/indent-blankline.nvim",
    --   setup = function()
    --     require("user.indent_blankline").setup()
    --   end,
    --   event = "BufRead",
    -- },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
    -- TODO: look into neogen
    -- https://github.com/danymat/neogen
    -- TODO: look into vim-yoink as a replacement for nvim-neoclip
    -- { "svermeulen/vim-yoink", config = function() end, },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = require("user.spectre").config,
    },
    {
      "AckslD/nvim-neoclip.lua",
      -- event = "WinEnter",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = function()
        require("user.neoclip").config()
      end,
    },
    {
      "filipdutescu/renamer.nvim",
      config = function()
        require("renamer").setup {
          title = "Rename",
        }
      end,
      key = "<leader>lr",
    },
    {
      "mg979/vim-visual-multi",
      -- event = "WinEnter",
      config = function()
        vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi theming
        -- vim.g.VM_default_mappings = false
        vim.cmd "let g:VM_default_mappings = 0"
        vim.cmd "let g:VM_custom_motions = {';': 'l', 'l': 'h', 'h': ';'}"
        vim.cmd "let g:VM_maps = {}"
        vim.cmd "let g:VM_maps['Find Under'] = '<C-y>'" -- replace C-n
        vim.cmd "let g:VM_maps['Find Subword Under'] = '<C-y>'" -- replace visual C-n
        -- vim.cmd "let g:VM_maps['Select Cursor Down'] = '<C-Down>'"
        -- vim.cmd "let g:VM_maps['Select Cursor Up']   = '<C-Up>'"
        -- vim.cmd "let g:VM_maps['Add Cursor At Pos']  = '<C-m>'"
      end,
    },
    {
      "machakann/vim-sandwich",
      config = function()
        vim.cmd "runtime macros/sandwich/keymap/surround.vim"
      end,
      -- event = "WinEnter"
    },
    { "chaoren/vim-wordmotion", event = "BufRead" },
    -- {
    -- Using vim-sandwich until surround.nvim highlights matches
    -- https://github.com/blackCauldron7/surround.nvim/issues/13
    --   "blackCauldron7/surround.nvim",
    --   config = function()
    --     require("surround").setup { mappings_style = "surround" }
    --   end,
    -- },
    -----[[------------]]-----
    ---     Navigation     ---
    -----]]------------[[-----
    {
      "kwkarlwang/bufjump.nvim",
      event = "BufRead",
      config = function()
        require("bufjump").setup {
          on_success = function()
            vim.cmd [[execute "normal! g`\"zz"]]
          end,
        }
      end,
    },
    {
      "ggandor/lightspeed.nvim",
      -- event = "WinEnter",
      config = function()
        require("lightspeed").setup {
          -- jump_to_first_match = true,
          highlight_unique_chars = true,
          substitute_chars = { ["\r"] = "¬" },
        }
      end,
    },
    -- TODO: try using this for resize mappings and copy sync
    -- https://github.com/aserowy/tmux.nvim
    {
      -- I need this to make winndow movement work with my prefered movement keys (jkl;)
      "numToStr/Navigator.nvim",
      event = "BufWinEnter",
      config = function()
        require("Navigator").setup()
        vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>lua require('Navigator').left()<CR>", { silent = true })
        vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", { silent = true })
        vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", { silent = true })
        vim.api.nvim_set_keymap("n", "<C-h>", "<cmd>lua require('Navigator').right()<CR>", { silent = true })
      end,
    },
    -----[[------------]]-----
    ---    Text Objects    ---
    -----]]------------[[-----
    {
      "andymass/vim-matchup",
      event = "CursorMoved",
      config = function()
        -- vim.g.matchup_matchparen_offscreen = { method = "popup", scrolloff = 1 }
        vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
        -- vim.g.matchup_matchparen_enabled = 0
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
      end,
    },
    {
      "RRethy/nvim-treesitter-textsubjects",
      event = "CursorMoved",
    },
    -----[[------------]]-----
    ---      Sessions      ---
    -----]]------------[[-----
    {
      "ethanholz/nvim-lastplace",
      event = "BufRead",
      config = function()
        require("nvim-lastplace").setup {
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = {
            "gitcommit",
            "gitrebase",
            "svn",
            "hgcommit",
          },
          lastplace_open_folds = true,
        }
      end,
    },
    -----[[------------]]-----
    ---       Colors       ---
    -----]]------------[[-----
    {
      "svitax/fennec-gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
    },
    {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("colorizer").setup({ "*" }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          names = true, -- "Name" codes like Blue
        })
      end,
    },
    {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function()
        require("user.todo_comments").config()
      end,
    },
    -----[[------------]]-----
    ---      Snippets      ---
    -----]]------------[[-----
    -- TODO: can probably write these snippets into luasnip myself
    { "dsznajder/vscode-es7-javascript-react-snippets" },
    -- {
    --   "mrjones2014/dash.nvim",
    --   run = "make install",
    --   -- event = "BufRead",
    --   cmd = "Dash",
    --   config = function()
    --     require("dash").setup()
    --   end,
    -- },
    -- {
    --   "RishabhRD/nvim-cheat.sh",
    --   requires = "RishabhRD/popfix",
    --   config = function()
    --     vim.g.cheat_default_window_layout = "vertical_split"
    --   end,
    --   cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    -- },
    -- { "anburocky3/bootstrap5-snippets" },
    -----[[------------]]-----
    ---     Completion     ---
    -----]]------------[[-----
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
      ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue", "css" },
      -- event = "InsertEnter",
    },
    -- {
    --   "kkoomen/vim-doge",
    --   event = "BufRead",
    --   run = { ":call doge#install()" },
    --   config = function()
    --     vim.cmd "let g:doge_comment_jump_modes = ['n', 'i', 's']"
    --     vim.cmd "let g:doge_enable_mappings = 0"
    --   end,
    -- },
    {
      "petertriho/cmp-git",
      requires = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
      config = function()
        require("cmp_git").setup {
          -- defaults
          filetypes = { "gitcommit" },
          remotes = { "upstream", "origin" }, -- in order of most to least prioritized
        }
      end,
    },
    { "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } },
    -- {
    --   "tzachar/cmp-tabnine",
    --   run = "./install.sh",
    --   requires = "hrsh7th/nvim-cmp",
    --   config = function()
    --     local tabnine = require "cmp_tabnine.config"
    --     tabnine:setup {
    --       max_lines = 1000,
    --       max_num_results = 10,
    --       sort = true,
    --     }
    --   end,
    -- },
    -----[[------------]]-----
    ---      QuickFix      ---
    -----]]------------[[-----
    { "kevinhwang91/nvim-bqf", event = "BufRead" },
    -- https://gitlab.com/yorickpeterse/nvim-pqf
    -----[[------------]]-----
    ---        Shell       ---
    -----]]------------[[-----
    -- { "waylonwalker/Telegraph.nvim" },
    -----[[------------]]-----
    ---        HTTP        ---
    -----]]------------[[-----
    -- {
    --   "turbio/bracey.vim",
    --   event = "BufRead",
    --   ft = { "html", "javascript", "css" },
    --   run = "npm install --prefix server",
    -- },
    -- TODO: guess I'm using postman until I figure out how to get this to work (looks like a plenary bug on macos?)
    -- {
    --   "NTBBloodbath/rest.nvim",
    --   requires = { "nvim-lua/plenary.nvim" },
    --   config = function()
    --     require("rest-nvim").setup {
    --       -- Open request results in a horizontal split
    --       result_split_horizontal = false,
    --       -- Skip SSL verification, useful for unknown certificates
    --       skip_ssl_verification = false,
    --       -- Highlight request on run
    --       highlight = {
    --         enabled = true,
    --         timeout = 150,
    --       },
    --       -- Jump to request line on run
    --       jump_to_request = false,
    --     }
    --   end,
    -- },
  }
end

return M
