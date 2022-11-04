local M = {}

M.config = function()
  -- TODO: delete harpoon configs and files.
  -- TODO: fix all instances of telescope.load_extension.

  lvim.plugins = {
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Buffers                          │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <A-o> and <A-i> to jump to previous and next buffer on jumplist (mimics <C-o> and <C-i>.)
    { "kwkarlwang/bufjump.nvim", config = require("user.plugins.bufjump").config, lock = M.l["bufjump"] },
    -- <Space>ba, <Space>bd, <Space>bh, <Space>bo to delete buffers.
    {
      "kazhala/close-buffers.nvim",
      config = require("user.plugins.close_buffers").config,
      lock = M.l["close-buffers"],
    },
    -- Adds context when cycling buffers with <S-h> and <S-l>.
    {
      "ghillb/cybu.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = require("user.plugins.cybu").config,
      lock = M.l["cybu"],
    },
    -- Tag files and quickly switch between them with <Leader>h and <A-1>, <A-2>, <A-3>, <A-4>, <A-5>, and <A-6>.
    {
      "ThePrimeagen/harpoon",
      requires = { "nvim-lua/plenary.nvim" },
      config = require("user.plugins.harpoon").config,
      lock = M.l["harpoon"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Colors                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "svitax/fennec-gruvbox.nvim", branch = "gruvbox-baby" },
    -- TODO: gruvbox-baby blue_gray color clashes with other colors. find better alternative, or change MatchParen fg.
    { "luisiacc/gruvbox-baby", lock = M.l["gruvbox-baby"] },
    -- Color highlighter.
    {
      "norcalli/nvim-colorizer.lua",
      config = require("user.plugins.colorizer").config,
      lock = M.l["nvim-colorizer"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Completion                        │
    -- ╰──────────────────────────────────────────────────────────╯
    -- nvim-cmp source for vim's cmdline.
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp", lock = M.l["cmp-cmdline"] },
    { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim", after = "nvim-cmp", lock = M.l["cmp-git"] },
    -- { "custompro98/cmp-kitty", after = "nvim-cmp", disable = lvim.work },
    -- nvim-cmp source for Neovim plugins.
    {
      "KadoBOT/cmp-plugins",
      after = "nvim-cmp",
      config = require("user.plugins.cmp_plugins").config,
      lock = M.l["cmp-plugins"],
    },
    -- nvim-cmp source for ripgrep.
    { "lukas-reineke/cmp-rg", after = "nvim-cmp", lock = M.l["cmp-rg"] },
    { "davidsierradz/cmp-conventionalcommits", after = "nvim-cmp", lock = M.l["cmp-conventionalcommits"] },
    --  ╭──────────────────────────────────────────────────────────╮
    --  │                        Databases                         │
    --  ╰──────────────────────────────────────────────────────────╯
    -- TODO: learn how to use vim-dadbod
    -- { "tpope/vim-dadbod" },
    -- {
    --   "kristijanhusak/vim-dadbod-ui",
    --   config = function()
    --     require("user.keymaps").set_dbui_keymaps()
    --   end,
    -- },
    -- { "kristijanhusak/vim-dadbod-completion" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Debugging                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- Already in Lunarvim core
    -- { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = require("user.plugins.dapui").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Editing                          │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: add nvim-spectre alternative.
    -- <Space>c to beautify comments using boxes and lines.
    {
      "LudoPinelli/comment-box.nvim",
      config = require("user.plugins.comment_box").config,
      lock = M.l["comment-box"],
    },
    -- { "gbprod/cutlass.nvim" },
    -- <Space>lr for incremental LSP renaming based on Neovim's command-preview feature.
    { "smjonas/inc-rename.nvim", config = require("user.plugins.inc_rename").config, lock = M.l["inc-rename"] },
    -- <Space>lg to generate annotations.
    { "danymat/neogen", config = require("user.plugins.neogen").config, lock = M.l["neogen"] },
    -- wisely add "end" in ruby, lua, vimscript, etc. treesitter aware.
    { "RRethy/nvim-treesitter-endwise", lock = M.l["treesitter-endwise"] },
    -- <Space>i to do current word or LSP text case conversion.
    { "johmsalas/text-case.nvim", config = require("user.plugins.textcase").config, lock = M.l["text-case"] },
    -- <A-n> and <A-p> to cycle through yank history (like Emacs 'kill-ring.')
    -- TODO: fix issue where "p" with YankyPutAfter and yanky_hydra:activate makes it so p doesn't work in macros.
    -- TODO: should I use YankyPut or YankyGPut as default for "p".
    { "gbprod/yanky.nvim", config = require("user.plugins.yanky").config, lock = M.l["yanky"] },
    -- TODO: add vim-visual-multi
    -- { "mg979/vim-visual-multi" },
    -- TODO: fix nvim-surround 'ys' not working with yanky.
    -- add/delete/change surroundings with ys{motion}{char}, ds{char}, and cs{target}{replacement}
    {
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup {
          keymaps = {
            -- I just don't want this to conflict with visual S for leap backward
            visual = "gX",
          },
        }
        -- TODO: change default highlight group for NvimSurroundHighlight to same as matching pair.
        -- highlight default link NvimSurroundHighlight --matching pair?
      end,
      lock = M.l["nvim-surround"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Files                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <Space>f to use lf file manager within Neovim. Allows me to use many other file managers as well.
    { "is0n/fm-nvim", config = require("user.plugins.fm").config, lock = M.l["fm-nvim"] },
    { "smartpde/telescope-recent-files", config = require("user.plugins.recent_files").config, lock = M.l["telescope-recent-files"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                           Git                            │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: set_gh_keymaps()
    -- {
    --   "ldelossa/gh.nvim",
    --   requires = { { "ldelossa/litee.nvim" } },
    --   config = require("user.plugins.gh").config,
    --   disable = lvim.work,
    -- },
    -- vim-floaterm has the best integration with lazygit, I can open things to edit directly in current Neovim instance.
    -- TODO: refactor vim-floaterm config into separate file or replace with unception.
    {
      "voldikss/vim-floaterm",
      config = function()
        vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
        vim.g.floaterm_width = 0.99
        vim.g.floaterm_height = 0.99
        vim.g.floaterm_title = " lazygit "
        vim.g.floaterm_opener = "tabe"
        require("user.keymaps").set_lazygit_keymaps()
      end,
      lock = M.l["vim-floaterm"],
    },
    -- TODO: setup better diffview mappings with hydra. need merge conflict mappings.
    {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("diffview").setup {}
      end,
      lock = M.l["diffview"],
    },
    -- TODO: add gitlinker.nvim
    -- { "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" },
    --  ╭──────────────────────────────────────────────────────────╮
    --  │                         Keymaps                          │
    --  ╰──────────────────────────────────────────────────────────╯
    { "anuvyklack/hydra.nvim", config = require("user.plugins.hydra").config, lock = M.l["hydra"] },
    -- TODO: do I need legendary.nvim?
    { "mrjones2014/legendary.nvim", config = require("user.plugins.legendary").config, lock = M.l["legendary"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                           LSP                            │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = require("user.plugins.lspsaga").config,
      lock = M.l["lspsaga"],
    },
    -- TODO: wait until anticonceal is in stable, then attempt to make this work.
    -- {
    --   "lvimuser/lsp-inlayhints.nvim",
    --   config = function()
    --     require("lsp-inlayhints").setup {}
    --   end,
    --   lock = M.l["lsp-inlayhints"],
    -- },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Navigation                        │
    -- ╰──────────────────────────────────────────────────────────╯
    -- Smooth scrolling for any movement commands (<C-u>, <C-d>, <C-b>, <C-f>, <C-o>, <C-i>, etc.)
    { "declancm/cinnamon.nvim", config = require("user.plugins.cinnamon").config, lock = M.l["cinnamon"] },
    -- Enchanced f/t motions with Leap. clever-f style repeat with the trigger key itself.
    {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup {}
      end,
      lock = M.l["flit"],
    },
    -- General-purpose motion with s/S.
    { "ggandor/leap.nvim", config = require("user.plugins.leap").config, lock = M.l["leap"] },
    -- Mark files with <Leader>a and navigate to them with <Leader>i or <Leader>o
    -- {
    --   "cbochs/grapple.nvim",
    --   config = function()
    --     require("grapple").setup {}
    --     require("user.keymaps").set_grapple_keymaps()
    --   end,
    --   lock = M.l["grapple"],
    -- },
    -- Improved jumplist navigation with <A-i>/<A-o> (for different files only), and <C-i>/<C-o>.
    -- {
    --   "cbochs/portal.nvim",
    --   requires = { "cbochs/grapple.nvim" },
    --   config = function()
    --     require("portal").setup {}
    --     require("user.keymaps").set_portal_keymaps()
    --   end,
    --   lock = M.l["portal"]
    -- },
    -- TODO: add telescope-hop bindings to all telescope pickers
    { "nvim-telescope/telescope-hop.nvim", lock = M.l["telescope-hop"] },
    -- TODO: add vim-wordmotion
    -- { "chaoren/vim-wordmotion", event = "BufRead" },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Notes                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <Space>np for live markdown preview.
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      config = require("user.plugins.markdown_preview").config,
      ft = { "markdown" },
      disable = lvim.work,
      lock = M.l["markdown-preview"],
    },
    -- Lightweight vimwiki for markdown.
    { "jakewvincent/mkdnflow.nvim", config = require("user.plugins.mkdnflow").config, lock = M.l["mkdnflow"] },
    { "preservim/vim-markdown", config = require("user.plugins.vim-markdown").config, lock = M.l["vim-markdown"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Projects                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: do I need opener.nvim?
    { "willthbill/opener.nvim", config = require("user.plugins.opener").config, lock = M.l["opener"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Quickfix                         │
    -- ╰──────────────────────────────────────────────────────────╯
    { "kevinhwang91/nvim-bqf", lock = M.l["nvim-bqf"] },
    -- Prettier quickfix/location list windows.
    {
      "https://gitlab.com/yorickpeterse/nvim-pqf.git",
      config = require("user.plugins.pqf").config,
      lock = M.l["nvim-pqf"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Sessions                         │
    -- ╰──────────────────────────────────────────────────────────╯

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Syntax                          │
    -- ╰──────────────────────────────────────────────────────────╯
    -- Syntax highlighting for lfrc.
    { "VebbNix/lf-vim", lock = M.l["lf-vim"] },
    { "nvim-treesitter/playground", lock = M.l["playground"] },
    {
      "zbirenbaum/neodim",
      -- event = "LspAttach",
      config = function()
        require("neodim").setup { blend_color = "#282828", alpha = 0.60 }
      end,
      lock = M.l["neodim"],
    },
    -- { "fladson/vim-kitty", event = "BufRead" },
    -- { "romgrk/nvim-treesitter-context" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Tasks                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: learn how to use asynctasks
    {
      "skywind3000/asynctasks.vim",
      requires = { "skywind3000/asyncrun.vim", "preservim/vimux" },
      config = require("user.plugins.asynctasks").config,
      lock = M.l["asynctasks"],
    },
    {
      "GustavoKatel/telescope-asynctasks.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
      lock = M.l["telescope-asynctasks"],
    },
    { "vim-test/vim-test", config = require("user.plugins.vim-test").config, lock = M.l["vim-test"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                            UI                            │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: do I need dressing.nvim?
    { "stevearc/dressing.nvim", config = require("user.plugins.dressing").config, lock = M.l["dressing"] },
    -- TODO: do I need marks.nvim?
    { "chentoast/marks.nvim", config = require("user.plugins.marks").config, lock = M.l["marks"] },
    {
      "echasnovski/mini.nvim",
      branch = "stable",
      config = function()
        require("user.plugins.indentscope").config()
      end,
      lock = M.l["mini"],
    },
    {
      "folke/noice.nvim",
      config = require("user.plugins.noice").config(),
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      lock = M.l["noice"],
    },
    -- { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = require("user.plugins.ufo").config },
    { "lewis6991/satellite.nvim", config = require("user.plugins.satellite").config, lock = M.l["satellite"] },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          highlight = {
            multiline = false,
          },
        }
      end,
      lock = M.l["todo-comments"],
    },
    -- TODO: live-command's Norm doesn't work if you want to insert spaces (it just keeps repeating the prev inserts.)
    {
      "smjonas/live-command.nvim",
      -- live-command supports semantic versioning via tags
      -- tag = "1.*",
      config = function()
        require("live-command").setup {
          commands = {
            Norm = { cmd = "norm" },
          },
        }
      end,
      lock = M.l["live-command"],
    },
    -- mostly useful when you have at least 3 windows open, not sure if I wanna use this
    -- {
    --   "nvim-zh/colorful-winsep.nvim",
    --   config = function()
    --     require("colorful-winsep").setup {}
    --   end,
    -- },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Web Dev                          │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = require("user.plugins.package_info").config,
      lock = M.l["package-info"],
    },
    {
      "David-Kunz/cmp-npm",
      requires = { "nvim-lua/plenary.nvim" },
      -- { name = 'npm', keyword_length = 4 }
      lock = M.l["cmp-npm"],
    },
    {
      "kalvinpearce/gitignore-gen.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
      lock = M.l["gitignore-gen"],
    },
    -- TODO: add a filetype dependent which_key mapping on "" for typescript.nvim
    {
      "jose-elias-alvarez/typescript.nvim",
      config = function()
        require("typescript").setup {}
        -- prevent Lunarvim from setting up tsserver so typescript.nvim can do it instead.
        ---@diagnostic disable-next-line: missing-parameter
        vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
      end,
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Windows                          │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "mrjones2014/smart-splits.nvim",
      config = require("user.plugins.smart_splits").config,
      lock = M.l["smart-splits"],
    },
    { "declancm/windex.nvim", config = require("user.plugins.windex").config, lock = M.l["windex"] },
    { "sindrets/winshift.nvim", config = require("user.plugins.winshift").config, lock = M.l["winshift"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                     Optional plugins                     │
    -- ╰──────────────────────────────────────────────────────────╯
    -- { "wakatime/vim-wakatime", disable = lvim.work },
  }
end

-- Last Lunarvim update: Nov. 03 2022 (1eb4188)
-- Last core Lunarvim plugins update: Nov. 04 2022
-- Last plugins update: Nov. 02 2022
M.l = {
  -- "kwkarlwang/bufjump.nvim"
  ["bufjump"] = true,
  -- "kazhala/close-buffers.nvim"
  ["close-buffers"] = true,
  -- "ghillb/cybu.nvim"
  ["cybu"] = true,
  -- "ThePrimeagen/harpoon"
  ["harpoon"] = true,
  -- "luisiacc/gruvbox-baby"
  ["gruvbox-baby"] = true,
  -- "norcalli/nvim-colorizer.lua"
  ["nvim-colorizer"] = true,
  -- "hrsh7th/cmp-cmdline"
  ["cmp-cmdline"] = true,
  -- "petertriho/cmp-git"
  ["cmp-git"] = true,
  -- "KadoBOT/cmp-plugins"
  ["cmp-plugins"] = true,
  -- "lukas-reineke/cmp-rg"
  ["cmp-rg"] = true,
  -- "davidsierradz/cmp-conventionalcommits"
  ["cmp-conventionalcommits"] = true,
  -- "LudoPinelli/comment-box.nvim"
  ["comment-box"] = true,
  -- "smjonas/inc-rename.nvim"
  ["inc-rename"] = true,
  -- "danymat/neogen"
  ["neogen"] = true,
  -- "RRethy/nvim-treesitter-endwise"
  ["treesitter-endwise"] = true,
  -- "johmsalas/text-case.nvim"
  ["text-case"] = true,
  -- "gbprod/yanky.nvim"
  ["yanky"] = true,
  -- "kylechui/nvim-surround"
  ["nvim-surround"] = true,
  -- "is0n/fm-nvim"
  ["fm-nvim"] = true,
  -- "smartpde/telescope-recent-files"
  ["telescope-recent-files"] = true,
  -- "voldikss/vim-floaterm"
  ["vim-floaterm"] = true,
  -- "sindrets/diffview.nvim"
  ["diffview"] = true,
  -- "anuvyklack/hydra.nvim"
  ["hydra"] = true,
  -- "mrjones2014/legendary.nvim"
  ["legendary"] = true,
  -- "glepnir/lspsaga.nvim"
  ["lspsaga"] = true,
  -- "lvimuser/lsp-inlayhints.nvim"
  ["lsp-inlayhints"] = true,
  -- "declancm/cinnamon.nvim"
  ["cinnamon"] = true,
  -- "ggandor/leap.nvim"
  ["leap"] = true,
  -- "ggandor/flit.nvim"
  ["flit"] = true,
  --   "cbochs/grapple.nvim",
  ["grapple"] = true,
  --   "cbochs/portal.nvim",
  ["portal"] = true,
  -- "nvim-telescope/telescope-hop.nvim"
  ["telescope-hop"] = true,
  -- "iamcco/markdown-preview.nvim"
  ["markdown-preview"] = true,
  -- "jakewvincent/mkdnflow.nvim"
  ["mkdnflow"] = true,
  -- "preservim/vim-markdown"
  ["vim-markdown"] = true,
  -- "willthbill/opener.nvim"
  ["opener"] = true,
  -- "kevinhwang91/nvim-bqf"
  ["nvim-bqf"] = true,
  -- "https://gitlab.com/yorickpeterse/nvim-pqf.git"
  ["nvim-pqf"] = true,
  -- "VebbNix/lf-vim"
  ["lf-vim"] = true,
  -- "nvim-treesitter/playground"
  ["playground"] = true,
  -- "zbirenbaum/neodim"
  ["neodim"] = true,
  -- "skywind3000/asynctasks.vim"
  ["asynctasks"] = true,
  -- "GustavoKatel/telescope-asynctasks.nvim"
  ["telescope-asynctasks"] = true,
  -- "vim-test/vim-test"
  ["vim-test"] = true,
  -- "stevearc/dressing.nvim"
  ["dressing"] = true,
  -- "chentoast/marks.nvim"
  ["marks"] = true,
  -- "echasnovski/mini.nvim"
  ["mini"] = true,
  -- "folke/noice.nvim"
  ["noice"] = true,
  -- "lewis6991/satellite.nvim",
  ["satellite"] = true,
  -- "folke/todo-comments.nvim"
  ["todo-comments"] = true,
  -- "smjonas/live-command.nvim"
  ["live-command"] = true,
  -- "vuki656/package-info.nvim",
  ["package-info"] = true,
  -- "David-Kunz/cmp-npm"
  ["cmp-npm"] = true,
  -- "kalvinpearce/gitignore-gen.nvim"
  ["gitignore-gen"] = true,
  -- "mrjones2014/smart-splits.nvim"
  ["smart-splits"] = true,
  -- "declancm/windex.nvim"
  ["windex"] = true,
  -- "sindrets/winshift.nvim"
  ["winshift"] = true,
}

return M
