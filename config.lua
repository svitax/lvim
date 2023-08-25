-- Neovim configuration
reload "user.neovim"

--  ╭──────────────────────────────────────────────────────────╮
--  │                  LunarVim configuration                  │
--  ╰──────────────────────────────────────────────────────────╯
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.leader = "space"
vim.opt.spell = false
vim.g.gruvbox_flat_style = "hard"

--  ╭──────────────────────────────────────────────────────────╮
--  │                    LunarVim Builtins                     │
--  ╰──────────────────────────────────────────────────────────╯
reload "user.builtin.alpha"
reload "user.builtin.autopairs"
reload "user.builtin.cmp"
reload "user.builtin.dap"
reload "user.builtin.bufferline"
reload "user.builtin.lualine"
reload "user.builtin.nvimtree"
reload "user.builtin.telescope"
reload "user.builtin.treesitter"
reload "user.builtin.toggleterm"
reload "user.builtin.luasnip"
reload "user.builtin.whichkey"
reload "user.icons"

--  ╭──────────────────────────────────────────────────────────╮
--  │                           LSP                            │
--  ╰──────────────────────────────────────────────────────────╯
reload "user.lsp"

--  ╭──────────────────────────────────────────────────────────╮
--  │                         Plugins                          │
--  ╰──────────────────────────────────────────────────────────╯
require("user.plugins").config()

--  ╭──────────────────────────────────────────────────────────╮
--  │                         Keymaps                          │
--  ╰──────────────────────────────────────────────────────────╯
require("user.keymaps").config()

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Autocommands                       │
--  ╰──────────────────────────────────────────────────────────╯
require("user.autocmd").config()

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Colorscheme                        │
--  ╰──────────────────────────────────────────────────────────╯
require("user.colorscheme").config()
