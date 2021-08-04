-- NOTE: General
-- =========================================
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"
lvim.colorscheme = "fennec-gruvbox"

-- NOTE: Builtin
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

lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = {
  { "lazygit", "gg", "LazyGit" },
  { "cobib", "ob", "Bibliography (Cobib)" },
  { "gomi --restore", "fr", "Restore deleted files (Gomi)" },
}
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.on_config_done = function()
  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    { key = { ";", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "l", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
  }
end

lvim.builtin.galaxyline.on_config_done = function(gl)
  require("user.fennec-eviline").config(gl)
end

lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }

-- lvim.builtin.telescope.defaults.mappings.i["<C-h>"] = require("telescope").extensions.hop.hop
local actions = require "telescope.actions"
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
lvim.builtin.telescope.defaults.path_display.shorten = 4
lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
lvim.builtin.telescope.defaults.layout_config.horizontal = {
  width_padding = 0.04,
  height_padding = 0.1,
  preview_width = 0.6,
}
lvim.builtin.telescope.defaults.layout_config.vertical = {
  width_padding = 0.05,
  height_padding = 1,
  preview_height = 0.5,
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.matchup.enable = true
-- lvim.builtin.treesitter.autotag.enable = true

-- NOTE: Debugging
-- =========================================
lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = require("user.dap").config()

-- NOTE: Language Specific
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

-- NOTE: Additional plugins
-- =========================================
require("user.plugins").config()

-- NOTE: Addtional autocommands
-- =========================================
require("user.autocommands").config()

-- NOTE: Additional mappngs
-- =========================================
require("user.keymappings").config()
