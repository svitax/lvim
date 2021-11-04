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
lvim.builtin.which_key.setup.window.winblend = lvim.winblend

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
require("user.builtins.lsp").config()
require "user.telescope.config"()
require("user.builtins.treesitter").config()

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.document_highlight = true
lvim.lsp.code_lens_refresh = true
lvim.lsp.automatic_servers_installation = false
lvim.lang.tailwindcss.active = false

-- LSP
-- =========================================
require("user.lsp.providers.null_ls").config()
-- require("user.lsp.providers.tsserver").config()
require("user.lsp.tailwindcss").config()
-- require("user.lsp.emmet_ls").config()

local custom_servers = { "sumneko_lua", "jsonls", "gopls", "tsserver" }
vim.list_extend(lvim.lsp.override, custom_servers)
for _, server_name in ipairs(custom_servers) do
  local status_ok, custom_config = pcall(require, "user.lsp.providers." .. server_name)
  if status_ok then
    require("lvim.lsp.manager").setup(server_name, custom_config)
  end
end

-- local opts = require "user/providers/tsserver"
-- require("lvim.lsp.manager").setup("tsserver", opts)

-- require("user.lsp.lsp_install").install()
-- require "user.lsp.lsp_install"()

-- require("user.lsp.providers.jsonls").config()

-- Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Mappngs
-- =========================================
require("user.keymappings").config()
