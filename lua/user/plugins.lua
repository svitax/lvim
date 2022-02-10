local M = {}

M.config = function()
  lvim.plugins = {
    -- https://gitlab.com/HiPhish/guile.vim
    -- https://github.com/tpope/vim-sexp-mappings-for-regular-people
    { "gpanders/nvim-parinfer" },
    { "Olical/conjure" },
    { "PaterJason/cmp-conjure", config = function ()
      -- vim.g["conjure#mapping#prefix"] = "<Leader>e"
    end },
    { "clojure-vim/vim-jack-in" },
    { "tpope/vim-dispatch" },
    { "adenling/vim-dispatch-neovim" },
    -----[[------------]]-----
    ---        LSP         ---
    -----]]------------[[-----
    require "user.plugins.lightbulb",
    require "user.plugins.code-action-menu",
    require "user.plugins.lsp-signature",
    require "user.plugins.trouble",
    -----[[------------]]-----
    ---       Python       ---
    -----]]------------[[-----
    -- TODO: merge into a single treesitter file
    require "user.plugins.treesitter-pyfold",
    -----[[------------]]-----
    ---     TypeScript     ---
    -----]]------------[[-----
    require "user.plugins.lsp-ts-utils",
    require "user.plugins.package-info",
    require "user.plugins.schemastore",
    -- require "user.tailwindcss-colors",
    -- TODO: emmet ls or emmet cmp
    -- https://github.com/kozer/emmet-language-server
    -----[[------------]]-----
    ---        Lua         ---
    -----]]------------[[-----
    -- require "user.plugins.lua-dev",
    -----[[------------]]-----
    ---       Golang       ---
    -----]]------------[[-----
    -- tl
    -- TODO: copy the leetcode type snippets from vscode-go-snippets
    require "user.plugins.vscode-go-snippets",
    -- https://github.com/Snyssfx/goerr-nvim
    -- https://github.com/ray-x/go.nvim
    -- TODO: copy the fiber snippets from vscode-go-power
    -- { "Ja7ad/vscode-go-power" },
    -- https://github.com/honnamkuan/vscode-golang-snippets
    -- { "golang/vscode-go", ft = { "go" }, },
    -----[[------------]]-----
    ---        Rust        ---
    -----]]------------[[-----
    -- https://github.com/simrat39/rust-tools.nvim
    -----[[------------]]-----
    ---       Files        ---
    -----]]------------[[-----
    require "user.plugins.harpoon",
    require "user.plugins.close-buffers",
    require "user.plugins.fm",
    -----[[------------]]-----
    ---       Syntax       ---
    -----]]------------[[-----
    -- TODO: merge into a single treesitter file
    require "user.plugins.treesitter-context",
    require "user.plugins.lf-vim",
    require "user.plugins.vim-kitty",
    -- require "user.plugins.treesitter-playground",
    -----[[------------]]-----
    ---        Git         ---
    -----]]------------[[-----
    -- TODO find a comfier way to integrate magit into my config (toggleterm config)
    -- waiting for diff file history in diffview.nvim (there's an issue already put up)
    -- { "ThePrimeagen/git-worktree.nvim" },
    -- { "ruifm/gitlinker.nvim", event = "BufRead"},
    -- { "mattn/vim-gist", event = "BufRead" },
    require "user.plugins.octo",
    -- TODO: change git diff highlights
    require "user.plugins.diffview",
    -- NOTE: using this for merge conflict resolution from lazygit
    require "user.plugins.fugitive",
    -- NOTE: i like lazygit way more
    -- require "user.plugins.neogit",
    -----[[------------]]-----
    ---        Notes       ---
    -----]]------------[[-----
    -- TODO: probably going to replace orgmode with markdown + wiki
    -- require "user.plugins.orgmode",
    -- require "user.plugins.org-bullets",
    -- require "user.plugins.headlines",
    -- require "user.plugins.wiki-vim",
    require "user.plugins.vim-markdown",
    require "user.plugins.mkdnflow",
    -- TODO: add to a single telescope file
    require "user.plugins.telescope-symbols",
    -- {
    --   "dkarter/bullets.vim",
    --   config = function()
    --     vim.g.bullets_enabled_file_types = { "markdown" }
    --   end,
    -- }, -- https://github.com/dkarter/bullets.vim
    -----[[------------]]-----
    ---      Mappings      ---
    -----]]------------[[-----
    require "user.plugins.mapper",
    require "user.plugins.mapx",
    -----[[------------]]-----
    ---         UI         ---
    -----]]------------[[-----
    require "user.plugins.dressing",
    require "user.plugins.wilder",
    require "user.plugins.neoscroll",
    require "user.plugins.scrollbar",
    -- require "user.plugins.lsp-lines",
    -- require "user.plugins.cosmic-ui",
    -- {
    --   "Mathijs-Bakker/zoom-vim",
    --   event = "BufRead",
    -- },
    -----[[------------]]-----
    ---       Editing      ---
    -----]]------------[[-----
    -- TODO: look into vim-yoink as a replacement for nvim-neoclip
    -- { "svermeulen/vim-yoink", config = function() end, },
    require "user.plugins.spectre",
    require "user.plugins.cutlass",
    require "user.plugins.neoclip",
    require "user.plugins.visual-multi",
    require "user.plugins.sandwich",
    -- { "chaoren/vim-wordmotion", event = "BufRead" },
    -- {
    -- Using vim-sandwich until surround.nvim highlights matches
    -- https://github.com/blackCauldron7/surround.nvim/issues/13
    --   "blackCauldron7/surround.nvim",
    --   config = function()
    --     require("surround").setup { mappings_style = "surround" }
    --   end,
    -- },
    -----[[------------]]-----
    ---     Navigation     ---
    -----]]------------[[-----
    require "user.plugins.bufjump",
    require "user.plugins.lightspeed",
    -- TODO: try using this for resize mappings and copy sync
    -- https://github.com/aserowy/tmux.nvim
    require "user.plugins.navigator",
    require "user.plugins.telescope-bookmarks",
    require "user.plugins.telescope-luasnip",

    -- require "user.plugins.telescope-hop",
    -----[[------------]]-----
    ---    Text Objects    ---
    -----]]------------[[-----
    -- require "user.plugins.matchup",
    -- TODO: i might swap these out for nvim-treehopper
    -- TODO: merge into a single treesitter file
    require "user.plugins.treehopper",
    -- require "user.plugins.treesitter-textsubjects",
    -- require "user.plugins.treesitter-textobjects",
    -----[[------------]]-----
    ---      Sessions      ---
    -----]]------------[[-----
    require "user.plugins.lastplace",
    -----[[------------]]-----
    ---       Colors       ---
    -----]]------------[[-----
    require "user.plugins.fennec-gruvbox",
    require "user.plugins.colorizer",
    -----[[------------]]-----
    ---      Snippets      ---
    -----]]------------[[-----
    -- TODO: can probably write these snippets into luasnip myself
    require "user.plugins.vscode-es7-javascript-react-snippets",
    -- {
    --   "mrjones2014/dash.nvim",
    --   run = "make install",
    --   -- event = "BufRead",
    --   cmd = "Dash",
    --   config = function()
    --     require("dash").setup()
    --   end,
    -- },
    -- {
    --   "RishabhRD/nvim-cheat.sh",
    --   requires = "RishabhRD/popfix",
    --   config = function()
    --     vim.g.cheat_default_window_layout = "vertical_split"
    --   end,
    --   cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    -- },
    -- { "anburocky3/bootstrap5-snippets" },
    -----[[------------]]-----
    ---     Completion     ---
    -----]]------------[[-----
    -- TODO: merge into a single treesitter file
    require "user.plugins.ts-autotag",
    -- TODO: merge into a single cmp file
    require "user.plugins.cmp-git",
    require "user.plugins.cmp-rg",
    require "user.plugins.cmp-latex-symbols",
    require "user.plugins.cmp-conventionalcommits",

    -- require "user.plugins.cmp-cmdline",
    -- require "user.plugins.cmp-cmdline-history",
    -- require "user.plugins.cmp-nvim-lsp-document-symbol",
    -----[[------------]]-----
    ---      QuickFix      ---
    -----]]------------[[-----
    require "user.plugins.bqf",
    -- https://gitlab.com/yorickpeterse/nvim-pqf
  }
end

return M

-----[[------------]]-----
---       Debug        ---
-----]]------------[[-----
-- { "jbyuki/one-small-step-for-vimkind" },
-- { "mfussenegger/nvim-dap-python" },
-- { "leoluz/nvim-dap-go" },
-- {
--   "rcarriga/nvim-dap-ui",
--   config = function()
--     require("dapui").setup()
--   end,
--   requires = { "mfussenegger/nvim-dap" },
--   ft = { "python", "go", "rust", "lua", "javascript" },
-- },
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
---        Java        ---
-----]]------------[[-----
-- { "mfussenegger/nvim-jdtls" },
-- { "mfussenegger/nvim-jdtls", ft = "java" },

-----[[------------]]-----
---       Syntax       ---
-----]]------------[[-----
-- {
--   -- TODO: nvim-biscuits stops working sometimes, figure that out
--   "code-biscuits/nvim-biscuits",
--   -- event = "BufRead",
--   config = function()
--     require("nvim-biscuits").setup {
--       cursor_line_only = true,
--       default_config = {
--         max_length = 50,
--         -- trim_by_words = true,
--         min_distance = 5,
--         prefix_string = " 🍪 ",
--       },
--       on_events = { "InsertLeave", "CursorHoldI" },
--     }
--   end,
-- },
-- { "ChristianChiarulli/vim-solidity" },
-- {
--   "nathom/filetype.nvim",
--   config = function()
--     require("filetype").setup {
--       overrides = {
--         extensions = {
--           pn = "potion",
--         },
--         literal = {
--           -- ["kitty.conf"] = "kitty",
--           [".gitignore"] = "conf",
--         },
--       },
--     }
--   end,
-- },
-----[[------------]]-----
---        Shell       ---
-----]]------------[[-----
-- { "waylonwalker/Telegraph.nvim" },
-----[[------------]]-----
---        HTTP        ---
-----]]------------[[-----
-- TODO: guess I'm using postman until I figure out how to get this to work (looks like a plenary bug on macos?)
-- {
--   "NTBBloodbath/rest.nvim",
--   requires = { "nvim-lua/plenary.nvim" },
--   config = function()
--     require("rest-nvim").setup {
--       -- Open request results in a horizontal split
--       result_split_horizontal = false,
--       -- Skip SSL verification, useful for unknown certificates
--       skip_ssl_verification = false,
--       -- Highlight request on run
--       highlight = {
--         enabled = true,
--         timeout = 150,
--       },
--       -- Jump to request line on run
--       jump_to_request = false,
--     }
--   end,
-- },
-----[[------------]]-----
---     Completion     ---
-----]]------------[[-----
-- { "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } },
-- { "ray-x/cmp-treesitter", requires = { "hrsh7th/nvim-cmp" } },
-- { "hrsh7th/cmp-nvim-lsp-signature-help", requires = { "ray-x/lsp_signature.nvim", "hrsh7th/nvim-cmp" } },
-- {
--   "tzachar/cmp-tabnine",
--   run = "./install.sh",
--   requires = "hrsh7th/nvim-cmp",
--   config = function()
--     local tabnine = require "cmp_tabnine.config"
--     tabnine:setup {
--       max_lines = 1000,
--       max_num_results = 10,
--       sort = true,
--     }
--   end,
-- },
-- {
--   "kkoomen/vim-doge",
--   event = "BufRead",
--   run = { ":call doge#install()" },
--   config = function()
--     vim.cmd "let g:doge_comment_jump_modes = ['n', 'i', 's']"
--     vim.cmd "let g:doge_enable_mappings = 0"
--   end,
-- },
