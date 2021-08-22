M = {}
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
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").on_attach {
          hint_enable = false,
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
    },
    -----[[------------]]-----
    ---       Syntax       ---
    -----]]------------[[-----
    -- { "nvim-treesitter/playground", after = "nvim-treesitter", cmd = "TSPlaygroundToggle" },
    -- { "s1n7ax/nvim-comment-frame" }, -- (https://github.com/s1n7ax/nvim-comment-frame)
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
    {
      "pwntester/octo.nvim",
      cmd = "Octo",
      config = function()
        require("octo").setup()
      end,
    },
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
    {
      -- BUG compe gets unloaded once I open a .norg file?
      "vhyrro/neorg",
      branch = "unstable",
      config = require("user.neorg").config,
      requires = { "nvim-lua/plenary.nvim", "vhyrro/neorg-telescope" },
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
    },
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
    {
      "Mathijs-Bakker/zoom-vim",
      event = "BufRead",
    },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
    -- { 'mizlan/iswap.nvim' },
    {
      "machakann/vim-sandwich",
      config = function()
        vim.cmd "runtime macros/sandwich/keymap/surround.vim"
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
        vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi
        vim.cmd "let g:VM_custom_motions = {';': 'l', 'l': 'h', 'h': ';'}"
      end,
    },
    -- {
    --   "junegunn/vim-easy-align",
    --   setup = function()
    --     vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
    --   end,
    --   keys = "<Plug>(EasyAlign)",
    -- },
    -----[[------------]]-----
    ---       Files        ---
    -----]]------------[[-----
    -- {
    --   "nvim-telescope/telescope-project.nvim",
    --   branch = "feat/workspaces",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("telescope").load_extension "project"
    --   end,
    -- },
    {
      "tamago324/lir.nvim",
      config = require "user.lir.config",
    },
    {
      "tamago324/lir-bookmark.nvim",
      config = require "user.lir.extensions.bookmark",
      requires = { "tamago324/lir.nvim" },
    },
    {
      -- TODO find a way to get custom git icons with lir-git-status
      "tamago324/lir-git-status.nvim",
      wants = "lir",
      config = require "user.lir.extensions.git_status",
    },
    {
      -- TODO get lir.mmv to work (i think something is wrong with nvr)
      -- https://github.com/mhinz/neovim-remote
      -- https://github.com/itchyny/mmv
      "tamago324/lir-mmv.nvim",
      requires = { "tamago324/lir.nvim" },
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
    { "ahmedkhalf/lsp-rooter.nvim", event = "BufRead" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
    -----[[------------]]-----
    ---     Navigation     ---
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
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F" },
      -- event = "BufRead",
    },
    {
      -- TODO: zz center before doing neoscroll movement
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic", -- Default easing function
        }
        local t = {}
        -- Syntax: t[keys] = {function, {function arguments}}
        -- Use the "sine" easing function
        t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "350", [['sine']] } }
        t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "350", [['sine']] } }
        -- Use the "circular" easing function
        t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] } }
        t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] } }
        -- Pass "nil" to disable the easing animation (constant scrolling speed)
        t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
        t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
        -- When no easing function is provided the default easing function (in this case "quadratic") will be used
        t["zt"] = { "zt", { "300" } }
        t["zz"] = { "zz", { "300" } }
        t["zb"] = { "zb", { "300" } }

        require("neoscroll.config").set_mappings(t)
      end,
    },
    {
      -- TODO: maybe disable tab completion for compe to prevent conflicts with tabout
      "abecodes/tabout.nvim",
      config = function()
        require("user.tabout").config()
      end,
      wants = { "nvim-treesitter" }, -- or require if not used so far
      after = { "nvim-compe", "vim-vsnip" }, -- if a completion plugin is using tabs load it before
    },
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
    {
      -- TODO: find better mappings for matchup, and learn how to do matchup surround
      "andymass/vim-matchup",
      event = "CursorMoved",
      config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup", scrolloff = 1 }
        -- vim.g.matchup_matchparen_enabled = 0
        vim.g.matchup_surround_enabled = 1
      end,
    },
    -----[[------------]]-----
    ---      Sessions      ---
    -----]]------------[[-----
    {
      "rmagatti/auto-session",
      config = function()
        require("auto-session").setup {
          log_level = "info",
          auto_session_enable_last_session = false,
          auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
          auto_session_enabled = false,
          auto_save_enabled = false,
          auto_restore_enabled = false,
          auto_session_suppress_dirs = nil,
        }
      end,
    },
    {
      "rmagatti/session-lens",
      requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope").load_extension "session-lens"
        require("session-lens").setup {
          -- session-lens lets us pass in telescope opts through its setup func, pretty neat
          path_display = { "shorten" },
          previewer = false,
          -- unfortunately attaching a new mapping wipes out the defaults, so we have to put those back in
          attach_mappings = function(_, map)
            require("telescope.actions").select_default:replace(
              require("telescope._extensions.session-lens.session-lens-actions").source_session
            )
            map("n", "<c-d>", require("telescope._extensions.session-lens.session-lens-actions").delete_session)
            map("n", "d", require("telescope._extensions.session-lens.session-lens-actions").delete_session)
            return true
          end,
        }
      end,
    },
    -- {
    --   -- FIX: when I save and press j/k, it jumps me through the jumplist
    --   "ethanholz/nvim-lastplace",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("nvim-lastplace").setup {}
    --   end,
    -- },
    -----[[------------]]-----
    ---        Web         ---
    -----]]------------[[-----
    {
      "turbio/bracey.vim",
      event = "BufRead",
      ft = { "html", "javascript", "css" },
      run = "npm install --prefix server",
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
      ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
      -- event = "InsertEnter",
    },
    -----[[------------]]-----
    ---       Debug        ---
    -----]]------------[[-----
    {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      cmd = "SnipRun",
      config = function()
        require("sniprun").setup {
          repl_enable = { "Python3_original", "R_original" }, --" enable REPL-like behavior for the given interpreters
        }
      end,
    },
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
      event = "InsertEnter",
      -- ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    },
    -----[[------------]]-----
    ---      QuickFix      ---
    -----]]------------[[-----
    -- { "kevinhwang91/nvim-bqf", event = "BufRead" },
    {
      "ianding1/leetcode.vim",
      config = function()
        vim.g.leetcode_browser = "firefox"
        vim.g.leetcode_solution_filetype = "python3"
        vim.g.leetcode_hide_topics = 1
        vim.g.leetcode_hide_companies = 1
      end,
      cmd = { "LeetCodeList", "LeetCodeReset", "LeetCodeSignIn", "LeetCodeSubmit", "LeetCodeTest" },
    },
  }
end

return M
