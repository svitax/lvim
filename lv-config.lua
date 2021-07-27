-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- NOTE: General
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "fennec-gruvbox"

-- NOTE: Custom keymappings
lvim.leader = "space"
-- overwrite the key-mappings provided by LunarVim for any mode, or leave it empty to keep them
-- lvim.keys.normal_mode = {
--   Page down/up
--   {'[d', '<PageUp>'},
--   {']d', '<PageDown>'},
--
--   Navigate buffers
--   {'<Tab>', ':bnext<CR>'},
--   {'<S-Tab>', ':bprevious<CR>'},
-- }
-- if you just want to augment the existing ones then use the utility function

require("utils").add_keymap_normal_mode({ silent = true, noremap = true }, {
	{ "<C-s>", ":w<cr>" },
	{ ";", "l" },
	{ "l", "h" },
})
require("utils").add_keymap_visual_mode({ silent = true, noremap = true }, {
	{ "<C-s>", ":w<cr>" },
	{ ";", "l" },
	{ "l", "h" },
})
-- you can also use the native vim way directly
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })

-- NOTE: Custom config for builtin plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.dap.active = true
require("dap-install").config("python_dbg", {})
-- lvim.builtin.galaxyline.active = false

-- NOTE: Treesitter settings
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- NOTE: Generic LSP settings
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
lvim.plugins = {
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach({
				hint_enable = false,
				handler_opts = {
					border = "single", -- double, single, shadow, none
				},
			})
		end,
		event = "InsertEnter",
	},
	{
		"vimwiki/vimwiki",
		branch = "dev",
		config = function()
			-- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki/markdown', 'syntax': 'markdown', 'ext': '.md'}]")
			vim.cmd(
				"let g:vimwiki_list = [{'path': '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax', 'syntax': 'markdown', 'ext': '.md'}]"
			)
			-- -- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki', 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}}]")
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_markdown_link_ext = 1
			-- -- vim.g.vimwiki_ext2syntax = {}
			vim.api.nvim_set_keymap("n", "<leader>wn", "<Plug>VimwikiNextLink", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>wb", "<Plug>VimwikiPrevLink", { silent = true })
		end,
		event = "BufRead",
	},
	{
		"turbio/bracey.vim",
		event = "BufRead",
	},
	{
		"eddyekofo94/gruvbox-flat.nvim",
		config = function()
			vim.g.gruvbox_flat_style = "dark"
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		cmd = "Telescope",
		config = function()
			require("telescope").load_extension("project")
		end,
		-- :Telescope project
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	{
		"ahmedkhalf/lsp-rooter.nvim",
		event = "BufRead",
	},
	{
		"numToStr/Navigator.nvim",
		event = "BufRead",
		config = function()
			require("Navigator").setup()
			vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>lua require('Navigator').left()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-h>", "<cmd>lua require('Navigator').right()<CR>", { silent = true })
		end,
	},
	{
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		cmd = "Neogit",
	},
	{
		"svitax/fennec-gruvbox.nvim",
		requires = { "rktjmp/lush.nvim" },
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- {
	-- 	"glepnir/galaxyline.nvim",
	-- 	config = function()
	-- 		require("core.galaxyline")
	-- 		if lvim.builtin.galaxyline.on_config_done then
	-- 			lvim.builtin.galaxyline.on_config_done(require("galaxyline"))
	-- 		end
	-- 	end,
	-- 	event = "BufWinEnter",
	-- },
}

-- NOTE: Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- NOTE: Overide bindings for WhichKey
-- lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope find_files<CR>", "Find File" }
lvim.builtin.which_key.mappings["b"]["b"] = { "<cmd>Telescope buffers<CR>", "Switch buffer" }
lvim.builtin.which_key.mappings["b"]["h"] = { "<cmd>new<CR>", "New horizontal buffer" }
lvim.builtin.which_key.mappings["b"]["l"] = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all buffers to the left" }
lvim.builtin.which_key.mappings["b"]["v"] = { ":vnew<cr>", "New vertical buffer" }
lvim.builtin.which_key.mappings["b"][";"] = { "<cmd>BufferCloseBuffersRight<cr>", "Close all buffers to the right" }

lvim.builtin.which_key.mappings["s"]["p"] = { "<cmd>Telescope project<cr>", "Search project" }
lvim.builtin.which_key.mappings["s"]["n"] = {
	"<cmd>lua require('telescope.builtin').find_files({cwd = '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'})<CR>",
	"Search Obsidian notes",
}
