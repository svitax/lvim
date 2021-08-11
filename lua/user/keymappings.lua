M = {}

M.config = function()
  -- you can also use the native vim way directly to remap keys

  lvim.keys.insert_mode["<C-h>"] = "<c-g>u<Esc>[s1z=`]a<c-g>u"

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
  -- add new line when enter in normal mode (conflicts with wiki.vim)
  -- lvim.keys.normal_mode["<Enter>"] = "o<Esc>"
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

  -- Assigned, not implemented
  -- =====================================
  -- ["p"] = +Workspaces
  -- ["P"] = +Packer
  -- ["m"] = +move (windows and buffers)
  -- ["M"] = (make) -- autocommands based on filetype
  -- ["R"] = (run)  -- autocommands based on filetype
  -- ["T"] = (test) -- autocommands based on filetype
  -- ["z"] = (zen)

  -- ["Tt"] (TSPlaygroundToggle)

  -- not assigned
  -- =====================================
  -- (restore deleted files)
  -- (nvimtree)
  -- (bibliography)

  -- ["a"] =
  -- ["c"] =
  -- ["C"] =
  -- ["h"] =
  -- ["i"] =
  -- ["j"] =
  -- ["k"] =
  -- ["o"] =
  -- ["u"] =
  -- ["v"] =
  -- ["x"] =
  -- ["X"] =
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

  -- format with prettier
  -- vim.api.nvim_set_keymap("n", "<F7>", ":!prettier --stdin-filepath % | e!<cr>", { noremap = true, silent = true })

  -- Hitting escape also clears spelling and search highlights
  -- vim.api.nvim_set_keymap("n", "<ESC>", ":nohls | :setlocal nospell<ESC>", { noremap = true, silent = true })

  lvim.builtin.which_key.mappings["c"] = nil
  lvim.builtin.which_key.mappings["h"] = nil

  lvim.builtin.which_key.mappings["e"] = { "<Plug>SnipRun", "eval" }
  lvim.builtin.which_key.vmappings["e"] = { "<Plug>SnipRun", "eval bloc" }
  -- The operator mapping allows you to combine movements with sniprun:
  -- "<plug>SnipRunOperator + j" will run sniprun on the current line + the line below.

  lvim.builtin.which_key.mappings["f"] = { "<cmd>lua require'lir.float'.toggle()<cr>", "files" }
  -- TODO i want this command to make a new blank buffer in the current window and then open lir
  lvim.builtin.which_key.mappings["F"] = { "<cmd>edit .<cr>", "file buffer" }

  lvim.builtin.which_key.mappings["nf"] = {
    "<cmd>lua require('lir.float').toggle('~/.config/lvim/lua/notes/obsidian-notes')<CR>",
    "manage notes",
  }

  lvim.builtin.which_key.mappings["q"] = { "<cmd>w<cr> <cmd>qa<cr>", "save and quit" }
  -- lvim.builtin.which_key.mappings["q"] = { "<cmd>SaveSession<cr> <cmd>w<cr> <cmd>qa<cr>", "save and quit" }
  lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa!<cr>", "quit" }
  lvim.builtin.which_key.mappings["W"] = { "<cmd>w<cr>", "save" }

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

  -- +Buffers
  -- =========================================
  lvim.builtin.which_key.mappings["b"] = {
    name = "+Buffers",
    a = {
      "<cmd>BufWipeout all",
      "delete all buffers",
    },
    b = {
      "<cmd>lua require'user.telescope.pickers.buffers'()<cr>",
      "switch buffer",
    },
    d = {
      "<cmd>BWipeout! this<CR>",
      "close this buffer",
    },
    D = {
      "<cmd>BWipeout! other<CR>",
      "close other buffers",
    },
    h = {
      "<cmd>BWipeout hidden",
      "close hidden buffers",
    },
  }

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
  --   "<cmd>lua require('user.telescope.pickers').delta_git_commits()<CR>",
  --   "Project's commits",
  -- }
  -- lvim.builtin.which_key.mappings["g"]["C"] = {
  --   "<cmd>lua require('user.telescope.pickers').delta_git_bcommits()<CR>",
  --   "Buffer's commits",
  -- }
  -- lvim.builtin.which_key.mappings["gS"] = {
  --   "<cmd>lua require('user.telescope.pickers').delta_git_status()<CR>",
  --   "Git status",
  -- }

  -- TODO override builtin LSP mappings
  -- +LSP
  -- =========================================
  -- ["lo"] symbol outline
  lvim.builtin.which_key.mappings["l"]["d"] = {
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

  -- +Notes
  -- =========================================
  lvim.builtin.which_key.mappings["n"] = {
    name = "+Notes",
    t = { "<cmd>Neorg tangle<cr>", "tangle blocks" },
    r = {
      [[<cmd>!rm "temp.py"<cr> <cmd>Neorg tangle<cr> <cmd>TermExec direction='horizontal' size=7 cmd='clear && python3 "temp.py" && rm "temp.py"'<cr>]],
      "run tangle",
    },
    R = {
      [[<cmd>lua require('user.toggleterm').algo_runner()<cr>]],
      "algo runner",
    },
    -- <cmd>lua require('toggleterm.terminal').Terminal:new({cmd='lazygit', direction='horizontal', size=10}):toggle()
    w = { "<plug>(wiki-index)", "wiki index" },
    d = { "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle<cr>", "task cycle" },
    n = { "<cmd>Neorg keybind norg core.norg.dirman.new.note<cr>", "new note" },
  }

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
    d = {
      "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--hidden', '--files', '--follow','--glob=!.git'}, cwd = '~/.config'})<CR>",
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
    p = { "<cmd>lua require'user.telescope.pickers.projects'()<cr>", "workspaces" },
    r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
    R = { "registers" },
    s = { "<cmd>SearchSession<cr>", "sessions" },
    -- fuzzy grep? change layout
    t = { "<cmd>Telescope current_buffer_fuzzy_find", "text" },
    T = { "<cmd>TodoTrouble<cr>", "todos" },
  }

  -- +Windows
  -- =========================================
  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    d = { "<cmd>close<CR>", "close window" },
    D = { "<cmd>only<CR>", "win-wipeout" },
    s = { "<cmd>split<CR>", "split" },
    v = { "<cmd>vsplit<CR>", "vsplit" },
    z = "zoom window",
  }
end

return M
