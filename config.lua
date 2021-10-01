-- General LunarVim options
-- =========================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "fennec-gruvbox"
lvim.leader = "space"

-- General Neovim options
-- =========================================
vim.o.timeoutlen = 200
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 20
vim.o.foldtext =
  [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.o.fillchars = "fold: "
vim.o.foldnestmax = 3
vim.o.foldminlines = 1
vim.opt.showtabline = 0
vim.opt.relativenumber = true
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
-- vim.opt.pumblend = 10 -- Popup blend auto_open

-- User config (not builtin)
-- =========================================
-- winblend screws up the colors in toggleterm for me
lvim.winblend = 0

-- Bufferline (builtin)
-- =========================================
lvim.builtin.bufferline.active = false

-- Comment (builtin)
-- =========================================
lvim.builtin.comment.on_config_done = function()
  require("nvim_comment").setup {
    hook = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  }
end

-- Dap and Debugging (builtin)
-- =========================================
lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = function()
  require("user.dap").config()
end

-- Dashboard (builtin)
-- =========================================
lvim.builtin.dashboard.active = true
-- require("user.dashboard").config()

-- LSP
-- =========================================
lvim.lsp.diagnostics.virtual_text = false

-- lsp install

-- Languages
-- =========================================
lvim.lang.emmet.active = true
lvim.lang.markdown = {}
lvim.lang.typescript.on_attach = function(client, _)
  require("nvim-lsp-ts-utils").setup_client(client)
end
lvim.lang.typescriptreact.on_attach = lvim.lang.typescript.on_attach
-- lvim.lang.javascript.on_attach = lvim.lang.typescript.on_attach
-- lvim.lang.javascriptreact.on_attach = lvim.lang.typescript.on_attach

lvim.builtin.lspinstall.on_config_done = function()
  -- require("user.lsp.tailwind").setup()
  -- need to <C-space> to activate emmet snippets sometimes
  require("user.lsp.emmet").config()
end
require("user.json_schemas").setup()

-- Nvimtree (builtin)
-- =========================================
lvim.builtin.nvimtree.active = true
require("user.nvimtree").config()

-- Statusline (builtin)
-- =========================================
lvim.builtin.lualine.active = true
require("user.lualine").config()
-- require("user.fennec-line.config").config()

-- Terminal (builtin)
-- =========================================
lvim.builtin.terminal.active = true
require("user.toggleterm").config()

-- Telescope (builtin)
-- =========================================
lvim.builtin.telescope.active = true
require "user.telescope.config"()

-- Treesitter (builtin)
-- =========================================
require("user.treesitter").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Mappngs
-- =========================================
require("user.keymappings").config()

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
    ft = "python",
  },
  -----[[------------]]-----
  ---        LSP         ---
  -----]]------------[[-----
  -- { "mfussenegger/nvim-jdtls" },
  -- { 'simrat39/symbols-outline.nvim' },
  -- TODO: get TSLspOrganize and TSPLspImportAll to go off when formatting javascript files
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    config = function()
      require("user.lsp.ts_utils").config()
    end,
    -- event = "BufRead",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
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
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require("lsp_signature").on_attach {
  --       bind = true,
  --       doc_lines = 10,
  --       floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  --       floating_window_above_cur_line = true,
  --       fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  --       hint_enable = false, -- virtual hint enable
  --       max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
  --       -- hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  --       hi_parameter = "Search", -- how your parameter will be highlight
  --       -- to view the hiding contents
  --       max_width = 40, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  --       handler_opts = {
  --         border = "single", -- double, single, shadow, none
  --       },
  --     }
  --   end,
  --   event = "InsertEnter",
  -- },
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
  -----[[------------]]-----
  ---       Syntax       ---
  -----]]------------[[-----
  -- { "s1n7ax/nvim-comment-frame" }, -- (https://github.com/s1n7ax/nvim-comment-frame)
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
  { "dstein64/nvim-scrollview", event = "WinEnter" },
  {
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
      require("neoscroll").setup {
        easing_function = "quadratic", -- Default easing function
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
  { "chaoren/vim-wordmotion" },
  -----[[------------]]-----
  ---     Navigation     ---
  -----]]------------[[-----
  {
    "ggandor/lightspeed.nvim",
    -- keys = { "s", "S", "f", "F" },
    -- event = "BufRead",
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
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
    -- event = "InsertEnter",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  -- {
  --   "golang/vscode-go",
  --   config = function()
  --     -- require("luasnip/loaders/from_vscode").lazy_load()
  --   end,
  --   ft = { "go" },
  -- },
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
}
