local M = {}

M.config = function()
  lvim.plugins = {
    { "~/Desktop/projects/dirvish.nvim" },
    {
      "rktjmp/hotpot.nvim",
      config = function()
        require("hotpot").setup {
          enable_hotpot_diagnostics = false,
        }
      end,
    },
    { "eraserhd/parinfer-rust", run = "cargo build --release" },
    {
      "harrygallagher4/nvim-parinfer-rust",
      event = "InsertEnter",
      config = function()
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            require("parinfer").setup()
          end,
        })
      end,
    },
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
    { "nyoom-engineering/oxocarbon.nvim" },
    -- TODO: gruvbox-baby blue_gray color clashes with other colors. find better alternative, or change MatchParen fg.
    { "luisiacc/gruvbox-baby", lock = M.l["gruvbox-baby"] },
    -- Color highlighter.
    {
      "brenoprata10/nvim-highlight-colors",
      config = require("user.plugins.nvim_highlight_colors").config,
      lock = M.l["nvim-highlight-colors"],
    },
    -- Color highlighter for tailwindcss and any lsp servers that support textDocument/documentColor
    {
      "mrshmllow/document-color.nvim",
      config = require("user.plugins.document_color").config,
      lock = M.l["document-color"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Completion                        │
    -- ╰──────────────────────────────────────────────────────────╯
    -- nvim-cmp source for vim's cmdline.
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp", lock = M.l["cmp-cmdline"] },
    { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim", after = "nvim-cmp", lock = M.l["cmp-git"] },
    -- { "custompro98/cmp-kitty", after = "nvim-cmp", disable = lvim.work },
    -- nvim-cmp source for ripgrep.
    -- { "lukas-reineke/cmp-rg", after = "nvim-cmp", lock = M.l["cmp-rg"] },
    { "davidsierradz/cmp-conventionalcommits", after = "nvim-cmp", lock = M.l["cmp-conventionalcommits"] },
    { "PaterJason/cmp-conjure", after = "nvim-cmp" },
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
    { "gbprod/yanky.nvim", config = require("user.plugins.yanky").config, lock = M.l["yanky"] },
    -- TODO: add vim-visual-multi
    -- { "mg979/vim-visual-multi" },
    -- add/delete/change surroundings with ys{motion}{char}, ds{char}, and cs{target}{replacement}
    {
      "kylechui/nvim-surround",
      config = require("user.plugins.nvim_surround").config,
      lock = M.l["nvim-surround"],
    },
    {
      "monaqa/dial.nvim",
      config = require("user.plugins.dial").config,
      lock = M.l["dial"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Files                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <Space>f to use lf file manager within Neovim. Allows me to use many other file managers as well.
    { "is0n/fm-nvim", config = require("user.plugins.fm").config, lock = M.l["fm-nvim"] },
    { "smartpde/telescope-recent-files", config = require("user.plugins.recent_files").config, lock = M.l["telescope-recent-files"] },
    -- {
    --   "SidOfc/carbon.nvim",
    --   config = function()
    --     require("carbon").setup {
    --       auto_open = false,
    --     }
    --   end,
    -- },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                           Git                            │
    -- ╰──────────────────────────────────────────────────────────╯
    { "TimUntersberger/neogit" },
    {
      "eddyekofo94/gruvbox-flat.nvim",
      config = function()
        vim.g.gruvbox_flat_style = "hard"
      end,
    },
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
    -- TODO: wait until anticonceal is in stable, then attempt to make this work (and with tsserver).
    {
      "lvimuser/lsp-inlayhints.nvim",
      config = function()
        require("lsp-inlayhints").setup {}
      end,
      lock = M.l["lsp-inlayhints"],
    },
    {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end,
    },
    {
      "Olical/conjure",
      config = function()
        -- vim.cmd [[let g:conjure#filetype#fennel = 'conjure.client.fennel.stdio' ]]
      end,
    },
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
    -- TODO: add vim-wordmotion
    -- { "chaoren/vim-wordmotion", event = "BufRead" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Notes                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: do I need mkdnflow
    -- Lightweight vimwiki for markdown.
    -- { "jakewvincent/mkdnflow.nvim", config = require("user.plugins.mkdnflow").config, lock = M.l["mkdnflow"] },
    -- { "preservim/vim-markdown", config = require("user.plugins.vim-markdown").config, lock = M.l["vim-markdown"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Projects                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: do I need opener.nvim?
    -- { "willthbill/opener.nvim", config = require("user.plugins.opener").config, lock = M.l["opener"] },
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
      config = require("user.plugins.neodim").config,
      lock = M.l["neodim"],
    },
    -- { "fladson/vim-kitty", event = "BufRead" },
    -- Sticky headers
    { "romgrk/nvim-treesitter-context", lock = M.l["treesitter-context"] },
    -- { "miversen33/import.nvim", lock = M.l["import"] },
    {
      "m-demare/hlargs.nvim",
      requires = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("hlargs").setup {}
      end,
      lock = M.l["hlargs"],
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Tasks                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- -- TODO: learn how to use asynctasks
    -- {
    --   "skywind3000/asynctasks.vim",
    --   requires = { "skywind3000/asyncrun.vim", "preservim/vimux" },
    --   config = require("user.plugins.asynctasks").config,
    --   lock = M.l["asynctasks"],
    -- },
    -- {
    --   "GustavoKatel/telescope-asynctasks.nvim",
    --   requires = {
    --     "nvim-lua/popup.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "nvim-telescope/telescope.nvim",
    --   },
    --   lock = M.l["telescope-asynctasks"],
    -- },
    -- { "vim-test/vim-test", config = require("user.plugins.vim-test").config, lock = M.l["vim-test"] },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                            UI                            │
    -- ╰──────────────────────────────────────────────────────────╯
    { "stevearc/dressing.nvim", config = require("user.plugins.dressing").config, lock = M.l["dressing"] },
    -- TODO: do I need marks.nvim?
    -- { "chentoast/marks.nvim", config = require("user.plugins.marks").config, lock = M.l["marks"] },
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
      requires = { "MunifTanjim/nui.nvim" },
      lock = M.l["noice"],
    },
    -- { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = require("user.plugins.ufo").config, lock = M.l["ufo"] },
    { "lewis6991/satellite.nvim", config = require("user.plugins.satellite").config, lock = M.l["satellite"] },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = require("user.plugins.todo_comments").config,
      lock = M.l["todo-comments"],
    },
    -- TODO: live-command's Norm doesn't work if you want to insert spaces (it just keeps repeating the prev inserts.)
    -- {
    --   "smjonas/live-command.nvim",
    --   -- live-command supports semantic versioning via tags
    --   -- tag = "1.*",
    --   config = function()
    --     require("live-command").setup {
    --       commands = {
    --         Norm = { cmd = "norm" },
    --       },
    --     }
    --   end,
    --   lock = M.l["live-command"],
    -- },
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
    -- {
    --   "kalvinpearce/gitignore-gen.nvim",
    --   requires = { { "nvim-lua/plenary.nvim" } },
    --   lock = M.l["gitignore-gen"],
    -- },
    -- TODO: lsp-inlayhints in typescript conflicts with typescript.nvim
    {
      "jose-elias-alvarez/typescript.nvim",
      config = function()
        require("typescript").setup {}
        -- prevent Lunarvim from setting up tsserver so typescript.nvim can do it instead.
        ---@diagnostic disable-next-line: missing-parameter
        vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
      end,
      lock = M.l["typescript"],
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

-- Last Lunarvim update: Nov. 13 2022 ()
-- Last core Lunarvim plugins update: Nov. 13 2022
-- Last plugins update: Nov. 17 2022
M.l = {
  -- "kwkarlwang/bufjump.nvim"
  ["bufjump"] = false,
  -- "kazhala/close-buffers.nvim"
  ["close-buffers"] = false,
  -- "ghillb/cybu.nvim"
  ["cybu"] = false,
  -- "ThePrimeagen/harpoon"
  ["harpoon"] = false,
  -- "luisiacc/gruvbox-baby"
  ["gruvbox-baby"] = false,
  -- "brenoprata10/nvim-highlight-colors"
  ["nvim-highlight-colors"] = false,
  -- "mrshmllow/document-color.nvim"
  ["document-color"] = false,
  -- "hrsh7th/cmp-cmdline"
  ["cmp-cmdline"] = false,
  -- "petertriho/cmp-git"
  ["cmp-git"] = false,
  -- "lukas-reineke/cmp-rg"
  ["cmp-rg"] = false,
  -- "davidsierradz/cmp-conventionalcommits"
  ["cmp-conventionalcommits"] = false,
  -- "LudoPinelli/comment-box.nvim"
  ["comment-box"] = false,
  -- "smjonas/inc-rename.nvim"
  ["inc-rename"] = false,
  -- "danymat/neogen"
  ["neogen"] = false,
  -- "RRethy/nvim-treesitter-endwise"
  ["treesitter-endwise"] = false,
  -- "johmsalas/text-case.nvim"
  ["text-case"] = false,
  -- "gbprod/yanky.nvim"
  ["yanky"] = false,
  -- "kylechui/nvim-surround"
  ["nvim-surround"] = false,
  -- "monaqa/dial.nvim"
  ["dial"] = false,
  -- "is0n/fm-nvim"
  ["fm-nvim"] = false,
  -- "smartpde/telescope-recent-files"
  ["telescope-recent-files"] = false,
  -- "voldikss/vim-floaterm"
  ["vim-floaterm"] = false,
  -- "sindrets/diffview.nvim"
  ["diffview"] = false,
  -- "anuvyklack/hydra.nvim"
  ["hydra"] = false,
  -- "mrjones2014/legendary.nvim"
  ["legendary"] = false,
  -- "glepnir/lspsaga.nvim"
  ["lspsaga"] = false,
  -- "lvimuser/lsp-inlayhints.nvim"
  ["lsp-inlayhints"] = false,
  -- "declancm/cinnamon.nvim"
  ["cinnamon"] = false,
  -- "ggandor/leap.nvim"
  ["leap"] = false,
  -- "ggandor/flit.nvim"
  ["flit"] = false,
  --   "cbochs/grapple.nvim",
  ["grapple"] = false,
  --   "cbochs/portal.nvim",
  ["portal"] = false,
  -- "nvim-telescope/telescope-hop.nvim"
  ["telescope-hop"] = false,
  -- "iamcco/markdown-preview.nvim"
  ["markdown-preview"] = false,
  -- "jakewvincent/mkdnflow.nvim"
  ["mkdnflow"] = false,
  -- "preservim/vim-markdown"
  ["vim-markdown"] = false,
  -- "willthbill/opener.nvim"
  ["opener"] = false,
  -- "kevinhwang91/nvim-bqf"
  ["nvim-bqf"] = false,
  -- "https://gitlab.com/yorickpeterse/nvim-pqf.git"
  ["nvim-pqf"] = false,
  -- "VebbNix/lf-vim"
  ["lf-vim"] = false,
  -- "nvim-treesitter/playground"
  ["playground"] = false,
  -- "zbirenbaum/neodim"
  ["neodim"] = false,
  ["treesitter-context"] = false,
  ["import"] = false,
  ["hlargs"] = false,
  -- "skywind3000/asynctasks.vim"
  ["asynctasks"] = false,
  -- "GustavoKatel/telescope-asynctasks.nvim"
  ["telescope-asynctasks"] = false,
  -- "vim-test/vim-test"
  ["vim-test"] = false,
  -- "stevearc/dressing.nvim"
  ["dressing"] = false,
  -- "chentoast/marks.nvim"
  ["marks"] = false,
  -- "echasnovski/mini.nvim"
  ["mini"] = false,
  -- "folke/noice.nvim"
  ["noice"] = false,
  -- "kevinhwang91/nvim-ufo"
  ["ufo"] = false,
  -- "lewis6991/satellite.nvim",
  ["satellite"] = false,
  -- "folke/todo-comments.nvim"
  ["todo-comments"] = false,
  -- "smjonas/live-command.nvim"
  ["live-command"] = false,
  -- "vuki656/package-info.nvim",
  ["package-info"] = false,
  -- "David-Kunz/cmp-npm"
  ["cmp-npm"] = false,
  -- "kalvinpearce/gitignore-gen.nvim"
  ["gitignore-gen"] = false,
  -- "jose-elias-alvarez/typescript.nvim"
  ["typescript"] = false,
  -- "mrjones2014/smart-splits.nvim"
  ["smart-splits"] = false,
  -- "declancm/windex.nvim"
  ["windex"] = false,
  -- "sindrets/winshift.nvim"
  ["winshift"] = false,
}

return M
