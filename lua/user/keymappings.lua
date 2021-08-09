M = {}

M.config = function()
  -- you can also use the native vim way directly to remap keys

  -- Allow using alt in macOS without enabling “Use Option as Meta key”
  -- vim.api.nvim_set_keymap("n", "¬", "<A-l>", { noremap = false, silent = true, expr = true })
  -- vim.api.nvim_set_keymap("n", "˙", "<A-h>", { noremap = false, silent = true, expr = true })
  -- vim.api.nvim_set_keymap("n", "…", "<A-;>", { noremap = false, silent = true, expr = true })
  -- vim.api.nvim_set_keymap("n", "∆", "<A-j>", { noremap = false, silent = true, expr = true })
  -- vim.api.nvim_set_keymap("n", "˚", "<A-k>", { noremap = false, silent = true, expr = true })

  -- NOTE: Normal mode
  -- better movement keys
  lvim.keys.normal_mode[";"] = "l"
  lvim.keys.normal_mode["l"] = "h"
  -- make Y act like D and C but for yanking
  lvim.keys.normal_mode["Y"] = "y$"
  -- like the previous but ignores white space
  -- lvim.keys.normal_mode["Y"] = "yg_"
  -- keep cursor centered when using n(next) and N(previous)
  lvim.keys.normal_mode["n"] = "nzzzv"
  lvim.keys.normal_mode["N"] = "Nzzzv"
  -- keep cursor centered and in-place when joining lines with J
  lvim.keys.normal_mode["J"] = "mzJ`z"
  -- move current line up/down
  lvim.keys.normal_mode["∆"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["˚"] = ":m .-2<cr>=="
  lvim.keys.normal_mode["<C-M-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<C-M-k>"] = ":m .-2<cr>=="
  -- more ergonomic matchup mapping
  -- lvim.keys.normal_mode[","] = "%"
  vim.api.nvim_set_keymap("n", ",", "<plug>(matchup-%)", { silent = true })
  -- add new line when enter in normal mode
  lvim.keys.normal_mode["<Enter>"] = "o<Esc>"
  -- no highlight on esc
  lvim.keys.normal_mode["<Esc>"] = '<cmd>let @/=""<CR>'
  -- visual line mode on <A-v>
  lvim.keys.normal_mode["â"] = "V"
  -- V acts like D, C, and Y but for selecting lines
  lvim.keys.normal_mode["V"] = "v$"

  -- NOTE: Visual mode
  -- better movement keys
  lvim.keys.visual_mode[";"] = "l"
  lvim.keys.visual_mode["l"] = "h"
  -- Move visual selection up/down
  lvim.keys.visual_mode["∆"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["˚"] = ":m '<-2<cr>gv=gv"
  lvim.keys.visual_mode["<C-M-j>"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<C-M-k>"] = ":m '<-2<cr>gv=gv"
  -- better pasting in visual mode
  lvim.keys.visual_mode["p"] = [["_dP]]
  -- TODO more ergonomic matchup mapping
  -- lvim.keys.visual_mode[","] = "%"
  vim.api.nvim_set_keymap("x", ",", "<plug>(matchup-%)", { silent = true })

  -- NOTE: Insert mode
  -- Move current line up/down
  lvim.keys.insert_mode["<C-M-j>"] = "<Esc>:m .+1<CR>==gi"
  lvim.keys.insert_mode["<C-M-k>"] = "<Esc>:m .-2<CR>==gi"
  -- Undo break points (for a finer-grained undo command)
  -- should I add space to this list?
  lvim.keys.insert_mode[","] = ",<c-g>u"
  lvim.keys.insert_mode["."] = ".<c-g>u"
  lvim.keys.insert_mode["!"] = "!<c-g>u"
  lvim.keys.insert_mode["?"] = "?<c-g>u"
  lvim.keys.insert_mode["<cr>"] = "<cr><c-g>u"

  -- NOTE: Terminal mode
  -- this prevents lazygit from working properly
  -- lvim.keys.term_mode["<esc>"] = [[<C-\><C-n>]]

  -- NOTE: WhichKey

  -- Implemented
  -- =====================================
  -- ["b"] = (buffer switcher)
  -- ["c"] = (close window)
  -- ["C"] = (wipeout windows)
  -- ["d"] = +Debug
  -- ["f"] = (floating file manager)
  -- ["F"] = (buffer file manager)
  -- ["g"] = +Git
  -- ["h"] = (new vertical split)
  -- ["j"] = (new horizontal split)
  -- ["l"] = +LSP
  -- ["n"] = +Notes
  -- ["nf"] (open notes dir in file manager to create/delete notes until lir fix)
  -- ["p"] = +Packer
  -- ["q"] = quit
  -- ["r"] = +Replace
  -- ["s"] = +Search
  -- ["w"] = (save buffer)
  -- ["x"] = (close buffer)
  -- ["X"] = (wipeout buffers)
  -- ["y"] = (bracey) -- web server with live reloading

  -- ["/"] = comment
  -- [","] = (dashboard)

  -- Assigned, not implemented
  -- =====================================
  -- [";"] = (workspaces/sessions)
  -- ["e"] = (sniprun) basically a repl/code snippet runner/evaluater
  -- ["m"] = +move (windows and buffers)
  -- ["M"] = (make) -- autocommands based on filetype
  -- ["R"] = (run)  -- autocommands based on filetype
  -- ["T"] = (test) -- autocommands based on filetype
  -- ["z"] = (zen)

  -- ["lo"] symbol outline
  -- ["Tt"] (TSPlaygroundToggle)

  -- not assigned
  -- =====================================
  -- (restore deleted files)
  -- (nvimtree)
  -- (bibliography)

  -- ["a"] =
  -- ["i"] =
  -- ["k"] =
  -- ["o"] =
  -- ["u"] =
  -- ["v"] =
  -- ["<up>"] =
  -- ["<down>"] =
  -- ["<left>"] =
  -- ["<right>"] =
  -- ["."] =
  -- ["\"] =
  -- ["["] =
  -- ["]"] =
  -- ["="] =
  -- ["-"] =
  -- ["<space>"] =
  -- ["<cr>"] =
  -- ["<bs>"] =
  -- TODO need one-key parens on my keyboard
  -- ["("] =
  -- [")"] =

  lvim.builtin.which_key.mappings["b"] = { "<cmd>lua require('user.telescope').buffers()<cr>", "switch buffer" }
  lvim.builtin.which_key.mappings["c"] = { "<cmd>close<CR>", "close window" }
  lvim.builtin.which_key.mappings["C"] = { "<cmd>only<CR>", "win-wipeout" }

  lvim.builtin.which_key.mappings["e"] = "eval"

  lvim.builtin.which_key.mappings["f"] = { "<cmd>lua require'lir.float'.toggle()<cr>", "files" }
  -- TODO i want this command to make a new blank buffer in the current window and then open lir
  lvim.builtin.which_key.mappings["F"] = { "<cmd>edit .<cr>", "file buffer" }

  -- maybe the splits should be v and h?
  lvim.builtin.which_key.mappings["h"] = { "<cmd>split<CR>", "split" }
  lvim.builtin.which_key.mappings["v"] = { "<cmd>vsplit<CR>", "vsplit" }

  lvim.builtin.which_key.mappings["nf"] = {
    "<cmd>lua require('lir.float').toggle('~/.config/lvim/lua/notes/obsidian-notes')<CR>",
    "manage notes",
  }
  lvim.builtin.which_key.mappings["q"] = { "<cmd>qa<CR>", "quit" }
  lvim.builtin.which_key.mappings["w"] = { "<cmd>w!<CR>", "save" }
  lvim.builtin.which_key.mappings["x"] = { "<cmd>Bdelete<CR>", "close buffer" }
  lvim.builtin.which_key.mappings["X"] = { "<cmd>Bwipeout<CR>", "buf-wipeout" }

  -- show up only on html files (maybe css/js too)
  lvim.builtin.which_key.mappings["y"] = { "<cmd>Bracey<cr>", "live server" }

  -- shows up only on files that can be made/run/tested
  -- lvim.builtin.which_key.mappings["M"] = "make"
  -- lvim.builtin.which_key.mappings["R"] = "run"
  -- lvim.builtin.which_key.mappings["T"] = "test"

  lvim.builtin.which_key.mappings["m"] = "move"
  lvim.builtin.which_key.mappings["z"] = "zen"
  -- lvim.builtin.which_key.mappings["p"] = "workspaces"
  -- lvim.builtin.which_key.mappings["P"] = "Packer"

  lvim.builtin.which_key.mappings["/"] = { ":CommentToggle<CR>", "comment" }
  -- lvim.builtin.which_key.mappings["["] = { "<cmd>lua require'core.nvimtree'.toggle_tree()<CR>", "file tree" }

  -- +Debugging
  -- =========================================
  lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "toggle debug UI" }
  lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "eval" }

  -- +Files
  -- =========================================
  -- lvim.builtin.which_key.mappings["f"] = {
  --   name = "+Files",
  --   -- b = { "<cmd>edit .<cr>", "File manager in this buffer" },
  --   -- f = { "<cmd>lua require'lir.float'.toggle()<cr>", "Floating file manager" },
  --   -- t = { "<cmd>lua require'core.nvimtree'.toggle_tree()<CR>", "Tree explorer" },
  --   -- n = {
  --   --   "<cmd>lua require('lir.float').toggle('~/.config/lvim/lua/notes/obsidian-notes')<CR>",
  --   --   "Notes dir",
  --   -- },
  -- }

  -- TODO override builtin git mappings
  -- +Git
  -- =========================================
  lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "diff open" }
  lvim.builtin.which_key.mappings["g"]["D"] = { "<cmd>DiffviewClose<cr>", "diff close" }
  lvim.builtin.which_key.mappings["g"]["i"] = { "<cmd>Octo issue list<cr>", "GitHub issues" }
  lvim.builtin.which_key.mappings["g"]["l"] = { "<cmd>lua require'gitsigns'.blame_line(true)<cr>", "blame message" }
  lvim.builtin.which_key.mappings["g"]["P"] = { "<cmd>Octo pr list<cr>", "GitHub prs" }
  -- lvim.builtin.which_key.mappings["g"]["c"] = {
  --   "<cmd>lua require('user.telescope').delta_git_commits()<CR>",
  --   "Project's commits",
  -- }
  -- lvim.builtin.which_key.mappings["g"]["C"] = {
  --   "<cmd>lua require('user.telescope').delta_git_bcommits()<CR>",
  --   "Buffer's commits",
  -- }
  -- lvim.builtin.which_key.mappings["gS"] = {
  --   "<cmd>lua require('user.telescope').delta_git_status()<CR>",
  --   "Git status",
  -- }

  -- TODO override builtin LSP mappings
  -- +LSP
  -- =========================================
  lvim.builtin.which_key.mappings["ld"] = {
    "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
    "document diagnostics",
  }
  lvim.builtin.which_key.mappings["lD"] = {
    "<cmd>TroubleToggle lsp_definitions<cr>",
    "definitions",
  }
  lvim.builtin.which_key.mappings["lR"] = {
    "<cmd>TroubleToggle lsp_references<cr>",
    "references",
  }
  lvim.builtin.which_key.mappings["l"]["w"] = {
    "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
    "workspace diagnostics",
  }
  lvim.builtin.which_key.mappings["l"]["p"] = {
    name = "+Peek",
    d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "peek definition" },
    t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "peek type definition" },
    i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "peek implementation" },
  }

  -- +Quit
  -- =========================================
  -- lvim.builtin.which_key.mappings["q"] = { "<cmd>qa<CR>", "Quit" }
  -- lvim.builtin.which_key.mappings["q"] = {
  --   name = "+Quit",
  --   q = { "<cmd>SaveSession<cr> <cmd>qa<cr>", "Quit and save session" },
  --   Q = { "<cmd>qa<cr>", "Quit" },
  --   r = { "<cmd>RestoreSession<cr>", "Restore session" },
  --   w = { "<cmd>SaveSession<cr>", "Save session" },
  --   s = { "<cmd>lua require('persistence').load()<cr>", "Restore for current dir" },
  -- }

  -- +Replace
  -- =========================================
  lvim.builtin.which_key.mappings["r"] = {
    name = "+Replace",
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "replace buffer" },
    r = { "<cmd>lua require('spectre').open()<cr>", "replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "replace word" },
  }

  -- +Search
  -- =========================================
  lvim.builtin.which_key.mappings["s"] = {
    name = "+Search",
    -- Telescope commands
    -- b = {},
    c = {
      "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.config/lvim'})<CR>",
      "config",
    },
    -- C = {
    --   "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
    --   "colorscheme",
    -- },
    d = {
      "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.config'})<CR>",
      "dotfiles",
    },
    f = { ":Telescope find_files<cr>", "files in project" },
    h = { ":Telescope help_tags<cr>", "help tags" },
    k = { "keymaps" },
    l = {
      "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.local/share/lunarvim/lvim'})<CR>",
      "LunarVim",
    },
    m = { "man pages" },
    n = {
      "<cmd>lua require('telescope.builtin').find_files({cwd = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'})<CR>",
      "notes",
    },
    -- p = {},
    p = { "<cmd>lua require('user.telescope').projects()<cr>", "workspaces" },
    r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
    R = { "registers" },
    s = { "<cmd>SearchSession<cr>", "sessions" },
    -- fuzzy grep? change layout
    t = { "<cmd>Telescope current_buffer_fuzzy_find", "text" },
    T = { "<cmd>TodoTrouble<cr>", "todos" },
  }
end

return M
