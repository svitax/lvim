local M = {}
M.config = function()
  -- TODO: S in visual mode should be lightspeed_S, so what should I use for visual sandwich surround?

  -- Allow using alt in macOS without enabling “Use Option as Meta key”

  -- vim.api.nvim_set_keymap("n", "∆", "<A-j>", { noremap = false, silent = true, expr = true })

  -- NOTE: Normal mode
  -- better movement keys
  lvim.keys.normal_mode[";"] = "l"
  lvim.keys.normal_mode["l"] = "h"
  -- Use h to quickly enter command mode (since I use ; to move right and l to move left, my h key is useless)
  lvim.keys.normal_mode["h"] = ":"
  -- keep cursor centered when using n(next) and N(previous)
  lvim.keys.normal_mode["n"] = "nzzzv"
  lvim.keys.normal_mode["N"] = "Nzzzv"
  -- keep cursor centered and in-place when joining lines with J
  lvim.keys.normal_mode["J"] = "mzJ`z"
  -- reverse join
  -- lvim.keys.normal_mode["H"] = "revJ"
  -- easy align
  -- lvim.keys.normal_mode["L"] = "vimeasyalign"
  lvim.keys.insert_mode["jk"] = nil
  lvim.keys.insert_mode["kj"] = nil
  lvim.keys.insert_mode["jj"] = nil
  -- lvim.keys.normal_mode["<C-t>"] = nil
  -- vim-visual-multi keeps hijacking my <cr>
  -- lvim.keys.normal_mode["<CR>"] = nil
  -- vim.api.nvim_set_keymap("n", "<cr>", "", { noremap = false })
  -- vim.api.nvim_set_

  vim.api.nvim_set_keymap("i", "<S-Left>", "<C-\\><C-O><Plug>WordMotion_b", { noremap = false })
  vim.api.nvim_set_keymap("i", "<S-Right>", "<C-\\><C-O><Plug>WordMotion_w", { noremap = false })
  -- NOTE: not sure if i want this mapping (visually laggy)
  -- vim.api.nvim_set_keymap("i", "<C-w>", "<space><C-\\><C-O>d<Plug>WordMotion_b<C-O>x", { noremap = false })
  vim.api.nvim_set_keymap("i", "<C-w>", "<c-\\><c-O>b<c-\\><c-O>d<S-Right>", { noremap = false })

  -- TODO: clean control keybindings so I can use them with tmux
  vim.api.nvim_set_keymap("n", "<C-b>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-e>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-f>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-g>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-h>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-m>", "", { noremap = true })
  -- vim.api.nvim_set_keymap("n", "<C-m>", "<Plug>(VM-Find-Under)", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-n>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-p>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-s>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-x>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-y>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-z>", "", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-/>", "", { noremap = true })

  -- navigate windows/splits
  lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('Navigator').left()<CR>"
  lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('Navigator').down()<CR>"
  lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('Navigator').up()<CR>"
  lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('Navigator').right()<CR>" -- I have <C-;> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing
  -- move current line up/down
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<A-k>"] = ":m .-2<cr>=="
  -- jump back and forth between buffers (mirror C-o/C-i for moving in the jumplist)
  lvim.keys.normal_mode["<A-o>"] = ":lua require('bufjump').backward()<cr>"
  lvim.keys.normal_mode["<A-i>"] = ":lua require('bufjump').forward()<cr>"
  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12)
  -- vim.api.nvim_set_keymap("n", "S591", "_", { noremap = true })
  vim.api.nvim_set_keymap("n", "Q949", "_", { noremap = true })
  -- vim.api.nvim_set_keymap("n", "S4", "_", { noremap = true })
  vim.api.nvim_set_keymap("n", "12", "$", { noremap = true })
  -- vim.api.nvim_set_keymap("n", "S591", "b", { noremap = true })

  -- make Y act like D and C but for yanking (this is going to get merged into neovim core)
  lvim.keys.normal_mode["Y"] = "y$"
  -- like the previous but ignores white space
  -- lvim.keys.normal_mode["Y"] = "yg_"

  -- save
  -- lvim.keys.normal_mode["<C-s>"] = ":update<cr>"
  -- quickly toggle terminals
  lvim.keys.normal_mode["<A-f>"] = "<cmd>lua require('user.builtins.toggleterm').toggle_term2()<cr>"
  lvim.keys.normal_mode["<A-d>"] = "<cmd>lua require('user.builtins.toggleterm').toggle_term3()<CR>"
  lvim.keys.normal_mode["<A-s>"] = "<cmd>lua require('user.builtins.toggleterm').toggle_term4()<cr>"
  lvim.keys.normal_mode["<A-a>"] = "<cmd>lua require('user.builtins.toggleterm').toggle_term5()<CR>"
  -- lvim.keys.normal_mode["<A-t>"] = "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>"
  -- lvim.keys.normal_mode["<A-t>"] = "<cmd>lua require('harpoon.term').sendCommand(1, 1)<CR>"
  -- lvim.keys.normal_mode["<A-y>"] = "<cmd>lua require('harpoon.term').sendCommand(1, 2)<CR>"
  -- quickly switch to harpoon marked files
  lvim.keys.normal_mode["<A-5>"] = "<cmd>lua require('harpoon.ui').nav_file(5)<CR>"
  lvim.keys.normal_mode["<A-4>"] = "<cmd>lua require('harpoon.ui').nav_file(4)<CR>"
  lvim.keys.normal_mode["<A-3>"] = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>"
  lvim.keys.normal_mode["<A-2>"] = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>"
  lvim.keys.normal_mode["<A-1>"] = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>"

  -- more ergonomic matchup mapping with alt-tab (since just tab conflicts with C-i for jumplist navigation)
  -- vim.cmd "noremap <silent> <Tab> :<C-u>normal %<CR>"
  vim.cmd "noremap <silent> <A-Tab> :<C-u>normal %<CR>"
  -- no highlight on esc
  lvim.keys.normal_mode["<Esc>"] = "<cmd>nohlsearch<CR>"
  -- degenerate emacs inside nvim just to use magit
  -- lvim.keys.normal_mode["<C-a>"] = "<cmd>lua require('user.toggleterm')._toggle_magit()<cr>"
  -- lvim.builtin.which_key.mappings["<space>"] = { ":term emacsclient -nw -e '(magit-status)' <cr>", "magit" }

  -- NOTE: Visual mode
  -- better movement keys
  lvim.keys.visual_mode[";"] = "l"
  lvim.keys.visual_mode["l"] = "h"
  -- Move visual selection up/down
  lvim.keys.visual_mode["<A-j>"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<A-k>"] = ":m '<-2<cr>gv=gv"
  -- better pasting in visual mode
  lvim.keys.visual_mode["p"] = [["_dP]]
  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12)
  -- vim.api.nvim_set_keymap("v", "S4", "_", { noremap = true })
  vim.api.nvim_set_keymap("v", "Q949", "_", { noremap = true })
  vim.api.nvim_set_keymap("v", "12", "$", { noremap = true })

  -- NOTE: Insert mode
  -- Move current line up/down
  -- lvim.keys.insert_mode["<A-h>"] = nil
  -- lvim.keys.insert_mode["<A-j>"] = nil
  -- lvim.keys.insert_mode["<A-k>"] = nil
  -- lvim.keys.insert_mode["<A-l>"] = nil
  -- lvim.keys.insert_mode["<A-;>"] = nil
  -- lvim.keys.insert_mode["<A-g>"] = nil
  -- lvim.keys.insert_mode["<A-f>"] = nil
  -- lvim.keys.insert_mode["<A-d>"] = nil
  -- lvim.keys.insert_mode["<A-s>"] = nil
  -- lvim.keys.insert_mode["<A-a>"] = nil
  -- ergonmic mappings for end of line and beginning of line my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12
  -- vim.api.nvim_set_keymap("i", "S4", "<Esc>_i", { noremap = true })
  vim.api.nvim_set_keymap("i", "Q949", "<Esc>_i", { noremap = true })
  -- make sure tmux doesn't bind anything to C-s
  vim.api.nvim_set_keymap("i", "12", "<Esc>$a", { silent = true, noremap = true })

  -- Undo break points (for a finer-grained undo command)
  -- should I add space to this list?
  lvim.keys.insert_mode[","] = ",<c-g>u"
  lvim.keys.insert_mode["."] = ".<c-g>u"
  lvim.keys.insert_mode["!"] = "!<c-g>u"
  lvim.keys.insert_mode["?"] = "?<c-g>u"
  lvim.keys.insert_mode["<cr>"] = "<cr><c-g>u"
  lvim.keys.insert_mode["<space>"] = "<space><c-g>u"
  -- Fix previous spelling mistake
  -- lvim.keys.insert_mode["<C-h>"] = "<c-g>u<Esc>[s1z=`]a<c-g>u"
  lvim.keys.insert_mode["<A-h>"] = "<c-g>u<Esc>[s1z=`]a<c-g>u"
  -- A-del is mapped to delete previous word on my keyboard (macos), make that consistent inside nvim
  -- vim.api.nvim_set_keymap("i", "<A-bs>", "<Esc>dbxi", {})
  lvim.keys.insert_mode["<A-bs>"] = "<c-w>"

  -- NOTE: Terminal mode
  -- this prevents lazygit from working properly
  -- lvim.keys.term_mode["<esc>"] = [[<C-\><C-n>]]

  -- NOTE: WhichKey

  -- Assigned, not implemented
  -- =====================================
  -- ["p"] = +Workspaces
  -- ["P"] = +Packer
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
  -- ["m"] =
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
  -- ["("] =
  -- [")"] =

  -- lvim.builtin.which_key.mappings["n"] = {
  --   name = "Neogen",
  --   c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
  --   f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
  -- }

  lvim.builtin.which_key.mappings["?"] = { "<cmd>Cheat<CR>", "cheat.sh" }

  lvim.builtin.which_key.mappings["a"] = { "<cmd>up<CR>", "write buffer" }

  -- lvim.builtin.which_key.mappings["c"] = nil
  lvim.builtin.which_key.mappings["c"] = { "<Plug>RestNvim", "rest" }
  -- show up only on html files (maybe css/js too)
  -- lvim.builtin.which_key.mappings["c"] = { "<cmd>Bracey<cr>", "live server" }

  lvim.builtin.which_key.mappings["e"] = nil

  -- lvim.builtin.which_key.mappings["e"] = { "<cmd>SnipRun<cr>", "eval" }
  -- lvim.builtin.which_key.vmappings["e"] = { "<cmd>SnipRun<cr>", "eval bloc" }
  -- The operator mapping allows you to combine movements with sniprun:
  -- "<plug>SnipRunOperator + j" will run sniprun on the current line + the line below.

  lvim.builtin.which_key.mappings["t"] = { "<cmd>NvimTreeToggle<CR>", "file tree" }
  lvim.builtin.which_key.mappings["f"] = { "<cmd>Lf<cr><cmd>FloatermUpdate --height=0.90 --width=0.90<cr>", "files" }
  -- lvim.builtin.which_key.mappings["f"] = { "<cmd>Lf<cr>", "files" }
  -- lvim.builtin.which_key.mappings["f"] = { "<cmd>edit .<cr>", "file buffer" }
  -- lvim.builtin.which_key.mappings["F"] = { "<cmd>lua require'user.lir.utils'.toggle_lir()<cr>", "file buffer" }
  -- lvim.builtin.which_key.mappings["F"] = { "<cmd>lua require'lir.float'.toggle()<cr>", "files" }

  -- toggle spell check
  -- lvim.builtin.which_key.mappings["h"] = { "<cmd>set spell!<cr> <cmd>set spellcapcheck!=<cr> l", "spellcheck" }
  lvim.builtin.which_key.mappings["i"] = { "<cmd>set spell!<cr>", "spellcheck" }

  lvim.builtin.which_key.mappings["q"] = { "<cmd>qa<cr>", "quit" }
  -- lvim.builtin.which_key.mappings["q"] = { "<cmd>SaveSession<cr> <cmd>w<cr> <cmd>qa<cr>", "save and quit" }

  -- TODO: make Lf use gomi to delete files
  lvim.builtin.which_key.mappings["u"] = {
    "<cmd>lua require('user.builtins.toggleterm').restore_files()<cr>",
    "restore files",
  }

  -- shows up only on files that can be made/run/tested
  -- lvim.builtin.which_key.mappings["M"] = "make"
  -- lvim.builtin.which_key.mappings["R"] = "run"
  -- lvim.builtin.which_key.mappings["T"] = "test"

  -- lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "zen" }
  -- lvim.builtin.which_key.mappings["p"] = "workspaces"
  -- lvim.builtin.which_key.mappings["P"] = "Packer"

  lvim.builtin.which_key.mappings["y"] = { "<cmd>Telescope neoclip<cr>", "yank history" }

  -- lvim.builtin.which_key.mappings["/"] = { ":CommentToggle<CR>", "comment" }
  lvim.builtin.which_key.mappings["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "comment" }

  -- +Buffers
  -- =========================================
  lvim.builtin.which_key.mappings["b"] = {
    name = "+Buffers",
    a = {
      "<cmd>BDelete all<cr>",
      "delete all buffers",
    },
    b = {
      "<cmd>lua require'user.telescope.custom_pickers'.switch_buffers()<cr>",
      "switch buffer",
    },
    d = {
      "<cmd>BDelete this<CR>",
      "close this buffer",
    },
    h = {
      "<cmd>BDelete! hidden<cr>",
      "close hidden buffers",
    },
    n = {
      "<cmd>bnext<cr>",
      "next buffer",
    },
    o = {
      "<cmd>BDelete! other<CR>",
      "close other buffers",
    },
    p = {
      "<cmd>bprevious<cr>",
      "previous buffer",
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
  lvim.builtin.which_key.mappings["g"]["g"] = {
    "<cmd>lua require('user.builtins.toggleterm').lazy_git()<CR>",
    "LazyGit",
  }
  -- lvim.builtin.which_key.mappings["g"]["c"] = {
  --   "<cmd>lua require('user.telescope.pickers.delta')._git_commits()<CR>",
  --   "project's commits",
  -- }
  -- lvim.builtin.which_key.mappings["g"]["C"] = {
  --   "<cmd>lua require('user.telescope.pickers.delta').git_bcommits()<CR>",
  --   "buffer's commits",
  -- }
  -- lvim.builtin.which_key.mappings["gS"] = {
  --   "<cmd>lua require('user.telescope.pickers.delta').git_status()<CR>",
  --   "git status",
  -- }

  -- +Harpoon
  -- =========================================
  lvim.builtin.which_key.mappings["h"] = {
    name = "+Harpoon",
    a = {
      "<cmd>lua require('harpoon.mark').add_file()<CR>",
      "mark buffer",
    },
    h = {
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
      "show marks",
    },
    ["1"] = {
      "<cmd>lua require('harpoon.ui').nav_file(1)<CR>",
      "switch to mark 1",
    },
    ["2"] = {
      "<cmd>lua require('harpoon.ui').nav_file(2)<CR>",
      "switch to mark 2",
    },
    ["3"] = {
      "<cmd>lua require('harpoon.ui').nav_file(3)<CR>",
      "switch to mark 3",
    },
    ["4"] = {
      "<cmd>lua require('harpoon.ui').nav_file(4)<CR>",
      "switch to mark 4",
    },
    ["5"] = {
      "<cmd>lua require('harpoon.ui').nav_file(5)<CR>",
      "switch to mark 5",
    },
  }

  -- +LSP
  -- =========================================
  -- TODO: override builtin LSP mappings
  -- ["b"] =
  -- ["c"] =
  -- ["g"] =
  -- ["h"] =
  -- ["m"] =
  -- ["n"] =
  -- ["u"] =
  -- ["v"] =
  -- ["x"] =
  -- ["y"] =

  lvim.builtin.which_key.mappings["la"] = {
    "<cmd>CodeActionMenu<cr>",
    "code actions",
  }
  lvim.builtin.which_key.mappings["lA"] = {
    -- "<cmd>lua require('user.telescope.pickers.codelens_actions')()<cr>",
    "<cmd>lua vim.lsp.codelens.run()<cr>",
    "codelens actions",
  }
  lvim.builtin.which_key.mappings["lb"] = {
    "<cmd>lua require'nvim-biscuits'.toggle_biscuits()<cr>",
    "toggle biscuits",
  }
  lvim.builtin.which_key.mappings["lc"] = {
    "<cmd>TSContextToggle<cr>",
    "toggle context",
  }
  lvim.builtin.which_key.mappings["l"]["d"] = {
    "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
    "document diagnostics",
  }
  lvim.builtin.which_key.mappings["le"] = {
    "<cmd>TroubleToggle lsp_references<cr>",
    "references",
  }
  lvim.builtin.which_key.mappings["l"]["f"] = {
    -- "<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>",
    "<cmd>lua vim.lsp.buf.formatting()<cr>",
    "format",
  }
  lvim.builtin.which_key.mappings["l"]["l"] = {
    "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<CR>",
    "line diagnostics",
  }

  lvim.builtin.which_key.mappings["lo"] = { "<cmd>SymbolsOutline<cr>", "symbol outline" }
  lvim.builtin.which_key.mappings["l"]["p"] = {
    name = "+Peek",
    d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "peek definition" },
    t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "peek type definition" },
    i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "peek implementation" },
  }
  lvim.builtin.which_key.mappings["l"]["r"] = { '<cmd>lua require("user.lsp.rename").rename()<cr>', "rename" }
  lvim.builtin.which_key.mappings["lt"] = {
    "<cmd>TroubleToggle lsp_definitions<cr>",
    "definitions",
  }
  lvim.builtin.which_key.mappings["l"]["w"] = {
    "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
    "workspace diagnostics",
  }
  -- lvim.builtin.which_key.mappings["lz"] = {
  --   "<cmd>ISwap<cr>",
  --   "swap parameters",
  -- }

  lvim.builtin.which_key.on_config_done = function(wk)
    local keys = {
      ["ga"] = { "<cmd>CodeActionMenu<CR>", "code actions" },
      ["gl"] = { "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<CR>", "show line diagnostics" },
      ["ge"] = { "<cmd>Trouble lsp_references<CR>", "references" },
      -- ["gI"] = { "<cmd>lua require('user.telescope').lsp_implementations()<CR>", "Goto Implementation" },
      ["<leader>la"] = { "<cmd>CodeActionMenu<cr>", "code actions" },
    }

    wk.register(keys, { mode = "n" })
  end

  -- +M (Localleader)
  -- TODO: do this without using a global variable later
  -- TODO: should these only work on a package.json file?
  vim.cmd [[
autocmd FileType json lua whichkeyJson()
]]
  _G.whichkeyJson = function()
    local wk = require "which-key"
    local buf = vim.api.nvim_get_current_buf()
    wk.register {
      ["<leader>m"] = {
        name = "+NPM",
        -- Hide package versions
        ["c"] = { ":lua require('package-info').hide()<CR>", "hide package versions", buffer = buf },
        -- Delete package on line
        ["d"] = { ":lua require('package-info').delete()<CR>", "delete package", buffer = buf },
        -- Install a new package
        ["i"] = { ":lua require('package-info').install()<CR>", "install new package", buffer = buf },
        -- Install a different package version
        ["p"] = { ":lua require('package-info').change_version()<CR>", "change package version", buffer = buf },
        -- Reinstall dependencies
        ["r"] = { ":lua require('package-info').reinstall()<CR>", "reinstall dependencies", buffer = buf },
        -- Show package versions
        ["s"] = { ":lua require('package-info').show()<CR>", "show package versions", buffer = buf },
        -- Update package on line
        ["u"] = { ":lua require('package-info').update()<CR>", "update package", buffer = buf },
        -- Install a different package version
        ["b"] = { ":Telescope npm scripts<CR>", "run scripts", buffer = buf },
      },
    }
  end

  -- +Notes
  -- =========================================
  lvim.builtin.which_key.mappings["n"] = {
    name = "+Notes",
    f = {
      "<cmd>cd ~/.config/lvim/lua/notes/obsidian-notes<cr><cmd>LfWorkingDirectory<CR>",
      "manage notes",
    },
    -- t = { "<cmd>Neorg tangle<cr>", "tangle blocks" },
    r = {
      [[<cmd>!rm temp.py<cr> <cmd>Neorg tangle<cr> <cmd>TermExec direction='horizontal' size=7 cmd='clear && python3 "temp.py" && rm "temp.py"'<cr>]],
      "run tangle",
    },
    R = {
      [[<cmd>lua require('user.builtins.toggleterm').algo_runner()<cr>]],
      "algo runner",
    },
    -- <cmd>lua require('toggleterm.terminal').Terminal:new({cmd='lazygit', direction='horizontal', size=10}):toggle()
    w = { "<plug>(wiki-index)", "wiki index" },
    -- d = { "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle<cr>", "task cycle" },
    -- n = { "<cmd>Neorg keybind norg core.norg.dirman.new.note<cr>", "new note" },
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
    b = {
      -- "<cmd>Telescope current_buffer_fuzzy_find<cr>", "grep in buffer",
      "<cmd>lua require'user.telescope.custom_pickers'.grep_current_buffer()<cr>",
      "grep in buffer",
    },
    c = {
      -- "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.config/lvim', prompt_title = 'files in LunarVim config'})<CR>",
      "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_config_files()<CR>",
      "config",
    },
    C = {
      -- "<cmd>lua require('telescope.builtin').live_grep({ cwd = '~/.config/lvim', only_sort_text = true, prompt_title = 'grep LunarVim config'})<CR>",
      "<cmd>lua require'user.telescope.custom_pickers'.grep_config_files()<cr>",
      "grep in config",
    },
    d = {
      -- "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--hidden', '--files', '--follow','--glob=!.git'}, cwd = '~/.config', prompt_title = 'search dotfiles'})<CR>",
      "<cmd>lua require('user.telescope.custom_pickers').find_dotfiles()<CR>",
      "dotfiles",
    },
    D = {
      -- "<cmd>lua require('telescope.builtin').live_grep({ cwd = '~/.config', prompt_title = 'grep dotfiles' })<CR>",
      "<cmd>lua require'user.telescope.custom_pickers'.grep_dotfiles()<cr>",
      "grep in dotfiles",
    },
    f = {
      "<cmd>lua require('user.telescope.custom_pickers').find_files()<CR>",
      "files in project",
    },
    h = { ":Telescope help_tags<cr>", "help tags" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    l = {
      -- "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.local/share/lunarvim/lvim', prompt_title = 'Core LunarVim files'})<CR>",
      "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
      "LunarVim files",
    },
    -- m = { "man pages" },
    n = {
      -- "<cmd>lua require('telescope.builtin').find_files({cwd = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'})<CR>",
      "<cmd>lua require('user.telescope.custom_pickers').find_notes()<cr>",
      "notes",
    },
    -- p = { "<cmd>lua require'user.telescope.pickers.projects'()<cr>", "workspaces" },
    p = { "<cmd>Telescope projects<cr>", "projects" },
    r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
    R = { "<cmd>Telescope frecency<cr>", "frecency" },
    -- R = { "registers" },
    s = { "<cmd>SearchSession<cr>", "sessions" },
    g = { "<cmd>lua require('user.telescope.custom_pickers').grep_files()<cr>", "grep in project" },
    T = { "<cmd>TodoTrouble<cr>", "todos" },
    z = { ":Telescope zoxide list<cr>", "zoxide" },
    Z = { "<cmd>lua require('user.telescope.custom_pickers').grep_last_search()<cr>", "grep last search" },
  }

  -- +Treesitter
  -- ==================================================================================
  lvim.builtin.which_key.mappings["Tc"] = { "<cmd>TSContextToggle<cr>", "context" }
  lvim.builtin.which_key.mappings["Tp"] = { "<cmd>TSPlagroundToggle<cr>", "playground" }

  -- +Windows
  -- ==================================================================================
  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    d = { "<cmd>close<CR>", "delete window" },
    o = { "<cmd>only<CR>", "delete other windows" },
    s = { "<cmd>split<CR>", "split" },
    v = { "<cmd>vsplit<CR>", "vsplit" },
    z = { "<Plug>Zoom", "toggle zoom window" },

    j = { "", "switch window down" },
    k = { "", "switch window up" },
    l = { "", "switch window left" },
    [";"] = { "", "switch window right" },
  }

  lvim.builtin.which_key.on_config_done = function(wk)
    local keys = {
      -- ["ga"] = { "<cmd>lua require('user.telescope').code_actions()<CR>", "Code Action" },
      -- ["gR"] = { "<cmd>Trouble lsp_references<CR>", "Goto References" },
      -- ["gI"] = { "<cmd>lua require('user.telescope').lsp_implementations()<CR>", "Goto Implementation" },
      -- add labels to vim-sandwich
      d = {
        s = { name = "sandwich delete query", s = "auto", i = "instant" }, -- just a labeel
      },
      y = {
        ["<C-g>"] = "which_key_ignore",
        S = { name = "end of line", i = "instant", f = "func", t = "tag" },
        s = {
          name = "sandwich add query",
          s = { name = "line", f = "func", t = "tag", i = "instant" },
          i = {
            name = "inner",
            p = "paragraph",
            s = "sentence",
            t = "tag",
            w = "word",
            [")"] = "parentheses",
            ["]"] = "brackets",
            ["}"] = "braces",
            ["'"] = "'",
            ['"'] = '"',
            [">"] = ">",
            ["`"] = "`",
          },
          a = {
            name = "outer",
            p = "paragraph",
            s = "sentence",
            t = "tag",
            w = "word",
            [")"] = "parentheses",
            ["]"] = "brackets",
            ["}"] = "braces",
            ["'"] = "'",
            ['"'] = '"',
            [">"] = ">",
            ["`"] = "`",
          },
          w = "next word",
          e = "end of word",
          f = "find",
          t = "until",
          ["/"] = "search",
        },
      },
      c = {
        s = {
          name = "sandwich replace query",
          s = { name = "auto", t = "tag", f = "func" },
          i = "instant",
        },
      },
    }

    wk.register(keys, { mode = "n" })
  end

  -- local wk = require "which-key"
  -- wk.register {
  --   d = {
  --     s = { name = "sandwich delete query", s = "auto", i = "instant" }, -- just a labeel
  --   },
  --   y = {
  --     ["<C-g>"] = "which_key_ignore",
  --     S = { name = "end of line", i = "instant", f = "func", t = "tag" },
  --     s = {
  --       name = "sandwich add query",
  --       s = { name = "auto", f = "func", t = "tag", i = "instant" },
  --       i = {
  --         name = "inner",
  --         p = "paragraph",
  --         s = "sentence",
  --         t = "tag",
  --         w = "word",
  --         [")"] = "parentheses",
  --         ["]"] = "brackets",
  --         ["}"] = "braces",
  --         ["'"] = "'",
  --         ['"'] = '"',
  --         [">"] = ">",
  --         ["`"] = "`",
  --       },
  --       a = {
  --         name = "outer",
  --         p = "paragraph",
  --         s = "sentence",
  --         t = "tag",
  --         w = "word",
  --         [")"] = "parentheses",
  --         ["]"] = "brackets",
  --         ["}"] = "braces",
  --         ["'"] = "'",
  --         ['"'] = '"',
  --         [">"] = ">",
  --         ["`"] = "`",
  --       },
  --       w = "next word",
  --       e = "end of word",
  --       f = "find",
  --       t = "until",
  --       ["/"] = "search",
  --     },
  --   },
  --   c = {
  --     s = {
  --       name = "sandwich replace query",
  --       s = { name = "auto", t = "tag", f = "func" },
  --       i = "instant",
  --     },
  --   },
  -- }
end

return M
