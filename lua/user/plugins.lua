local M = {}

M.config = function()
  -- Additional Plugins
  lvim.plugins = {
    { "tpope/vim-dadbod" },
    {
      "kristijanhusak/vim-dadbod-ui",
      config = function()
        require("user.keymaps").set_dbui_keymaps()
      end,
    },
    { "kristijanhusak/vim-dadbod-completion" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Buffers                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "kwkarlwang/bufjump.nvim", config = require("user.plugins.bufjump").config },
    { "kazhala/close-buffers.nvim", config = require("user.plugins.close_buffers").config },
    { "ghillb/cybu.nvim", requires = { "kyazdani42/nvim-web-devicons" }, config = require("user.plugins.cybu").config },
    { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim", config = require("user.plugins.harpoon").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Colors                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "svitax/fennec-gruvbox.nvim", branch = "gruvbox-baby" },
    { "luisiacc/gruvbox-baby", disable = lvim.work },
    { "norcalli/nvim-colorizer.lua", config = require("user.plugins.colorizer").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Completion                        │
    -- ╰──────────────────────────────────────────────────────────╯
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    -- { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim", after = "nvim-cmp", disable = lvim.work },
    { "custompro98/cmp-kitty", after = "nvim-cmp", disable = lvim.work },
    -- { "dburian/cmp-markdown-link", after = "nvim-cmp", disable = lvim.work },
    { "KadoBOT/cmp-plugins", after = "nvim-cmp", config = require("user.plugins.cmp_plugins").config },
    { "lukas-reineke/cmp-rg", after = "nvim-cmp" },
    -- { "tzachar/cmp-tabnine", run = "./install.sh", after = "nvim-cmp", disable = lvim.work },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Debugging                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = require("user.plugins.dapui").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Editing                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "LudoPinelli/comment-box.nvim", config = require("user.plugins.comment_box").config },
    -- { "gbprod/cutlass.nvim" },
    { "smjonas/inc-rename.nvim", config = require("user.plugins.inc_rename").config },
    { "danymat/neogen", config = require("user.plugins.neogen").config },
    -- { "windwp/nvim-spectre", requires = "nvim-lua/plenary.nvim", config = require("user.plugins.spectre").config },
    { "RRethy/nvim-treesitter-endwise" },
    { "johmsalas/text-case.nvim", config = require("user.plugins.textcase").config },
    { "gbprod/yanky.nvim", config = require("user.plugins.yanky").config },
    -- { "mg979/vim-visual-multi" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Files                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
    { "is0n/fm-nvim", config = require("user.plugins.fm").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                           Git                            │
    -- ╰──────────────────────────────────────────────────────────╯
    -- {
    -- TODO: set_gh_keymaps()
    --   "ldelossa/gh.nvim",
    --   requires = { { "ldelossa/litee.nvim" } },
    --   config = require("user.plugins.gh").config,
    --   disable = lvim.work,
    -- },
    { "kdheepak/lazygit.nvim", config = require("user.plugins.lazygit").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                           LSP                            │
    -- ╰──────────────────────────────────────────────────────────╯
    { "j-hui/fidget.nvim", config = require("user.plugins.fidget").config },
    { "ray-x/lsp_signature.nvim", config = require("user.plugins.lsp_signature").config },
    -- TODO: replace code-action-menu and lightbulb with lspsaga?
    { "weilbith/nvim-code-action-menu", config = require("user.plugins.code_action_menu").config },
    { "kosayoda/nvim-lightbulb", config = require("user.plugins.lightbulb").config },
    { "folke/trouble.nvim", config = require("user.plugins.trouble").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Navigation                        │
    -- ╰──────────────────────────────────────────────────────────╯
    { "declancm/cinnamon.nvim", config = require("user.plugins.cinnamon").config },
    -- { "kevinhwang91/nvim-hlslens", config = require("user.plugins.hlslens").config },
    { "ggandor/leap.nvim", config = require("user.plugins.leap").config },
    {
      "abecodes/tabout.nvim",
      wants = { "nvim-treesitter" },
      after = { "nvim-cmp" },
      config = require("user.plugins.tabout").config,
    },
    {
      "nvim-telescope/telescope-hop.nvim",
      -- config = -- inside telescope file
    },
    -- { "chaoren/vim-wordmotion", event = "BufRead" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Notes                           │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      config = require("user.plugins.markdown_preview").config,
      ft = { "markdown" },
      disable = lvim.work,
    },
    { "jakewvincent/mkdnflow.nvim", config = require("user.plugins.mkdnflow").config },
    { "preservim/vim-markdown", config = require("user.plugins.vim-markdown").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Projects                         │
    -- ╰──────────────────────────────────────────────────────────╯
    { "willthbill/opener.nvim", config = require("user.plugins.opener").config },
    -- { "charludo/projectmgr.nvim", config = require("user.plugins.projectmgr").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Quickfix                         │
    -- ╰──────────────────────────────────────────────────────────╯
    { "kevinhwang91/nvim-bqf", requires = { { "junegunn/fzf", run = require("user.plugins.fzf").run } } },
    { "https://gitlab.com/yorickpeterse/nvim-pqf.git", config = require("user.plugins.pqf").config },
    { "stevearc/qf_helper.nvim", config = require("user.plugins.qf_helper").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Sessions                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- { "rmagatti/auto-session", config = require("user.plugins.auto_session").config },
    -- {
    --   "rmagatti/session-lens",
    --   requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    --   config = require("user.plugins.session_lens").config,
    -- },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Syntax                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "VebbNix/lf-vim", event = "BufRead" },
    { "nvim-treesitter/playground" },
    { "jbyuki/nabla.nvim" },
    -- { "lervag/vimtex" },
    -- { "fladson/vim-kitty", event = "BufRead" },
    -- { "romgrk/nvim-treesitter-context" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Tasks                           │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "skywind3000/asynctasks.vim",
      requires = { "skywind3000/asyncrun.vim", "preservim/vimux" },
      config = require("user.plugins.asynctasks").config,
    },
    {
      "GustavoKatel/telescope-asynctasks.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
    { "vim-test/vim-test", config = require("user.plugins.vim-test").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                            UI                            │
    -- ╰──────────────────────────────────────────────────────────╯
    { "stevearc/dressing.nvim", config = require("user.plugins.dressing").config },
    -- { "anuvyklack/hydra.nvim", requires = "anuvyklack/keymap-layer.nvim", config = require("user.plugins.hydra").config },
    { "mrjones2014/legendary.nvim", config = require("user.plugins.legendary").config },
    { "chentoast/marks.nvim", config = require("user.plugins.marks").config },
    {
      "echasnovski/mini.nvim",
      branch = "stable",
      config = function()
        require("user.plugins.surround").config()
        require("user.plugins.indentscope").config()
      end,
    },
    {
      "utilyre/barbecue.nvim",
      requires = {
        "neovim/nvim-lspconfig",
        "smiteshp/nvim-navic",
        "kyazdani42/nvim-web-devicons", -- optional
      },
      config = function()
        require("barbecue").setup()
      end,
    },
    {
      "folke/noice.nvim",
      event = "VimEnter",
      config = function()
        require("noice").setup()
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },
    -- { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = require("user.plugins.ufo").config },
    { "lewis6991/satellite.nvim", config = require("user.plugins.satellite").config },
    { "luukvbaal/stabilize.nvim", config = require("user.plugins.stabilize").config, branch = "0.8" },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end,
    },
    -- {
    --   "gelguy/wilder.nvim",
    --   requires = { { "kyazdani42/nvim-web-devicons" }, { "romgrk/fzy-lua-native" }, { "sharkdp/fd" } },
    --   config = require("user.plugins.wilder").config,
    --   disable = lvim.work,
    -- },
    -- { "vimpostor/vim-tpipeline", config = require("user.plugins.tpipeline").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Web Dev                          │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup()
      end,
    },
    {
      "David-Kunz/cmp-npm",
      requires = { "nvim-lua/plenary.nvim" },
      -- { name = 'npm', keyword_length = 4 }
    },
    {
      "kalvinpearce/gitignore-gen.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Windows                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "mrjones2014/smart-splits.nvim", config = require("user.plugins.smart_splits").config },
    { "declancm/windex.nvim", config = require("user.plugins.windex").config },
    { "sindrets/winshift.nvim", config = require("user.plugins.winshift").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                     Optional plugins                     │
    -- ╰──────────────────────────────────────────────────────────╯
    -- { "wakatime/vim-wakatime", disable = lvim.work },
    -- {
    --   "xeluxee/competitest.nvim",
    --   requires = "MunifTanjim/nui.nvim",
    --   config = function()
    --     require("competitest").setup {}
    --   end,
    --   disable = lvim.work,
    -- },
  }
end

return M
