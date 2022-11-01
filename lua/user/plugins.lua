local M = {}

M.config = function()
  -- Additional Plugins
  lvim.plugins = {
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Buffers                          │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <A-o> and <A-i> to jump to previous and next buffer on jumplist (mimics <C-o> and <C-i>.)
    { "kwkarlwang/bufjump.nvim", config = require("user.plugins.bufjump").config },
    -- <Space>ba, <Space>bd, <Space>bh, <Space>bo to delete buffers.
    { "kazhala/close-buffers.nvim", config = require("user.plugins.close_buffers").config },
    -- Adds context when cycling buffers with <S-h> and <S-l>.
    { "ghillb/cybu.nvim", requires = { "kyazdani42/nvim-web-devicons" }, config = require("user.plugins.cybu").config },
    { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim", config = require("user.plugins.harpoon").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Colors                          │
    -- ╰──────────────────────────────────────────────────────────╯
    { "svitax/fennec-gruvbox.nvim", branch = "gruvbox-baby" },
    { "luisiacc/gruvbox-baby", disable = lvim.work },
    -- Color highlighter.
    { "norcalli/nvim-colorizer.lua", config = require("user.plugins.colorizer").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Completion                        │
    -- ╰──────────────────────────────────────────────────────────╯
    -- nvim-cmp source for vim's cmdline.
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    -- { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim", after = "nvim-cmp", disable = lvim.work },
    -- { "custompro98/cmp-kitty", after = "nvim-cmp", disable = lvim.work },
    -- { "dburian/cmp-markdown-link", after = "nvim-cmp", disable = lvim.work },
    -- nvim-cmp source for Neovim plugins.
    { "KadoBOT/cmp-plugins", after = "nvim-cmp", config = require("user.plugins.cmp_plugins").config },
    -- nvim-cmp source for ripgrep.
    { "lukas-reineke/cmp-rg", after = "nvim-cmp" },
    -- { "tzachar/cmp-tabnine", run = "./install.sh", after = "nvim-cmp", disable = lvim.work },
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
    -- { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = require("user.plugins.dapui").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Editing                          │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <Space>c to beautify comments using boxes and lines.
    { "LudoPinelli/comment-box.nvim", config = require("user.plugins.comment_box").config },
    -- { "gbprod/cutlass.nvim" },
    -- <Space>lr for incremental LSP renaming based on Neovim's command-preview feature.
    { "smjonas/inc-rename.nvim", config = require("user.plugins.inc_rename").config },
    -- <Space>lg to generate annotations.
    { "danymat/neogen", config = require("user.plugins.neogen").config },
    -- TODO: add nvim-spectre alternative.
    -- { "windwp/nvim-spectre", requires = "nvim-lua/plenary.nvim", config = require("user.plugins.spectre").config },
    -- wisely add "end" in ruby, lua, vimscript, etc. treesitter aware.
    { "RRethy/nvim-treesitter-endwise" },
    -- <Space>i to do current word or LSP text case conversion.
    { "johmsalas/text-case.nvim", config = require("user.plugins.textcase").config },
    -- <A-n> and <A-p> to cycle through yank history (like Emacs 'kill-ring.')
    { "gbprod/yanky.nvim", config = require("user.plugins.yanky").config },
    -- TODO: add vim-visual-multi
    -- { "mg979/vim-visual-multi" },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                          Files                           │
    -- ╰──────────────────────────────────────────────────────────╯
    -- <Space>f to use lf file manager within Neovim. Allows me to use many other file managers as well.
    { "is0n/fm-nvim", config = require("user.plugins.fm").config },
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
    { "kdheepak/lazygit.nvim", config = require("user.plugins.lazygit").config },
    { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim", config = require("neogit").setup {} },
    {
      "tpope/vim-fugitive",
      config = function()
        -- TODO: create a hydra for vim-fugitive?
        -- <Space>gg = :Ge: -- git status
        -- P (:Git push) -- git push
        -- p (:Git pull) -- git pull
        -- f (:Git fetch) -- git fetch
        -- m (:Git merge) -- git merge
        -- s (fugitive_s) stage (add) file or hunk under cursor
        -- u (fugitive_u) unstage (reset) file or hunk under cursor
        -- - (fugitive_-) stage or unstage file or hunk under cursor
        -- U (fugitive_U) unstage everything
        -- = (fugitive_=) toggle inline diff of file under the cursor
        -- o (fugitive_o) open file in new horiz split
        -- gO (fugitive_gO) open file in new vertical split
        -- cvc -- create a commit
        -- cva -- ammend last commit and edit message
        -- cw -- reword last commit
        -- q -- quit
        -- l (:Git log) -- git log?
        -- ?? (:G remote -v) -- make this not show up in messages?
        -- ?? (:G add remote origin [ssh github link]) -- populate cmdline with this
      end,
    },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                           LSP                            │
    -- ╰──────────────────────────────────────────────────────────╯
    -- { "j-hui/fidget.nvim", config = require("user.plugins.fidget").config },
    -- { "ray-x/lsp_signature.nvim", config = require("user.plugins.lsp_signature").config },
    -- { "weilbith/nvim-code-action-menu", config = require("user.plugins.code_action_menu").config },
    -- { "kosayoda/nvim-lightbulb", config = require("user.plugins.lightbulb").config },
    -- TODO: move lspsaga config into own file
    -- TODO: add a hydra for lspsaga definition action keys?
    {
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        require("lspsaga").init_lsp_saga {
          border_style = "rounded",
          code_action_icon = "ﯦ",
          definition_action_keys = {
            edit = "<A-e>",
            vsplit = "<A-v>",
            split = "<A-s>",
            tabe = "<A-t>",
            quit = "q",
          },
        }
        require("user.keymaps").set_lspsaga_keymaps()
      end,
    },
    -- { "folke/trouble.nvim", config = require("user.plugins.trouble").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                        Navigation                        │
    -- ╰──────────────────────────────────────────────────────────╯
    -- Smooth scrolling for any movement commands (<C-u>, <C-d>, <C-b>, <C-f>, <C-o>, <C-i>, etc.)
    { "declancm/cinnamon.nvim", config = require("user.plugins.cinnamon").config },
    -- TODO: do I need nvim-hlslens? (similar functionality in noice.nvim)
    -- { "kevinhwang91/nvim-hlslens", config = require("user.plugins.hlslens").config },
    -- General-purpose motion with s/S.
    { "ggandor/leap.nvim", config = require("user.plugins.leap").config },
    -- Enchanced f/t motions with Leap. clever-f style repeat with the trigger key itself.
    {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup {}
      end,
    },
    -- {
    --   "abecodes/tabout.nvim",
    --   wants = { "nvim-treesitter" },
    --   after = { "nvim-cmp" },
    --   config = require("user.plugins.tabout").config,
    -- },
    -- TODO: add telescope-hop bindings to all telescope pickers
    { "nvim-telescope/telescope-hop.nvim" },
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
    },
    -- Lightweight vimwiki for markdown.
    { "jakewvincent/mkdnflow.nvim", config = require("user.plugins.mkdnflow").config },
    { "preservim/vim-markdown", config = require("user.plugins.vim-markdown").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Projects                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: do I need opener.nvim?
    { "willthbill/opener.nvim", config = require("user.plugins.opener").config },
    -- { "charludo/projectmgr.nvim", config = require("user.plugins.projectmgr").config },
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                         Quickfix                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- { "kevinhwang91/nvim-bqf", requires = { { "junegunn/fzf", run = require("user.plugins.fzf").run } } },
    { "kevinhwang91/nvim-bqf" },
    -- Prettier quickfix/location list windows.
    { "https://gitlab.com/yorickpeterse/nvim-pqf.git", config = require("user.plugins.pqf").config },
    -- TODO: do I need qf_helper.nvim?
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
    -- Syntax highlighting for lfrc.
    { "VebbNix/lf-vim", event = "BufRead" },
    { "nvim-treesitter/playground" },
    -- TODO: do I need nabla.nvim?
    { "jbyuki/nabla.nvim" },
    -- { "lervag/vimtex" },
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
    -- TODO: do I need dressing.nvim?
    { "stevearc/dressing.nvim", config = require("user.plugins.dressing").config },
    -- { "anuvyklack/hydra.nvim", requires = "anuvyklack/keymap-layer.nvim", config = require("user.plugins.hydra").config },
    -- TODO: do I need legendary.nvim?
    { "mrjones2014/legendary.nvim", config = require("user.plugins.legendary").config },
    -- TODO: do I need marks.nvim?
    { "chentoast/marks.nvim", config = require("user.plugins.marks").config },
    {
      "echasnovski/mini.nvim",
      branch = "stable",
      config = function()
        -- TODO: figure out how to use ys with yanky
        require("user.plugins.surround").config()
        require("user.plugins.indentscope").config()
      end,
    },
    {
      "folke/noice.nvim",
      event = "VimEnter",
      config = require("user.plugins.noice").config(),
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
        require("todo-comments").setup {
          highlight = {
            multiline = false,
          },
        }
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
