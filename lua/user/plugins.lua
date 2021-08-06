M = {}
-- Short configs are done inline,
-- longer configs are in a separate file in lua/user
M.config = function()
  lvim.plugins = {
    -----[[------------]]-----
    ---        LSP         ---
    -----]]------------[[-----
    -- { "mfussenegger/nvim-jdtls" },
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
    -- { 'simrat39/symbols-outline.nvim' },
    -- {
    --   -- TODO: get lsp-status to show current function, and find a way to only show current function
    --   "nvim-lua/lsp-status.nvim",
    --   -- event = "BufEnter",
    -- },
    {
      "nvim-treesitter/playground",
      after = "nvim-treesitter",
      cmd = "TSPlaygroundToggle",
    },
    -----[[------------]]-----
    ---        Git         ---
    -----]]------------[[-----
    -- TODO waiting for diff file history in diffview.nvim (there's an issue already put up)
    -- { "sindrets/diffview.nvim", cmd = "DiffviewOpen", },
    -- { "ruifm/gitlinker.nvim", event = "BufRead"},
    -- { "ThePrimeagen/git-worktree.nvim" },
    -- { "mattn/vim-gist", event = "BufRead" },
    -- {
    -- 	"TimUntersberger/neogit",
    -- 	requires = "nvim-lua/plenary.nvim",
    -- 	cmd = "Neogit",
    -- },
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
    -- I'm only using this for norg until it gets builtin link creation/following
    -- remove norg and use only for markdown when that happens
    {
      "lervag/wiki.vim",
      config = function()
        vim.g.wiki_root = "~/Desktop/vimwiki"
        vim.g.wiki_filetypes = { "norg", "md" }
        vim.g.wiki_link_extension = ".norg"
        vim.g.wiki_link_target_type = "md"
      end,
    },
    {
      "vhyrro/neorg",
      branch = "unstable",
      config = require("user.neorg").config,
      requires = "nvim-lua/plenary.nvim",
    },
    -- {
    --   "vimwiki/vimwiki",
    --   branch = "dev",
    --   config = function()
    --     -- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki/markdown', 'syntax': 'markdown', 'ext': '.md'}]")
    --     vim.cmd "let g:vimwiki_list = [{'path': '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax', 'syntax': 'markdown', 'ext': '.md'}]"
    --     -- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki', 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}}]")
    --     vim.g.vimwiki_global_ext = 0
    --     vim.g.vimwiki_markdown_link_ext = 1
    --     -- vim.g.vimwiki_folding = "expr"
    --     -- -- vim.g.vimwiki_ext2syntax = {}
    --     vim.api.nvim_set_keymap("n", "<leader>wn", "<Plug>VimwikiNextLink", { silent = true })
    --     vim.api.nvim_set_keymap("n", "<leader>wb", "<Plug>VimwikiPrevLink", { silent = true })
    --   end,
    --   -- ft = { "markdown", "vimwiki" },
    --   -- event = "BufRead",
    -- },
    -- {"shurcooL/markdownfmt"},
    -- {
    --   'iamcco/markdown-preview.nvim',
    --   run = 'cd app && npm install',
    --   ft = 'markdown',
    -- },
    {
      "jubnzv/mdeval.nvim",
      config = function()
        vim.g.markdown_fenced_languages = { "python", "cpp" }
        require("mdeval").setup {
          eval_options = {
            -- Set custom configuration for C++
            cpp = {
              command = { "clang++", "-std=c++20", "-O0" },
            },
          },
        }
      end,
      ft = "markdown",
    },
    -- {
    --   -- vimwiki conceal is better
    --   "plasticboy/vim-markdown",
    --   config = require("user.vim-markdown").config,
    --   ft = { "markdown" },
    --   disable = true,
    -- },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
    -- { "blackCauldron7/surround.nvim" },
    -- { 'mizlan/iswap.nvim' },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = require("user.spectre").config,
    },
    {
      "mg979/vim-visual-multi",
      event = "CursorMoved",
    },
    -----[[------------]]-----
    ---       Files        ---
    -----]]------------[[-----
    {
      "nvim-telescope/telescope-project.nvim",
      event = "BufWinEnter",
      config = function()
        require("telescope").load_extension "project"
      end,
    },
    {
      "tamago324/lir.nvim",
      event = "BufEnter",
      config = require("user.lir").config,
    },
    -- { "tamago324/lir-bookmark.nvim", event = "BufEnter" },
    -- {
    --   -- TODO: lir-git-status doesn't support custom git icons yet
    --   "tamago324/lir-git-status.nvim",
    --   wants = "lir",
    --   config = function()
    --     require("lir.git_status").setup {
    --       -- show_ignored = true,
    --     }
    --   end,
    --   -- highlight link LirGitStatusBracket Comment
    --   -- highlight link LirGitStatusIndex Special
    --   -- highlight link LirGitStatusWorktree WarningMsg
    --   -- highlight link LirGitStatusUnmerged ErrorMsg
    --   -- highlight link LirGitStatusUntracked Comment
    --   -- highlight link LirGitStatusIgnored Comment
    -- },
    -- {
    -- TODO: get lir.mmv to work (i think something is wrong with nvr)
    --   -- https://github.com/mhinz/neovim-remote
    --   -- https://github.com/itchyny/mmv
    --   "tamago324/lir-mmv.nvim",
    --   wants = "lir",
    -- },
    {
      -- need this since no longer using barbar
      "famiu/bufdelete.nvim",
      cmd = { "Bdelete", "Bwipeout" },
    },
    -----[[------------]]-----
    ---     Navigation     ---
    -----]]------------[[-----
    {
      "ggandor/lightspeed.nvim",
      event = "BufRead",
    },
    {
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
    -- {
    --   "abecodes/tabout.nvim",
    --   config = function()
    --     require("user.tabout").config()
    --   end,
    --   wants = { "nvim-treesitter" }, -- or require if not used so far
    --   after = { "nvim-compe", "vim-vsnip" }, -- if a completion plugin is using tabs load it before
    -- },
    -- { "ahmedkhalf/lsp-rooter.nvim", event = "BufRead" },
    {
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
      "andymass/vim-matchup",
      event = "CursorMoved",
      config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        -- vim.g.matchup_matchparen_enabled = 0
      end,
    },
    -----[[------------]]-----
    ---      Sessions      ---
    -----]]------------[[-----
    -- {"rmagatti/auto-session"},
    -- {"rmagatti/session-lens"},
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
    ---        Web         ---
    -----]]------------[[-----
    {
      "turbio/bracey.vim",
      event = "BufRead",
      run = "npm install --prefix server",
    },
    -- {
    --   "windwp/nvim-ts-autotag",
    -- config = function()
    --   require("nvim-ts-autotag").setup()
    -- end,
    --   event = "InsertEnter",
    -- },
    -----[[------------]]-----
    ---       Debug        ---
    -----]]------------[[-----
    -- { 'michaelb/sniprun', run = 'bash ./install.sh'},
    -- {'metakirby5/codi.vim'},
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
        require("todo-comments").setup {}
      end,
    },
    -----[[------------]]-----
    ---     Completion     ---
    -----]]------------[[-----
    -- { "gelguy/wilder.nvim",
    --   config = function ()
    --     vim.cmd("source $HOME/.config/lvim/lua/user/wilder.vim")
    --   end
    -- },
    {
      "tzachar/compe-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-compe",
      event = "InsertEnter",
    },
    -- { "tamago324/compe-zsh" },
    -----[[------------]]-----
    ---       Extras       ---
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
      cmd = "LeetCodeList",
    },
    -- { 'kristijanhusak/vim-dadbod-ui' },
    -- { 'tpope/vim-dadbod' },
  }
end

return M
