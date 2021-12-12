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
lvim.winblend = 0
lvim.builtin.which_key.setup.window.winblend = lvim.winblend

-- Builtins
-- =========================================
lvim.builtin.bufferline.active = false
lvim.builtin.dap.active = false
lvim.builtin.dashboard.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true
-- lvim.builtin.notify.active = true

require("user.builtins.autopairs").config()
require("user.builtins.comment").config()
require("user.builtins.dap").config()
require("user.builtins.dashboard").config()
require("user.builtins.cmp").config()
require("user.builtins.devicons").config()
require("user.builtins.nvimtree").config()
-- require("user.builtins.lualine").config()
require("user.builtins.project").config()
require("user.builtins.statusline").config()
require("user.builtins.toggleterm").config()
require("user.builtins.lsp").config()
require "user.telescope.config"()
require("user.builtins.treesitter").config()

-- lvim.lang.tailwindcss.active = false

-- LSP
-- =========================================
lvim.lsp.automatic_servers_installation = false

-- require("user.lsp.tailwindcss").config()
-- require("user.lsp.emmet_ls").config()

require("user.lsp.providers.null_ls").config()

local custom_servers = { "jsonls", "gopls", "tsserver", "golangci_lint_ls", "sumneko_lua", "r_language_server" }
-- vim.list_extend(lvim.lsp.override, custom_servers)
for _, server_name in ipairs(custom_servers) do
  local status_ok, custom_config = pcall(require, "user.lsp.providers." .. server_name)
  if status_ok then
    require("lvim.lsp.manager").setup(server_name, custom_config)
    -- require("lspconfig")[server_name].setup(custom_config)
  end
end

-- Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Mappngs
-- =========================================
require("user.keymappings").config()
