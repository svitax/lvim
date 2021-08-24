M = {}

M.config = function()
  -- Allow using alt in macOS without enabling “Use Option as Meta key”

  -- vim.api.nvim_set_keymap("n", "∆", "<A-j>", { noremap = false, silent = true, expr = true })

  -- "∆", "<A-j>"
  -- "˚", "<A-k>"
  -- "¬", "<A-l>"
  -- "…", "<A-;>"
  -- "˙", "<A-h>"

  -- "¡", "<A-1>"
  -- "â¢", "<A-2>"
  -- "£", "<A-3>"
  -- "¢", "<A-4>"
  --
  -- "å", "<A-a>"
  -- "ß", "<A-s>"
  -- "∂", "<A-d>"
  -- "ƒ", "<A-f>"
  -- "©", "<A-g>"

  -- NOTE: Normal mode
  -- better movement keys
  lvim.keys.normal_mode[";"] = "l"
  lvim.keys.normal_mode["l"] = "h"
  -- make Y act like D and C but for yanking (this is going to get merged into neovim core)
  lvim.keys.normal_mode["Y"] = "y$"
  -- like the previous but ignores white space
  -- lvim.keys.normal_mode["Y"] = "yg_"
  -- more ergonmic mapping for end of line and beginning of line
  lvim.keys.normal_mode["<A-l>"] = "0"
  lvim.keys.normal_mode["<A-;>"] = "$"
  -- lvim.keys.normal_mode["¬"] = "0"
  -- lvim.keys.normal_mode["…"] = "$"
  -- keep cursor centered when using n(next) and N(previous)
  lvim.keys.normal_mode["n"] = "nzzzv"
  lvim.keys.normal_mode["N"] = "Nzzzv"
  -- keep cursor centered and in-place when joining lines with J
  lvim.keys.normal_mode["J"] = "mzJ`z"
  -- move current line up/down
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<A-k>"] = ":m .-2<cr>=="
  -- lvim.keys.normal_mode["∆"] = ":m .+1<cr>=="
  -- lvim.keys.normal_mode["˚"] = ":m .-2<cr>=="
  lvim.keys.normal_mode["<C-M-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<C-M-k>"] = ":m .-2<cr>=="
  -- more ergonomic matchup mapping with tab
  vim.cmd "nnoremap <silent> <Tab> :normal %<CR>"
  lvim.keys.visual_mode["<Tab>"] = "%"
  -- no highlight on esc
  lvim.keys.normal_mode["<Esc>"] = "<cmd>nohlsearch<CR>"
  -- -- add new line when enter in normal mode (conflicts with wiki.vim)
  -- lvim.keys.normal_mode["<Enter>"] = "o<Esc>"
  -- degenerate emacs inside nvim just to use magit
  lvim.keys.normal_mode["<C-a>"] = "<cmd>lua require('user.toggleterm')._toggle_magit()<cr>"
  -- lvim.builtin.which_key.mappings["<space>"] = { ":term emacsclient -nw -e '(magit-status)' <cr>", "magit" }
  -- Use h to quickly enter command mode (since I use ; to move right and l to move left, my h key is useless)
  lvim.keys.normal_mode["h"] = ":"
  -- quickly switch to harpoon marked files with <A-a>, <A-s>, <A-d>, <A-f>
  lvim.keys.normal_mode["<A-a>"] = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>" -- <A-a>
  lvim.keys.normal_mode["<A-s>"] = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>" -- <A-s>
  lvim.keys.normal_mode["<A-d>"] = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>" -- <A-d>
  lvim.keys.normal_mode["<A-f>"] = "<cmd>lua require('harpoon.ui').nav_file(4)<CR>" -- <A-f>

  -- NOTE: Visual mode
  -- better movement keys
  lvim.keys.visual_mode[";"] = "l"
  lvim.keys.visual_mode["l"] = "h"
  -- Move visual selection up/down
  lvim.keys.visual_mode["<A-j"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<A-k"] = ":m '<-2<cr>gv=gv"
  -- lvim.keys.visual_mode["∆"] = ":m '>+1<cr>gv=gv"
  -- lvim.keys.visual_mode["˚"] = ":m '<-2<cr>gv=gv"
  lvim.keys.visual_mode["<C-M-j>"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<C-M-k>"] = ":m '<-2<cr>gv=gv"
  -- better pasting in visual mode
  lvim.keys.visual_mode["p"] = [["_dP]]
  -- more ergonomic matchup mapping
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
  -- Fix previous spelling mistake
  lvim.keys.insert_mode["<C-h>"] = "<c-g>u<Esc>[s1z=`]a<c-g>u"
  -- A-del is mapped to delete previous word on my keyboard (macos), make that consistent inside nvim
  lvim.keys.insert_mode["<A-bs>"] = "<c-w>"

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

  -- ["Tt"] (TSPlaygroundToggle)

  -- not assigned
  -- =====================================
  -- (bibliography)

  -- ["c"] =
  -- ["C"] =
  -- ["j"] =
  -- ["k"] =
  -- ["o"] =
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

  lvim.builtin.which_key.triggers_blacklist = {
    i = { "y", "d", "c" },
    v = { "y", "d", "c" },
  }

  lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "mark file" }

  lvim.builtin.which_key.mappings["c"] = nil

  lvim.builtin.which_key.mappings["e"] = { "<cmd>SnipRun<cr>", "eval" }
  lvim.builtin.which_key.vmappings["e"] = { "<cmd>SnipRun<cr>", "eval bloc" }
  -- The operator mapping allows you to combine movements with sniprun:
  -- "<plug>SnipRunOperator + j" will run sniprun on the current line + the line below.

  lvim.builtin.which_key.mappings["f"] = { "<cmd>lua require'lir.float'.toggle()<cr>", "files" }
  -- TODO i want this command to make a new blank buffer in the current window and then open lir
  lvim.builtin.which_key.mappings["F"] = { "<cmd>edit .<cr>", "file buffer" }

  lvim.builtin.which_key.mappings["h"] = {
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
    "switch file",
  }
  -- toggle spell check
  -- lvim.builtin.which_key.mappings["h"] = { "<cmd>set spell!<cr> <cmd>set spellcapcheck!=<cr> l", "spellcheck" }
  lvim.builtin.which_key.mappings["i"] = { "<cmd>set spell!<cr>", "spellcheck" }

  lvim.builtin.which_key.mappings["nf"] = {
    "<cmd>lua require('lir.float').toggle('~/.config/lvim/lua/notes/obsidian-notes')<CR>",
    "manage notes",
  }

  lvim.builtin.which_key.mappings["q"] = { "<cmd>qa<cr>", "quit" }
  -- lvim.builtin.which_key.mappings["q"] = { "<cmd>SaveSession<cr> <cmd>w<cr> <cmd>qa<cr>", "save and quit" }

  lvim.builtin.which_key.mappings["u"] = {
    "<cmd>lua require('user.toggleterm').restore_files()<cr>",
    "restore files",
  }

  lvim.builtin.which_key.mappings["W"] = { "<cmd>w<cr>", "save" }
  lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"

  -- show up only on html files (maybe css/js too)
  lvim.builtin.which_key.mappings["y"] = { "<cmd>Bracey<cr>", "live server" }

  -- shows up only on files that can be made/run/tested
  -- lvim.builtin.which_key.mappings["M"] = "make"
  -- lvim.builtin.which_key.mappings["R"] = "run"
  -- lvim.builtin.which_key.mappings["T"] = "test"

  lvim.builtin.which_key.mappings["m"] = "move"
  lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "zen" }
  -- lvim.builtin.which_key.mappings["p"] = "workspaces"
  -- lvim.builtin.which_key.mappings["P"] = "Packer"

  lvim.builtin.which_key.mappings["/"] = { ":CommentToggle<CR>", "comment" }
  lvim.builtin.which_key.mappings["t"] = { "<cmd>NvimTreeToggle<CR>", "file tree" }

  -- +Buffers
  -- =========================================
  lvim.builtin.which_key.mappings["b"] = {
    name = "+Buffers",
    a = {
      "<cmd>BDelete all<cr>",
      "delete all buffers",
    },
    b = {
      "<cmd>lua require'user.telescope.pickers.buffers'()<cr>",
      "switch buffer",
    },
    d = {
      "<cmd>BDelete this<CR>",
      "close this buffer",
    },
    D = {
      "<cmd>BDelete! other<CR>",
      "close other buffers",
    },
    h = {
      "<cmd>BDelete! hidden<cr>",
      "close hidden buffers",
    },
  }

  -- +Debugging
  -- =========================================
  lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "toggle debug UI" }
  lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "eval" }

  -- TODO override builtin git mappings
  -- +Git
  -- =========================================
  lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "diff open" }
  -- lvim.builtin.which_key.mappings["gd"] = { "<cmd>DiffviewOpen HEAD~1<cr>", "diff open" }
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
  lvim.builtin.which_key.mappings["l"][";"] = { "<cmd>ISwap<cr>", "swap arguments" }

  -- +Notes
  -- =========================================
  lvim.builtin.which_key.mappings["n"] = {
    name = "+Notes",
    t = { "<cmd>Neorg tangle<cr>", "tangle blocks" },
    r = {
      [[<cmd>!rm temp.py<cr> <cmd>Neorg tangle<cr> <cmd>TermExec direction='horizontal' size=7 cmd='clear && python3 "temp.py" && rm "temp.py"'<cr>]],
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
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "replace file" },
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
    g = { "<cmd>Telescope live_grep<cr>", "text in project" },
    G = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "text in buffer" },
    T = { "<cmd>TodoTrouble<cr>", "todos" },
  }

  -- +Windows
  -- =========================================
  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    d = { "<cmd>close<CR>", "delete window" },
    D = { "<cmd>only<CR>", "delete all windows" },
    s = { "<cmd>split<CR>", "split" },
    v = { "<cmd>vsplit<CR>", "vsplit" },
    m = { "<Plug>Zoom", "toggle zoom window" },
  }
end

return M
