local M = {}

-- Short configs are done inline,
-- longer configs are in a separate file in lua/user
M.config = function()
  lvim.plugins = {
    -----[[------------]]-----
    ---        LSP         ---
    -----]]------------[[-----
    -- { "mfussenegger/nvim-jdtls" },
    -- { 'simrat39/symbols-outline.nvim' },
    {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      config = function()
        require("user.lsp.ts_utils").config()
      end,
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
    },
    -- {
    --   "SmiteshP/nvim-gps",
    --   requires = { "nvim-treesitter/nvim-treesitter" },
    --   config = function()
    --     require("nvim-gps").setup {
    --       icons = {
    --         ["class-name"] = " ", -- Classes and class-like objects
    --         ["function-name"] = " ", -- Functions
    --         -- Methods (functions inside class-like objects)
    --         ["method-name"] = " ",
    --       },
    --       -- languages = { -- You can disable any language individually here
    --       --   ["cpp"] = true,
    --       -- },
    --       separator = " > ",
    --     }
    --   end,
    -- },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").on_attach {
          bind = true,
          doc_lines = 10,
          floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
          floating_window_above_cur_line = true,
          fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
          hint_enable = false, -- virtual hint enable
          max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
          -- to view the hiding contents
          max_width = 40, -- max_width of signature floating_window, line will be wrapped if exceed max_width
          handler_opts = {
            border = "single", -- double, single, shadow, none
          },
        }
      end,
      event = "InsertEnter",
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
    ---       Syntax       ---
    -----]]------------[[-----
    -- { "s1n7ax/nvim-comment-frame" }, -- (https://github.com/s1n7ax/nvim-comment-frame)
    {
      "nvim-treesitter/playground",
      after = "nvim-treesitter",
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "BufRead",
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
    -----[[------------]]-----
    ---        Notes       ---
    -----]]------------[[-----
    {
      "dkarter/bullets.vim",
      config = function()
        vim.g.bullets_enabled_file_types = { "markdown" }
      end,
    }, -- https://github.com/dkarter/bullets.vim
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
      "folke/zen-mode.nvim",
      config = function()
        require("user.zen").config()
      end,
      event = "BufRead",
    },
    {
      "folke/twilight.nvim",
      config = function()
        require("user.twilight").config()
      end,
      event = "BufRead",
    },
    -- {
    --   "Mathijs-Bakker/zoom-vim",
    --   event = "BufRead",
    -- },
    { "dstein64/nvim-scrollview", event = "WinEnter" },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
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
          -- The keys that will be used as a selection, in order
          -- ('asdfghjklqwertyuiopzxcvbnm' by default)
          -- keys = "qwertyuiop",
          keys = "jkl;asdf",

          -- Grey out the rest of the text when making a selection
          -- (enabled by default)
          -- grey = "disable",

          -- Highlight group for the sniping value (asdf etc.)
          -- default 'Search'
          -- hl_snipe = "ErrorMsg",
          hl_snipe = "LightspeedShortcut",

          -- Highlight group for the visual selection of terms
          -- default 'Visual'
          -- hl_selection = "WarningMsg",

          -- Highlight group for the greyed background
          -- default 'Comment'
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
      "mg979/vim-visual-multi",
      event = "CursorMoved",
      config = function()
        vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi theming
        vim.cmd "let g:VM_custom_motions = {';': 'l', 'l': 'h', 'h': ';'}"
      end,
    },
    {
      "machakann/vim-sandwich",
      config = function()
        vim.cmd "runtime macros/sandwich/keymap/surround.vim"
      end,
    },
    -----[[------------]]-----
    ---       Files        ---
    -----]]------------[[-----
    {
      "voldikss/vim-floaterm",
      config = function()
        vim.g.floaterm_opener = "drop"
      end,
    },
    {
      "ptzz/lf.vim",
      config = function()
        local winwidth = vim.api.nvim_win_get_width(0)
        local winheight = vim.api.nvim_win_get_height(0)
        local width = math.min(130, winwidth - 14)
        local height = winheight - 2

        vim.g.lf_width = width
        vim.g.lf_height = height
      end,
    },
    -- {
    --   "nvim-telescope/telescope-project.nvim",
    --   branch = "feat/workspaces",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("telescope").load_extension "project"
    --   end,
    -- },
    -- {
    --   "tamago324/lir.nvim",
    --   -- "svitax/lir.nvim",
    --   -- branch = "detail_mode",
    --   config = require "user.lir.config",
    -- },
    -- {
    --   "tamago324/lir-bookmark.nvim",
    --   config = require "user.lir.extensions.bookmark",
    --   requires = { "tamago324/lir.nvim" },
    --   -- requires = { "svitax/lir.nvim" },
    -- },
    -- {
    --   -- TODO find a way to get custom git icons with lir-git-status
    --   "tamago324/lir-git-status.nvim",
    --   wants = "lir",
    --   config = require "user.lir.extensions.git_status",
    -- },
    -- {
    --   -- TODO get lir.mmv to work (i think something is wrong with nvr)
    --   -- https://github.com/mhinz/neovim-remote
    --   -- https://github.com/itchyny/mmv
    --   "tamago324/lir-mmv.nvim",
    --   requires = { "tamago324/lir.nvim" },
    --   -- requires = { "svitax/lir.nvim" },
    -- },
    {
      "ThePrimeagen/harpoon",
      config = function()
        require("harpoon").setup {
          global_settings = {
            save_on_toggle = true,
            save_on_change = true,
          },
          -- projects = {
          --   -- Yes $HOME works
          --   ["$HOME/personal/vim-with-me/server"] = {
          --     term = {
          --       cmds = {
          --         "./env && npx ts-node src/index.ts",
          --       },
          --     },
          --   },
          -- },
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
    -- { "ahmedkhalf/lsp-rooter.nvim", event = "BufRead" },
    -- TODO: for some reason not working
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
    -----[[------------]]-----
    ---     Navigation     ---
    -----]]------------[[-----
    -- {
    --   "ggandor/lightspeed.nvim",
    --   -- keys = { "s", "S", "f", "F" },
    --   -- event = "BufRead",
    -- },
    {
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic", -- Default easing function
        }
      end,
    },
    -- {
    --   "abecodes/tabout.nvim",
    --   config = function()
    --     require("tabout").setup {
    --       tabkey = "<Tab>",
    --       backwards_tabkey = "<S-Tab>",
    --       act_as_tab = true, -- shift content if tab out is not possible
    --       act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    --       enable_backwards = false, -- well ...
    --       completion = true, -- if the tabkey is used in a completion pum
    --     }
    --   end,
    --   wants = { "nvim-treesitter" }, -- or require if not used so far
    --   after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
    -- },
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
    -- {
    --   "rmagatti/auto-session",
    --   config = function()
    --     require("auto-session").setup {
    --       log_level = "info",
    --       auto_session_enable_last_session = false,
    --       auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
    --       auto_session_enabled = false,
    --       auto_save_enabled = false,
    --       auto_restore_enabled = false,
    --       auto_session_suppress_dirs = nil,
    --     }
    --   end,
    -- },
    -- {
    --   "rmagatti/session-lens",
    --   requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    --   config = function()
    --     require("telescope").load_extension "session-lens"
    --     require("session-lens").setup {
    --       -- session-lens lets us pass in telescope opts through its setup func, pretty neat
    --       path_display = { "shorten" },
    --       previewer = false,
    --       -- unfortunately attaching a new mapping wipes out the defaults, so we have to put those back in
    --       attach_mappings = function(_, map)
    --         require("telescope.actions").select_default:replace(
    --           require("telescope._extensions.session-lens.session-lens-actions").source_session
    --         )
    --         map("n", "<c-d>", require("telescope._extensions.session-lens.session-lens-actions").delete_session)
    --         map("n", "d", require("telescope._extensions.session-lens.session-lens-actions").delete_session)
    --         return true
    --       end,
    --     }
    --   end,
    -- },
    {
      -- FIX: when I save and press j/k, it jumps me through the jumplist
      "ethanholz/nvim-lastplace",
      event = "BufWinEnter",
      config = function()
        require("nvim-lastplace").setup {}
      end,
    },
    -----[[------------]]-----
    ---        Web         ---
    -----]]------------[[-----
    -- {
    --   "turbio/bracey.vim",
    --   event = "BufRead",
    --   ft = { "html", "javascript", "css" },
    --   run = "npm install --prefix server",
    -- },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
      ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "css" },
      -- event = "InsertEnter",
    },
    -----[[------------]]-----
    ---       Debug        ---
    -----]]------------[[-----
    -- {
    --   "michaelb/sniprun",
    --   run = "bash ./install.sh",
    --   cmd = "SnipRun",
    --   config = function()
    --     require("sniprun").setup {
    --       repl_enable = { "Python3_original", "R_original" }, --" enable REPL-like behavior for the given interpreters
    --     }
    --   end,
    -- },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      requires = { "mfussenegger/nvim-dap" },
      ft = "python",
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
    ---     Completion     ---
    -----]]------------[[-----
    -- { "tamago324/compe-zsh" },
    {
      "dsznajder/vscode-es7-javascript-react-snippets",
      config = function()
        require("luasnip/loaders/from_vscode").lazy_load()
      end,
      -- event = "InsertEnter",
      ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    },
    {
      "aca/emmet-ls",
      ft = { "html", "css", "javascript" },
    },
    -- use this until emmet-ls supports jsx and tsx
    {
      "mattn/emmet-vim",
      ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      config = function()
        vim.g.user_emmet_leader_key = "<C-a>"
        vim.g.emmet_html5 = 0
        vim.cmd [[let g:user_emmet_leader_key='<C-a>']]
      end,
    },
    -----[[------------]]-----
    ---      QuickFix      ---
    -----]]------------[[-----
    -- {
    --   "ianding1/leetcode.vim",
    --   config = function()
    --     vim.g.leetcode_browser = "firefox"
    --     vim.g.leetcode_solution_filetype = "python3"
    --     vim.g.leetcode_hide_topics = 1
    --     vim.g.leetcode_hide_companies = 1
    --   end,
    --   cmd = { "LeetCodeList", "LeetCodeReset", "LeetCodeSignIn", "LeetCodeSubmit", "LeetCodeTest" },
    -- },
    { "kevinhwang91/nvim-bqf", event = "BufRead" },
  }
end

return M
