-- LunarVim configuration
-- =========================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "fennec-gruvbox"
lvim.leader = "space"

-- Neovim configuration
-- =========================================
require("user.neovim").config()

-- User config (not builtin)
-- =========================================
-- winblend screws up the colors in toggleterm for me
lvim.winblend = 10

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Builtins
-- =========================================
lvim.builtin.bufferline.active = false
lvim.builtin.dap.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true

require("user.builtins.autopairs").config()
require("user.builtins.comment").config()
require("user.builtins.dap").config()
require("user.builtins.dashboard").config()
require("user.builtins.cmp").config()
require("user.builtins.devicons").config()
require("user.builtins.nvimtree").config()
require("user.builtins.lualine").config()
require("user.builtins.toggleterm").config()
require "user.telescope.config"()
require("user.builtins.treesitter").config()

-- Mappngs
-- =========================================
require("user.keymappings").config()

-- LSP
-- =========================================
require "user.lsp.config"()

require("user.lsp.external_helpers").formatters()
require("user.lsp.external_helpers").linters()

-- require("user.lsp.providers.null_ls").config()
require("user.lsp.providers.emmet_ls").config()

-- Plugins
-- =========================================
require("user.plugins").config()
