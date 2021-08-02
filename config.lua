-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- TODO: refactor config into multiple files

-- NOTE: General
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "fennec-gruvbox"

-- NOTE: Custom keymappings
lvim.leader = "space"

-- NOTE: Custom config for builtin plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true

lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.execs = {
-- 	{ "lazygit", "gg", "LazyGit" },
-- }

lvim.builtin.nvimtree.side = "left"
-- if i ever want to use netrw
-- lvim.builtin.nvimtree.disable_netrw = 0
-- lvim.builtin.nvimtree.hijack_netrw = 0
-- lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = function()
	-- require("dap-install").config("python_dbg", {})
	local dap = require("dap")
	dap.adapters.python = {
		type = "executable",
		command = "python",
		args = { "-m", "debugpy.adapter" },
	}
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = "/usr/local/bin/python3",
			-- TODO: fix python debugging resolving to conda environment
			-- pythonPath = function()
			-- 	-- TODO: the problem is my VIRTUAL_ENV variable is never set
			-- 	local cwd = vim.fn.getenv("VIRTUAL_ENV")
			-- 	if vim.fn.executable(cwd .. "/bin/python") == 1 then
			-- 		return cwd .. "/bin/python"
			-- 	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			-- 		return cwd .. "/.venv/bin/python"
			-- 	else
			-- 		return "/usr/local/bin/python3"
			-- 	end
			-- end,
		},
	}
end

lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }
lvim.builtin.compe.source.orgmode = true

-- lvim.builtin.galaxyline.active = false

-- lvim.builtin.telescope.defaults.mappings.i["<C-h>"] = require("telescope").extensions.hop.hop
local actions = require("telescope.actions")
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

-- NOTE: Treesitter settings
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.matchup.enable = true

-- NOTE: Generic LSP settings
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

require("user.plugins").config()

require("user.autocommands").config()

require("user.keymappings").config()
