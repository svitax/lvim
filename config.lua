-- LunarVim configuration
-- =========================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "fennec-gruvbox"
lvim.leader = "space"

-- Neovim configuration
-- =========================================
require("user.neovim").config()

-- User config (not builtin)
-- =========================================
-- winblend screws up the colors in toggleterm for me
lvim.winblend = 10

-- Builtins
-- =========================================
lvim.builtin.bufferline.active = false
lvim.builtin.dap.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true

require("user.builtins.autopairs").config()
require("user.builtins.comment").config()
require("user.builtins.dap").config()
require("user.builtins.dashboard").config()
require("user.builtins.cmp").config()
require("user.builtins.devicons").config()
require("user.builtins.nvimtree").config()
require("user.builtins.lualine").config()
require("user.builtins.toggleterm").config()
require "user.telescope.config"()
require("user.builtins.treesitter").config()

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.document_highlight = true
lvim.lsp.code_lens_refresh = true
lvim.lsp.automatic_servers_installation = false

-- LSP
-- =========================================
-- require("user.lsp.external_helpers").formatters()
-- require("user.lsp.external_helpers").linters()
require("user.lsp.providers.null_ls").config()
require("user.lsp.providers.emmet_ls").config()

require "user.lsp.config"()

-- Plugins
-- =========================================
-- require("user.plugins").config()
lvim.plugins = {
  -----[[------------]]-----
  ---       Debug        ---
  -----]]------------[[-----
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
    ft = { "python", "go", "rust" },
  },
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
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline.auto_preview = false
    end,
    cmd = "SymbolsOutline",
  },
  {
    "weilbith/nvim-code-action-menu",
    event = "BufRead",
    -- cmd = "CodeActionMenu"
  },
  { "kosayoda/nvim-lightbulb" },
  -- TODO: get TSLspOrganize and TSPLspImportAll to go off when formatting javascript files
  {
    "SmiteshP/nvim-gps",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-gps").setup {
        icons = {
          ["class-name"] = " ", -- Classes and class-like objects
          ["function-name"] = " ", -- Functions
          ["method-name"] = " ", -- Methods (functions inside class-like objects)
          ["container-name"] = " ", -- Containers (example: lua tables)
          ["tag-name"] = "炙",
        },
        -- languages = { -- You can disable any language individually here
        --   ["cpp"] = true,
        -- },
        separator = " ",
      }
    end,
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
  -----[[------------]]-----
  ---     TypeScript     ---
  -----]]------------[[-----
  -- https://github.com/kozer/emmet-language-server
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    -- ft = {
    --   "javascript",
    --   "javascriptreact",
    --   "javascript.jsx",
    --   "typescript",
    --   "typescriptreact",
    --   "typescript.tsx",
    -- },
    before = "williamboman/nvim-lsp-installer",
  },
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
  -- https://github.com/codetalks-new/vscode-go-snippets
  -- https://github.com/Ja7ad/vscode-go-power
  -- https://github.com/honnamkuan/vscode-golang-snippets
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
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
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
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_height = 0.90
      vim.g.floaterm_width = 0.90
      vim.g.floaterm_opener = "drop"
      vim.g.floaterm_title = ""
      -- vim.g.floaterm_autoclose = 2
      -- vim.cmd [[hi FloatermBorder guifg=gray]]
    end,
  },
  {
    "ptzz/lf.vim",
    config = function()
      vim.cmd [[let g:lf_replace_netrw = 1 ]] --" Open lf when vim opens a directory
    end,
    -- after = { "kyazdani42/nvim-tree.lua" },
  },
  -----[[------------]]-----
  ---       Syntax       ---
  -----]]------------[[-----
  -- { "s1n7ax/nvim-comment-frame" }, -- (https://github.com/s1n7ax/nvim-comment-frame)
  -- { "ChristianChiarulli/vim-solidity" },
  -- https://github.com/VebbNix/lf-vim
  { "VebbNix/lf-vim" },
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
  { "tpope/vim-fugitive" },
  -- {
  --   "TimUntersberger/neogit",
  --   requires = "nvim-lua/plenary.nvim",
  --   config = function()
  --     local neogit = require "neogit"
  --     neogit.setup {}
  --   end,
  -- },
  -----[[------------]]-----
  ---        Notes       ---
  -----]]------------[[-----
  -- {
  --   "dkarter/bullets.vim",
  --   config = function()
  --     vim.g.bullets_enabled_file_types = { "markdown" }
  --   end,
  -- }, -- https://github.com/dkarter/bullets.vim
  -- {
  --   "plasticboy/vim-markdown",
  --   config = function()
  --     -- " Configuration for vim-markdown
  --     vim.g.vim_markdown_conceal = 2
  --     vim.g.vim_markdown_conceal_code_blocks = 0
  --     vim.g.vim_markdown_math = 1
  --     vim.g.vim_markdown_toml_frontmatter = 1
  --     vim.g.vim_markdown_frontmatter = 1
  --     vim.g.vim_markdown_strikethrough = 1
  --     vim.g.vim_markdown_autowrite = 1
  --     vim.g.vim_markdown_edit_url_in = "tab"
  --     vim.g.vim_markdown_follow_anchor = 1
  --     vim.g.vim_markdown_auto_insert_bullets = 1
  --     vim.g.vim_markdown_new_list_item_indent = 0
  --   end,
  -- },
  -- {
  --   -- I'm only using this for norg until it gets builtin link creation/following
  --   -- remove norg and use only for markdown when that happens
  --   -- find a way to disable local mappings but keep <cr> as link follow
  --   "lervag/wiki.vim",
  --   config = function()
  --     vim.g.wiki_root = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax"
  --     -- vim.g.wiki_filetypes = { "norg" }
  --     -- vim.g.wiki_filetypes = { "norg", "md" }
  --     vim.g.wiki_filetypes = { "md" }
  --     -- vim.g.wiki_link_extension = ".norg"
  --     vim.g.wiki_link_target_type = "md" -- md style links or wiki style links
  --     vim.g.wiki_mappings_use_defaults = "local" -- all, local, global, or none
  --     -- BUG neorg needs compe to load first, so on init we can't jump to a .norg index with <plug>wiki-index
  --     -- unless we load compe first (InsertEnter)
  --   end,
  -- },
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
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup {
        -- General options
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "Neovim", -- Text displayed when hovered over the Neovim image
        main_image = "file", -- Main image display (either "neovim" or "file")
        client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
        log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number = false, -- Displays the current line number instead of the current project
        blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons = false, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

        -- Rich Presence text options
        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
        git_commit_text = "Committing changes", -- Format string rendered when commiting changes in git
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
        workspace_text = "Working on %s", -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
        line_number_text = "Line %s out of %s", -- Line number format string (for when enable_line_number is set to true)
      }
    end,
  },

  -----[[------------]]-----
  ---       Editing      ---
  -----]]------------[[-----
  -- TODO: look into neogen
  -- https://github.com/danymat/neogen
  -- {
  --   "junegunn/vim-easy-align",
  --   setup = function()
  --     vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
  --   end,
  --   keys = "<Plug>(EasyAlign)",
  -- },
  {
    "mizlan/iswap.nvim",
    event = "BufRead",
    config = function()
      require("iswap").setup {
        keys = "jkl;asdf",
        -- grey = "disable",
        -- hl_snipe = "ErrorMsg",
        hl_snipe = "LightspeedShortcut",
        -- hl_selection = "WarningMsg",
        -- hl_grey = "LineNr",
      }
    end,
  },
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
  },
  {
    "mg979/vim-visual-multi",
    event = "CursorMoved",
    config = function()
      vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi theming
      vim.cmd "let g:VM_custom_motions = {';': 'l', 'l': 'h', 'h': ';'}"
      vim.cmd "let g:VM_maps = {}"
      vim.cmd "let g:VM_maps['Find Under'] = '<C-m>'" -- replace C-n
      vim.cmd "let g:VM_maps['Find Subword Under'] = '<C-m>'" -- replace visual C-n
      -- vim.cmd "let g:VM_maps['Select Cursor Down'] = '<C-m>'"
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
  },
  {
    "ggandor/lightspeed.nvim",
    -- keys = { "s", "S", "f", "F" },
    -- event = "BufRead",
  },
  {
    "jvgrootveld/telescope-zoxide",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local z_utils = require "telescope._extensions.zoxide.utils"
      require("telescope._extensions.zoxide.config").setup {
        mappings = {
          default = {
            -- FIX: fix this zoxide-lf integration
            action = function(selection)
              vim.cmd("cd " .. selection.path)
              vim.cmd("LfWorkingDirectory")
              vim.fn.feedkeys("a", "")
              -- vim.cmd("edit .")
              -- vim.cmd("edit " .. selection.path)
              -- vim.cmd[[execute "normal ajkjk\<Esc>"]]
              -- vim.cmd[[execute "normal a"]]
            end,
            after_action = function(selection)
              print("Opened " .. selection.path)
            end,
          },
        },
        ["<C-s>"] = { action = z_utils.create_basic_command "split" },
        ["<C-v>"] = { action = z_utils.create_basic_command "vsplit" },
        ["<C-e>"] = { action = z_utils.create_basic_command "edit" },
      }
      require("telescope").load_extension "zoxide"
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
      vim.g.matchup_matchparen_offscreen = { method = "popup", scrolloff = 1 }
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
    -- FIX: when I save and press j/k, it jumps me through the jumplist
    "ethanholz/nvim-lastplace",
    event = "BufWinEnter",
    config = function()
      require("nvim-lastplace").setup {}
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
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {
        signs = false, -- show icons in the signs column
      }
    end,
  },
  -----[[------------]]-----
  ---      Snippets      ---
  -----]]------------[[-----
  -- { "anburocky3/bootstrap5-snippets" },
  -- {
  --   "dsznajder/vscode-es7-javascript-react-snippets",
  --   -- ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- },
  -- {
  --   "golang/vscode-go",
  --   ft = { "go" },
  -- },
  {
    "RishabhRD/nvim-cheat.sh",
    requires = "RishabhRD/popfix",
    config = function()
      vim.g.cheat_default_window_layout = "vertical_split"
    end,
    cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
  },
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
  -- https://gitlab.com/yorickpeterse/nvim-pqf
  { "kevinhwang91/nvim-bqf", event = "BufRead" },
}

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Mappngs
-- =========================================
require("user.keymappings").config()
