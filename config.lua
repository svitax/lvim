-- General
-- =========================================
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"
lvim.colorscheme = "fennec-gruvbox"
-- winblend screws up the colors in toggleterm for me
lvim.winblend = 0

-- Default options
-- =========================================
vim.opt.timeoutlen = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
vim.opt.showtabline = 0
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h14"

-- Dashboard (builtin)
-- =========================================
lvim.builtin.dashboard.active = true
require("user.dashboard").config()

-- Toggleterm (builtin)
-- =========================================
lvim.builtin.terminal.active = true
require("user.toggleterm").config()

-- Telescope (builtin)
-- =========================================
lvim.builtin.telescope.active = true
require "user.telescope.config"()
-- require("user.telescope").config()

-- Nvimtree (builtin)
-- =========================================
-- lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.auto_open = 0
require("user.nvimtree").config()

-- Galaxyline (builtin)
-- =========================================
lvim.builtin.galaxyline.active = true
-- load fennec-eviline after the builtin galaxyline so we override it
lvim.builtin.galaxyline.on_config_done = function(gl)
  require("user.fennec-eviline").config(gl)
end

-- Bufferline (builtin)
-- =========================================
lvim.builtin.bufferline.active = false

-- Compe (builtin)
-- =========================================
lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }

-- Comment (builtin)
-- =========================================
lvim.builtin.comment.on_config_done = function()
  require("nvim_comment").setup {
    hook = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  }
end

-- Treesitter (builtin)
-- =========================================
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true
-- neorg treesitter syntax, maybe one day it will be builtin and we won't need this
lvim.builtin.treesitter.on_config_done = function()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.norg = {
    install_info = {
      url = "https://github.com/vhyrro/tree-sitter-norg",
      files = { "src/parser.c" },
      branch = "main",
    },
  }
end

-- Dap (builtin)
-- =========================================
lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = require("user.dap").config()

-- Rooter (builtin)
-- =========================================
lvim.builtin.rooter.active = true

-- Language Specific
-- =========================================
lvim.lsp.diagnostics.virtual_text = false
lvim.lang.markdown = {}
lvim.builtin.lspinstall.on_config_done = function()
  require("user.tailwind").setup()
end
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
require("user.json_schemas").setup()

-- Additional plugins
-- =========================================
require("user.plugins").config()

-- Addtional autocommands
-- =========================================
require("user.autocommands").config()

-- Additional mappngs
-- =========================================
require("user.keymappings").config()
