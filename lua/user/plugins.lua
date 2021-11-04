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
      -- cmd = "CodeActionMenu"
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
    -- {
    --   "kosayoda/nvim-lightbulb",
    --   -- event = "WinEnter",
    -- },
    -- {
    --   "simrat39/symbols-outline.nvim",
    --   config = function()
    --     require("user.symbols_outline").config()
    --   end,
    --   event = "BufReadPost",
    --   -- cmd = "SymbolsOutline",
    -- },
    -- {
    --   "SmiteshP/nvim-gps",
    --   requires = { "nvim-treesitter/nvim-treesitter" },
    --   config = function()
    --     require("nvim-gps").setup {
    --       icons = {
    --         ["class-name"] = " ", -- Classes and class-like objects
    --         ["function-name"] = " ", -- Functions
    --         ["method-name"] = " ", -- Methods (functions inside class-like objects)
    --         ["container-name"] = " ", -- Containers (example: lua tables)
    --         ["tag-name"] = "炙",
    --       },
    --       -- languages = { -- You can disable any language individually here
    --       --   ["cpp"] = true,
    --       -- },
    --       separator = " ",
    --     }
    --   end,
    -- },
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
    { "b0o/schemastore.nvim" },
    -- {
    --   "elianiva/telescope-npm.nvim",
    --   requires = { "nvim-telescope/telescope.nvim" },
    --   -- ft = { "json" },
    -- },
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
      config = function()
        require("harpoon").setup {
          global_settings = {
            save_on_toggle = true,
            save_on_change = true,
          },
        }
      end,
      event = "WinEnter",
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
    -- TODO: needs to open in correct working directory and must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
    -- {
    --   "is0n/fm-nvim",
    --   config = function()
    --     require("fm-nvim").setup {
    --       config = {
    --         edit_cmd = "edit",
    --         border = "rounded",
    --         height = 0.85,
    --         width = 0.85,
    --       },
    --     }
    --   end,
    -- },
    {
      "voldikss/vim-floaterm",
      config = function()
        vim.g.floaterm_height = 0.90
        vim.g.floaterm_width = 0.90
        vim.g.floaterm_opener = "drop"
        vim.g.floaterm_title = ""
        -- vim.g.floaterm_autoclose = 2
        -- vim.cmd [[hi FloatermBorder guifg=gray]]
      end,
      event = "BufWinEnter",
    },
    {
      "ptzz/lf.vim",
      config = function()
        vim.cmd [[let g:lf_replace_netrw = 1 ]] --" Open lf when vim opens a directory
      end,
      event = "BufWinEnter",
      -- after = { "kyazdani42/nvim-tree.lua" },
    },
    -- {
    --   "luukvbaal/nnn.nvim",
    --   config = function()
    --     require("nnn").setup {
    --       picker = {
    --         cmd = "tmux new-session nnn -Pp",
    --         style = { border = "rounded" },
    --         session = "shared",
    --       },
    --       -- replace_netrw = "picker",
    --       -- window_nav = "<C-l>",
    --     }
    --   end,
    -- },
    -----[[------------]]-----
    ---       Syntax       ---
    -----]]------------[[-----
    -- { "s1n7ax/nvim-comment-frame" }, -- (https://github.com/s1n7ax/nvim-comment-frame)
    -- { "ChristianChiarulli/vim-solidity" },
    {
      "code-biscuits/nvim-biscuits",
      -- event = "BufRead",
      config = function()
        require("nvim-biscuits").setup {
          cursor_line_only = true,
          default_config = {
            max_length = 50,
            -- trim_by_words = true,
            min_distance = 5,
            prefix_string = " 🍪 ",
          },
          -- language_config = {
          -- javascript = {
          --   -- prefix_string = "  // ",
          --   -- max_length = 80,
          -- },
          -- },
        }
      end,
    },
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
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "BufRead",
    },
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
    -- { "sindrets/diffview.nvim", cmd = "DiffviewOpen", },
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
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        local neogit = require "neogit"
        neogit.setup {}
      end,
    },
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
      -- rocks = { "luarocks-fetch-gitrec", "pcre2" },
      rocks = { "luarocks-fetch-gitrec" },
      requires = { "romgrk/fzy-lua-native" },
      config = function()
        vim.cmd(string.format("source %s", "~/.config/lvim/vimscript/wilder.vim"))
      end,
      run = ":UpdateRemotePlugins",
    },
    { "dstein64/nvim-scrollview", event = "WinEnter" },
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
    {
      "filipdutescu/renamer.nvim",
      branch = "master",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        -- local mappings_utils = require "renamer.mappings.utils"
        require("renamer").setup {
          -- The popup title, shown if `border` is true
          title = "Rename",
          -- The padding around the popup content
          padding = { 0, 0, 0, 0 },
          -- Whether or not to shown a border around the popup
          border = true,
          -- The characters which make up the border
          -- border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          -- Whether or not to highlight the current word references through LSP
          show_refs = false,
          -- The string to be used as a prompt prefix. It also sets the buffer to
          -- be a prompt
          prefix = "> ",
          -- The keymaps available while in the `renamer` buffer. The example below
          -- overrides the default values, but you can add others as well.
          -- mappings = {
          --   ["<c-i>"] = mappings_utils.set_cursor_to_start,
          --   ["<c-a>"] = mappings_utils.set_cursor_to_end,
          --   ["<c-e>"] = mappings_utils.set_cursor_to_word_end,
          --   ["<c-b>"] = mappings_utils.set_cursor_to_word_start,
          --   ["<c-c>"] = mappings_utils.clear_line,
          --   ["<c-u>"] = mappings_utils.undo,
          --   ["<c-r>"] = mappings_utils.redo,
          -- },
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
    -- {
    --   "andweeb/presence.nvim",
    --   config = function()
    --     require("presence"):setup {
    --       -- General options
    --       auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    --       neovim_image_text = "Neovim", -- Text displayed when hovered over the Neovim image
    --       main_image = "file", -- Main image display (either "neovim" or "file")
    --       client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
    --       log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    --       debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    --       enable_line_number = false, -- Displays the current line number instead of the current project
    --       blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    --       buttons = false, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

    --       -- Rich Presence text options
    --       editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer
    --       file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
    --       git_commit_text = "Committing changes", -- Format string rendered when commiting changes in git
    --       plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
    --       reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
    --       workspace_text = "Working on %s", -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
    --       line_number_text = "Line %s out of %s", -- Line number format string (for when enable_line_number is set to true)
    --     }
    --   end,
    -- },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
    -- TODO: look into neogen
    -- https://github.com/danymat/neogen
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = require("user.spectre").config,
    },
    {
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = function()
        require("user.neoclip").config()
      end,
      -- event = "BufRead",
    },
    {
      "mg979/vim-visual-multi",
      -- event = "CursorMoved",
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
    },
    { "chaoren/vim-wordmotion", event = "BufRead" },
    -- Using vim-sandwich until surround.nvim highlights matches
    -- {
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
      config = function()
        require("bufjump").setup {
          on_success = function()
            vim.cmd [[execute "normal! g`\"zz"]]
          end,
        }
      end,
      event = "BufRead",
    },
    {
      "ggandor/lightspeed.nvim",
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
    -- {
    --   "jvgrootveld/telescope-zoxide",
    --   requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    --   config = function()
    --     local z_utils = require "telescope._extensions.zoxide.utils"
    --     require("telescope._extensions.zoxide.config").setup {
    --       mappings = {
    --         default = {
    --           action = function(selection)
    --             -- -- Lf from fm-nvim
    --             -- vim.cmd("cd " .. selection.path)
    --             -- vim.cmd "Lf"
    --             -- vim.fn.feedkeys("a", "")

    --             -- Lf from lf.vim
    --             vim.cmd("cd " .. selection.path)
    --             vim.cmd "LfWorkingDirectory"
    --             vim.fn.feedkeys("a", "")
    --           end,
    --           after_action = function(selection)
    --             print("Opened " .. selection.path)
    --           end,
    --         },
    --       },
    --       ["<C-s>"] = { action = z_utils.create_basic_command "split" },
    --       ["<C-v>"] = { action = z_utils.create_basic_command "vsplit" },
    --       ["<C-e>"] = { action = z_utils.create_basic_command "edit" },
    --     }
    --     require("telescope").load_extension "zoxide"
    --   end,
    --   event = "BufRead",
    -- },
    -- {
    --   "nvim-telescope/telescope-frecency.nvim",
    --   config = function()
    --     require("telescope").load_extension "frecency"
    --   end,
    --   requires = { "tami5/sqlite.lua" },
    --   event = "BufRead",
    -- },
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
    --NOTE:
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
    { "dsznajder/vscode-es7-javascript-react-snippets" },
    {
      "RishabhRD/nvim-cheat.sh",
      requires = "RishabhRD/popfix",
      config = function()
        vim.g.cheat_default_window_layout = "vertical_split"
      end,
      cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    },
    -- { "anburocky3/bootstrap5-snippets" },
    -----[[------------]]-----
    ---     Completion     ---
    -----]]------------[[-----
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
      ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "css" },
      -- event = "InsertEnter",
    },
    {
      "abecodes/tabout.nvim",
      config = function()
        require("tabout").setup {
          tabkey = "",
          backwards_tabkey = "",
        }
      end,
      wants = { "nvim-treesitter" }, -- or require if not used so far
      after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
    },
    -- {
    --   "lukas-reineke/cmp-rg",
    --   config = function()
    --     require("cmp-rg").setup {}
    --   end,
    -- },
    -- {
    --   "tzachar/cmp-fzy-buffer",
    --   requires = { "hrsh7th/nvim-cmp", "nvim-telescope/telescope-fzf-native.nvim" },
    -- },
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
    -- {
    -- using this https://github.com/kozer/emmet-language-server
    --   "aca/emmet-ls",
    --   event = "BufRead",
    --   -- ft = { "html", "css", "javascript" },
    -- },
    -- use this until emmet-ls supports jsx and tsx
    -- {
    --   "mattn/emmet-vim",
    --   ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    --   config = function()
    --     vim.g.user_emmet_leader_key = "<C-y>"
    --     vim.g.emmet_html5 = 0
    --     vim.cmd [[let g:user_emmet_leader_key='<C-y>']]
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
