-- General
-- =========================================
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"
lvim.colorscheme = "fennec-gruvbox"

-- Dashboard (builtin)
-- =========================================
lvim.builtin.dashboard.active = true
-- TODO: lunarvim's footer isn't exposed for user config, but here's how I want the footer to look
-- this needs to be in init.lua
-- vim.g.start_time = vim.fn.reltime()
-- local packages = #(vim.fn.globpath("~/.local/share/lunarvim/site/pack/packer/start", "*", 0, 1))
-- local loadtime = vim.fn.printf("%.3f", vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)))
-- vim.g.dashboard_custom_footer = {
--   "LunarVim loaded in " .. loadtime .. " seconds with " .. packages .. " plugins   ",
--   -- 
--   -- "LunarVim loaded " .. packages .. " plugins   in " .. loadtime .. "  seconds ",
-- }

-- Toggleterm (builtin)
-- =========================================
lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.float_opts.width = vim.fn.float2nr(vim.o.columns * 0.99)
-- lvim.builtin.terminal.float_opts.height = vim.fn.float2nr(vim.o.lines * 0.87)
lvim.builtin.terminal.open_mapping = [[…]] -- alt+; in macos
-- lvim.builtin.terminal.on_config_done = function ()
--   -- TODO: find out how to quit a terminal window with q
-- end
lvim.builtin.terminal.execs = {
  { "lazygit", "gg", "LazyGit" },
  { "cobib", "ob", "Bibliography (Cobib)" },
  { "gomi --restore", "fr", "Restore deleted files (Gomi)" },
}

-- Telescope (builtin)
-- =========================================
lvim.builtin.telescope.on_config_done = require("user.telescope").config()

-- Nvimtree (builtin)
-- =========================================
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.on_config_done = function()
  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    { key = { ";", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "l", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
  }
end

-- Galaxyline (builtin)
-- =========================================
lvim.builtin.galaxyline.on_config_done = function(gl)
  require("user.fennec-eviline").config(gl)
end

-- Compe (builtin)
-- =========================================
lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }

-- Treesitter (builtin)
-- =========================================
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.matchup.enable = true
-- lvim.builtin.treesitter.autotag.enable = true

-- Dap (builtin)
-- =========================================
lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = require("user.dap").config()

-- Language Specific
-- =========================================
lvim.lang.markdown = {}
lvim.lang.vimwiki = {}
lvim.lsp.diagnostics.virtual_text = false
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- Additional plugins
-- =========================================
require("user.plugins").config()

-- Addtional autocommands
-- =========================================
require("user.autocommands").config()

-- Additional mappngs
-- =========================================
require("user.keymappings").config()
