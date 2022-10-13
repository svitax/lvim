-- Neovim configuration
require("user.neovim").config()

-- LunarVim configuration
-- =========================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "fennec-gruvbox"
lvim.leader = "space"
lvim.work = false

-- LunarVim Builtins
-- =========================================
require("user.plugins.alpha").config()
require("user.plugins.autopairs").config()
require("user.plugins.cmp").config()
require("user.plugins.dap").config()
require("user.plugins.bufferline").config()
require("user.plugins.lualine").config()
require("user.plugins.nvimtree").config()
require("user.plugins.telescope").config()
require("user.plugins.treesitter").config()
require("user.plugins.toggleterm").config()
require("user.plugins.notify").config()
require("user.plugins.luasnip").config()
require("user.plugins.whichkey").config()

-- LSP
-- =========================================
require("user.lsp").config()

-- Plugins
-- =========================================
require("user.plugins").config()

-- Keymaps
-- =========================================
require("user.keymaps").config()

-- Autocommands
-- =========================================
require("user.autocmd").config()
