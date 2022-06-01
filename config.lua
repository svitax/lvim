-- Neovim configuration
require("user.neovim").config()

-- LunarVim configuration
-- =========================================
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "fennec-gruvbox"
lvim.leader = "space"
lvim.lsp.diagnostics.virtual_text = false

-- LunarVim Builtins
-- =========================================
require("user.plugins.alpha").config()
require("user.plugins.bufferline").config()
require("user.plugins.lualine").config()
require("user.plugins.nvimtree").config()
require("user.plugins.telescope").config()
require("user.plugins.treesitter").config()
require("user.plugins.toggleterm").config()
require("user.plugins.notify").config()

-- Keymaps
-- =========================================
require("user.keymaps").config()

-- LSP
-- =========================================
require("user.lsp").config()

-- Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocmd").config()
