M = {}

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
    -- {
    --   -- TODO: get lsp-stauts to show current function, and find a way to only show current function
    --   "nvim-lua/lsp-status.nvim",
    --   -- event = "BufEnter",
    -- },
    -----[[------------]]-----
    ---        Git         ---
    -----]]------------[[-----
    -- TODO waiting for diff file history (there's an issue already put up)
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
    {
      "vimwiki/vimwiki",
      branch = "dev",
      config = function()
        -- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki/markdown', 'syntax': 'markdown', 'ext': '.md'}]")
        vim.cmd "let g:vimwiki_list = [{'path': '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax', 'syntax': 'markdown', 'ext': '.md'}]"
        -- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki', 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}}]")
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_markdown_link_ext = 1
        -- vim.g.vimwiki_folding = "expr"
        -- -- vim.g.vimwiki_ext2syntax = {}
        vim.api.nvim_set_keymap("n", "<leader>wn", "<Plug>VimwikiNextLink", { silent = true })
        vim.api.nvim_set_keymap("n", "<leader>wb", "<Plug>VimwikiPrevLink", { silent = true })
      end,
      -- ft = { "markdown", "vimwiki" },
      -- event = "BufRead",
    },
    -- {
    --   'iamcco/markdown-preview.nvim',
    --   run = 'cd app && npm install',
    --   ft = 'markdown',
    -- },
    -- {"shurcooL/markdownfmt"},
    -- {
    --   'jubnzv/mdeval.nvim',
    --   config = function ()
    --     require 'mdeval'.setup()
    --   end
    -- },
    -- {
    --   "plasticboy/vim-markdown",
    --   ft = { "markdown", "vimwiki" },
    --   config = function()
    --     -- Vim Markdown
    --     vim.g.vim_markdown_folding_disabled = 0
    --     vim.g.vim_markdown_math = 1
    --     vim.g.vim_markdown_frontmatter = 1
    --     vim.g.vim_markdown_strikethrough = 1
    --     vim.g.vim_markdown_conceal = 3
    --     -- vim.cmd("set conceallevel=2")
    --     vim.g.vim_markdown_follow_anchor = 1
    --     vim.g.vim_markdown_no_extensions_in_markdown = 1
    --     vim.g.vim_markdown_autowrite = 1
    --     -- vim.cmd("let g:markdown_fenced_languages = ['python']")
    --   end,
    -- },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
    -- { "blackCauldron7/surround.nvim" },
    -- { 'mizlan/iswap.nvim' },
    -- { "windwp/nvim-spectre" },
    {
      "mg979/vim-visual-multi",
      event = "CursorMoved",
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
        require("neoscroll").setup()
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
    {
      "ahmedkhalf/lsp-rooter.nvim",
      event = "BufRead",
    },
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
      "nvim-telescope/telescope-project.nvim",
      event = "BufWinEnter",
      config = function()
        require("telescope").load_extension "project"
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
    {
      "tamago324/lir.nvim",
      -- cmd = "lua require'lir.float'.toggle()",
      event = "BufEnter",
      config = function()
        require "user.lir"
      end,
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
    -- TODO: don't need rnvimr anymore
    -- {
    --   "kevinhwang91/rnvimr",
    --   cmd = "RnvimrToggle",
    --   config = function()
    --     -- " Make Ranger replace Netrw and be the file explorer
    --     vim.g.rnvimr_enable_ex = 1
    --     -- " Make Ranger to be hidden after picking a file
    --     vim.g.rnvimr_enable_picker = 1
    --     -- " Disable a border for floating window
    --     -- vim.g.rnvimr_draw_border = 0
    --     -- " Hide the files included in gitignore
    --     -- vim.g.rnvimr_hide_gitignore = 1
    --     -- " Make Neovim wipe the buffers corresponding to the files deleted by Ranger
    --     vim.g.rnvimr_enable_bw = 1
    --     -- " Add a shadow window, value is equal to 100 will disable shadow
    --     vim.g.rnvimr_shadow_winblend = 70
    --     -- " Draw border with both
    --     -- vim.g.rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
    --     vim.g.rnvimr_ranger_cmd = "/Users/svitax/.miniconda/envs/ranger/bin/ranger"
    --   end,
    -- },
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
        require("colorizer").setup()
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
    -- { "tamago324/compe-zsh" },
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
    -----[[------------]]-----
    ---       Extras       ---
    -----]]------------[[-----
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
    -- { 'simrat39/symbols-outline.nvim' },
    -- { "kevinhwang91/nvim-bqf", event = "BufRead" },
    -- { 'kristijanhusak/vim-dadbod-ui' },
    -- { 'tpope/vim-dadbod' },
  }
end

return M
