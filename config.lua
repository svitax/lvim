-- C-p for previous jump list?
-- General
-- =========================================
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"
lvim.colorscheme = "fennec-gruvbox"

-- User config (not builtin)
-- =========================================
-- winblend screws up the colors in toggleterm for me
lvim.winblend = 0

-- Default options
-- =========================================
vim.opt.timeoutlen = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
vim.opt.showtabline = 0
vim.opt.relativenumber = true
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
-- vim.opt.pumblend = 10 -- Popup blend auto_open

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
lvim.builtin.galaxyline.active = false
require "user.fennec-lualine"
-- -- load fennec-eviline after the builtin galaxyline so we override it
-- lvim.builtin.galaxyline.on_config_done = function(gl)
--   require("user.fennec-eviline").config(gl)
-- end

-- Bufferline (builtin)
-- =========================================
lvim.builtin.bufferline.active = false

-- Compe (builtin)
-- =========================================
lvim.builtin.compe.documentation.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
-- lvim.builtin.compe.source.tabnine = { kind = " ", priority = 150, max_reslts = 6 }
-- lvim.builtin.compe.preselect = "always"

-- Projects (builtin)
-- =========================================
-- TODO I need change all the config that used telescope-projects
-- lvim.builtin.project.active = true

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
require("user.treesitter").config()

-- Dap (builtin)
-- =========================================
lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = require("user.dap").config()

-- Language Specific
-- =========================================
lvim.lsp.diagnostics.virtual_text = false
lvim.lang.markdown = {}
lvim.builtin.lspinstall.on_config_done = function()
  require("user.lsp.tailwind").setup()
  -- need to <C-space> to activate emmet snippets sometimes
  -- add setup function to emmet file
  require("user.lsp.emmet").setup()
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
