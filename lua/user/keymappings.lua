local M = {}

local mapx = require("mapx").setup { global = "force", whichkey = true }
local mapper = require "nvim-mapper"

M.config = function()
  -- TODO: S in visual mode should be lightspeed_S, so what should I use for visual sandwich surround?

  -----[[------------]]-----
  ---       Normal       ---
  -----]]------------[[-----
  local m = require("mapx").setup { whichkey = true }
  -- normal mode remaps (without support for whichkey)
  -- local nnoremap = M.nnoremap

  -- I use jkl; instead of hjkl
  M.nnoremap(";", "l", "Navigation", "right", "Move cursor to right.")
  M.nnoremap("l", "h", "Navigation", "left", "Move cursor to left.")

  -- since I don't use h to move cursor, might as well use it to enter command mode
  M.nnoremap("h", ":", "Modes", "command_mode", "Enter command mode.")

  -- keep cursor centered when using n(next) and N(previous)
  M.nnoremap("n", "nzzzv", "Search", "next_occurrence", "Search forwards for the next occurrence.")
  M.nnoremap("N", "Nzzzv", "Search", "prev_occurrence", "Search backwards for the previous occurrence.")

  -- keep cursor centered and in-place when joining lines with J
  M.nnoremap("J", "mzJ`z", "Editing", "join_lines", "Join line below to to the current one while keeping cursor centered and in-place.")

  -- reverse join
  -- lvim.keys.normal_mode["H"] = "revJ"

  -- easy align
  -- lvim.keys.normal_mode["L"] = "vimeasyalign"

  -- make Y act like D and C but for yanking (this is going to get merged into neovim core)
  -- nnoremap("Y", "y$", "", "", "", "")

  -- like the previous but ignores white space
  -- lvim.keys.normal_mode["Y"] = "yg_"

  -- save
  -- lvim.keys.normal_mode["<C-s>"] = ":update<cr>"

  -- -- Don't yank on delete char?
  -- vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap("n", "X", '"_X', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap("v", "x", '"_x', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap("v", "X", '"_X', { noremap = true, silent = true })

  -- navigate windows/splits
  M.nnoremap("<C-l>", "<cmd>lua require('Navigator').left()<CR>", "Navigation", "move_cursor_left_window", "Move cursor to the left window.")
  M.nnoremap("<C-j>", "<cmd>lua require('Navigator').down()<CR>", "Navigation", "move_cursor_down_window", "Move cursor to the window below.")
  M.nnoremap("<C-k>", "<cmd>lua require('Navigator').up()<CR>", "Navigation", "move_cursor_up_window", "Move cursor to the window above.")
  M.nnoremap("<C-h>", "<cmd>lua require('Navigator').right()<CR>", "Navigation", "move_cursor_right_window", "Move cursor to the right window.")
  -- I have <C-;> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing

  -- clean control keybindings so I can use them with tmux
  -- M.nnoremap("<C-b>", "", "Tmux", "tmux-c-b", "empty c-b")
  -- M.nnoremap("<C-e>", "", "Tmux", "tmux-c-e", "empty c-e")
  -- M.nnoremap("<C-f>", "", "Tmux", "tmux-c-f", "empty c-f")
  -- M.nnoremap("<C-g>", "", "Tmux", "tmux-c-g", "empty c-g")
  -- M.nnoremap("<C-h>", "", "Tmux", "tmux-c-h", "empty c-h")
  -- M.nnoremap("<C-m>", "", "Tmux", "tmux-c-m", "empty c-m")
  -- M.nnoremap("<C-n>", "", "Tmux", "tmux-c-n", "empty c-n")
  -- M.nnoremap("<C-p>", "", "Tmux", "tmux-c-p", "empty c-p")
  -- M.nnoremap("<C-s>", "", "Tmux", "tmux-c-s", "empty c-s")
  -- M.nnoremap("<C-x>", "", "Tmux", "tmux-c-x", "empty c-x")
  -- M.nnoremap("<C-y>", "", "Tmux", "tmux-c-y", "empty c-y")
  -- M.nnoremap("<C-z>", "", "Tmux", "tmux-c-z", "empty c-z")
  -- M.nnoremap("<C-/>", "", "Tmux", "tmux-c-/", "empty c-/")

  -- Increment
  M.nnoremap("<A-a>", "<C-a>", "Editing", "select_all", "Select all buffer text.")

  -- move current line up/down
  M.nnoremap("<A-j>", ":m .+1<cr>==", "Editing", "move_line_up", "Move current line up.")
  M.nnoremap("<A-k>", ":m .-2<cr>==", "Editing", "move_line_down", "Move current line down.")

  -- jump back and forth between buffers (mirror C-o/C-i for moving in the jumplist)
  M.nnoremap("<A-o>", ":lua require('bufjump').backward()<cr>", "Navigation", "prev_jumplist_buf", "Move to previous buffer in jumplist")
  M.nnoremap("<A-i>", ":lua require('bufjump').forward()<cr>", "Navigation", "next_jumplist_buf", "Move to next buffer in jumplist")

  -- quickly toggle terminals
  M.nnoremap("<A-h>", "<cmd>lua require('user.builtins.toggleterm').toggle_term2()<cr>", "Terminal", "toggle_term2", "Toggle terminal in position 2")

  -- quickly switch to harpoon marked files
  M.nnoremap("<A-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", "Navigation", "harpoon_nav_file5", "Move to harpoon file 5")
  M.nnoremap("<A-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Navigation", "harpoon_nav_file4", "Move to harpoon file 4")
  M.nnoremap("<A-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Navigation", "harpoon_nav_file3", "Move to harpoon file 3")
  M.nnoremap("<A-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Navigation", "harpoon_nav_file2", "Move to harpoon file 2")
  M.nnoremap("<A-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Navigation", "harpoon_nav_file1", "Move to harpoon file 1")

  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12)
  M.nnoremap("Q949", "_", "Motion", "first_non_blank", "Jump to the first non-blank character of the line.")
  M.nnoremap("12", "$", "Motion", "end_of_line", "Jump to the end of the line.")

  -- more ergonomic matchup mapping with alt-tab (since just tab conflicts with C-i for jumplist navigation)
  -- vim.cmd "noremap <silent> <A-Tab> :<C-u>normal %<CR>"
  M.nnoremap("<A-Tab>", ":<C-u>normal %<cr>", "Motion", "matchup", "Move to matching character.")

  -- no highlight on esc
  M.nnoremap("<Esc>", "<cmd>nohlsearch<cr>", "Search", "no_highlight_search", "Remove highlighting of search matches")

  -----[[------------]]-----
  ---       Visual       ---
  -----]]------------[[-----
  -- visual mode remaps (without support for whichkey)
  -- local vnoremap = M.vnoremap

  -- better movement keys
  M.vnoremap(";", "l", "Navigation", "visual_right", "Move cursor to right.")
  M.vnoremap("l", "h", "Navigation", "visual_left", "Move cursor to left.")

  -- better pasting in visual mode
  vnoremap("p", [["_dP]])

  -- Move visual selection up/down
  M.vnoremap("<A-j>", ":m '>+1<cr>gv=gv", "Editing", "visual_move_line_up", "Move current line up.")
  M.vnoremap("<A-k>", ":m '<-2<cr>gv=gv", "Editing", "visual_move_line_down", "Move current line down.")

  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12)
  M.vnoremap("Q949", "_", "Motion", "visual_first_non_blank", "Jump to the first non-blank character of the line.")
  M.vnoremap("12", "$", "Motion", "visual_end_of_line", "Jump to the end of the line.")

  -----[[------------]]-----
  ---       Insert       ---
  -----]]------------[[-----
  -- insert mode remaps (without support for whichkey)
  -- local vnoremap = M.inoremap

  -- inoremap("jk", "")
  -- inoremap("kj", "")
  -- inoremap("jj", "")

  -- lvim.keys.insert_mode["<C-a>"] = "<esc>I"
  -- lvim.keys.insert_mode["<C-e>"] = "<esc>A"
  -- lvim.keys.insert_mode["<C-f>"] = "<Right>"
  -- lvim.keys.insert_mode["<C-b>"] = "<Left>"

  -- select all
  M.inoremap("<A-a>", "<ESC>ggVG<CR>", "Editing", "insert_select_all", "Select all buffer text in insert mode.")

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

  -- make sure tmux doesn't bind anything to C-s

  -- ergonmic mappings for end of line and beginning of line my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12
  M.inoremap("Q949", "<Esc>_i", "Motion", "insert_first_non_blank", "Jump to the first non-blank character of the line.")
  M.inoremap("12", "<Esc>$a", "Motion", "insert_end_of_line", "Jump to the end of the line.")

  M.inoremap("<S-Left>", "<C-\\><C-O><Plug>WordMotion_b", "Motion", "word_motion_back", "Jump backwards to the start of a word.")
  M.inoremap("<S-Right>", "<C-\\><C-O><Plug>WordMotion_w", "Motiion", "word_motion_word", "Jump forwards tto the start of a word")

  -- NOTE: not sure if i want this mapping (visually laggy)
  inoremap("<C-w>", "<c-\\><c-O>b<c-\\><c-O>d<S-Right>")

  -- Undo break points (for a finer-grained undo command)
  -- should I add space to this list?
  inoremap(",", ",<c-g>u")
  inoremap(".", ".<c-g>u")
  inoremap("!", "!<c-g>u")
  inoremap("?", "?<c-g>u")
  inoremap("<cr>", "<cr><c-g>u")
  inoremap("<space>", "<space><c-g>u")

  -- Fix previous spelling mistake
  M.inoremap("<A-h>", "<c-g>u<Esc>[s1z=`]a<c-g>u", "Editing", "fix_prev_spelling", "Fix previous spelling mistake")

  -- A-del is mapped to delete previous word on my keyboard (macos), make that consistent inside nvim
  M.inoremap("<A-bs>", "<c-w>", "Editing", "delelte_word", "Delete word before the cursor.")

  -----[[------------]]-----
  ---        Term        ---
  -----]]------------[[-----
  -- this prevents lazygit from working properly
  -- lvim.keys.term_mode["<esc>"] = [[<C-\><C-n>]]

  -- NOTE: WhichKey

  -- TODO: doom-emacs keys
  --[[
    <cr> = jump to bookmark
    <space> = find file in project
    <tab> = +workspace
    ' = resume last search
    * = search for symbol in project
    , = switch workspace buffer
    . = find file
    / = search project
    < = switch buffer
    ` = switch to last buffer`

  --]]

  -----[[------------]]-----
  ---      Whichkey      ---
  -----]]------------[[-----
  -- Whichkey remaps
  -- local nnoremap = M.nnoremap_which

  M.nnoremap_which("<Leader>a", "<cmd>up<CR>", "write buffer", "Editing", "update", "Writes the buffer but only if it has been modified.")
  M.nnoremap_which("<Leader>t", "<cmd>NvimTreeToggle<CR>", "file tree", "Files", "nvimtree_toggle", "Toggles Nvimtree")
  M.nnoremap_which("<Leader>f", "<cmd>Lf %<cr>", "files", "Files", "lf_togggle", "Toggles Lf (file manager)")
  -- toggle spell check
  M.nnoremap_which("<Leader>i", "<cmd>set spell!<cr>", "spellcheck", "Editing", "toggle_spellcheck", "Toggle spellcheck")
  M.nnoremap_which("<Leader>q", "<cmd>qa<cr>", "quit", "Quit", "quit_all", "Exit NeoVim")
  -- TODO: make Lf use gomi to delete files
  M.nnoremap_which(
    "<Leader>u",
    "<cmd>lua require('user.builtins.toggleterm').restore_files()<cr>",
    "restore files",
    "Files",
    "restore_files_gomi",
    "Restore files through Gomi"
  )
  M.nnoremap_which(
    "<Leader>y",
    "<cmd>lua require('telescope').extensions.neoclip.default({initial_mode = 'normal'})<cr>",
    "yank history",
    "Yank",
    "neoclip_yank_history",
    "Toggle Neoclip (clipboard manager)"
  )
  M.nnoremap_which("<Leader>/", "<cmd>lua require('Comment').toggle()<CR>", "comment", "Comment", "toggle_comment", "Toggle line comment.")
  M.nnoremap_which("<Leader>;", "<cmd>Dashboard<CR>", "dashboard", "Navigation", "dashboard", "Jump to dashboard.")

  nnoremap("<Leader>c", "", "which_key_ignore")
  nnoremap("<Leader>e", "", "which_key_ignore")

  -- =========================================
  -- +Buffers
  -- =========================================
  m.name("<Leader>b", "+Buffers")
  M.nnoremap_which("<Leader>ba", "<cmd>BDelete all<cr>", "delete all buffers", "Buffers", "del_all_buf", "Deletes all buffers.")
  M.nnoremap_which(
    "<Leader>bb",
    "<cmd>lua require'user.telescope.custom_pickers'.switch_buffers()<cr>",
    "switch buffer",
    "Buffers",
    "buffer_switcher",
    "Open buffer switcher."
  )
  M.nnoremap_which("<Leader>bd", "<cmd>BDelete this<CR>", "close this buffer", "Buffers", "del_buf", "Delete current buffer.")
  M.nnoremap_which("<Leader>bh", "<cmd>BDelete! hidden<cr>", "close hidden buffers", "Buffers", "del_hidden_bufs", "Delete all hidden buffers.")
  M.nnoremap_which("<Leader>bn", "<cmd>bnext<cr>", "next buffer", "Buffers", "next_buf", "Jump to next buffer.")
  M.nnoremap_which("<Leader>bo", "<cmd>BDelete! other<CR>", "close other buffers", "Buffers", "del_other_bufs", "Delete other buffers.")
  M.nnoremap_which("<Leader>bp", "<cmd>bprevious<cr>", "previous buffer", "Buffers", "prev_buf", "Jump to previous buffer.")
  -- ignore builtin lunarvim mappings
  nnoremap("<Leader>bc", "", "which_key_ignore")
  nnoremap("<Leader>bD", "", "which_key_ignore")
  nnoremap("<Leader>be", "", "which_key_ignore")
  nnoremap("<Leader>bf", "", "which_key_ignore")
  nnoremap("<Leader>bj", "", "which_key_ignore")
  nnoremap("<Leader>bl", "", "which_key_ignore")
  nnoremap("<Leader>bL", "", "which_key_ignore")
  nnoremap("<Leader>bw", "", "which_key_ignore")

  -- =========================================
  -- +Debugging
  -- =========================================
  m.name("<Leader>d", "+Debug")
  M.nnoremap_which("<Leader>dU", "<cmd>lua require('dapui').toggle()<cr>", "toggle debug UI", "Debug", "dapui_toggle", "Toggle dapui (debug ui)")
  M.nnoremap_which("<Leader>de", "<cmd>lua require('dapui').eval()<cr>", "eval", "Debug", "dapui_eval", "Evaluate expression in dapui")

  -- =========================================
  -- +Git
  -- =========================================
  m.name("<Leader>g", "+Git")
  M.nnoremap_which("<Leader>gi", "<cmd>Octo issue list<cr>", "list issues", "Git", "octo_issue_list", "List Github issues.")
  M.nnoremap_which("<Leader>gl", "<cmd>lua require'gitsigns'.blame_line(true)<cr>", "blame message", "Git", "gitsigns_blame_line", "Toggle git blame line.")
  M.nnoremap_which(
    "<Leader>gL",
    "<cmd>lua require('user.builtins.toggleterm').forgit_log()<cr>",
    "forgit diff",
    "Git",
    "forgit_diff_log",
    "Open git log with forgot"
  )
  M.nnoremap_which("<Leader>gP", "<cmd>Octo pr list<cr>", "list pull requests", "Git", "octo_pr_list", "List Github pull requests.")
  M.nnoremap_which("<Leader>gg", "<cmd>lua require('user.builtins.toggleterm').lazy_git()<CR>", "LazyGit", "Git", "lazygit_toggle", "Open Lazygit.")
  M.nnoremap_which("<Leader>gG", "<cmd>Neogit<CR>", "Neogit", "Git", "neogit_toggle", "Open Neogit")
  M.nnoremap_which(
    "<Leader>gc",
    "<cmd>lua require('user.telescope.custom_pickers').delta_git_commits()<CR>",
    "project's commits",
    "Git",
    "git_commits_delta",
    "Open project's git commits with delta preview."
  )
  M.nnoremap_which(
    "<Leader>gC",
    "<cmd>lua require('user.telescope.custom_pickers').delta_git_bcommits()<CR>",
    "buffer's commits",
    "Git",
    "git_bcommits_delta",
    "Open buffer's git commits with delta preview."
  )
  -- buffer log?
  -- S to stage file
  -- U to unstage file
  -- list issues
  -- list notfiicationns
  -- list pull requests
  -- list repositories
  -- list submodules

  -- =========================================
  -- +Harpoon
  -- =========================================
  m.name("<Leader>h", "+Harpoon")
  M.nnoremap_which("<Leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", "mark buffer", "Navigation", "harpoon_add_file", "Mark a file in Harpoon.")
  M.nnoremap_which("<Leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "show marks", "Navigation", "harpoon_quick_menu", "Toggle Harpoon file navigation quick menu")
  M.nnoremap_which(
    "<Leader>h1",
    "<cmd>lua require('harpoon.ui').nav_file(1)<CR>",
    "switch to mark 1",
    "Navigation",
    "harpoon_nav_file1_which",
    "Move to harpoon file 1"
  )
  M.nnoremap_which(
    "<Leader>h2",
    "<cmd>lua require('harpoon.ui').nav_file(2)<CR>",
    "switch to mark 2",
    "Navigation",
    "harpoon_nav_file2_which",
    "Move to harpoon file 2"
  )
  M.nnoremap_which(
    "<Leader>h3",
    "<cmd>lua require('harpoon.ui').nav_file(3)<CR>",
    "switch to mark 3",
    "Navigation",
    "harpoon_nav_file3_which",
    "Move to harpoon file 3"
  )
  M.nnoremap_which(
    "<Leader>h4",
    "<cmd>lua require('harpoon.ui').nav_file(4)<CR>",
    "switch to mark 4",
    "Navigation",
    "harpoon_nav_file4_which",
    "Move to harpoon file 4"
  )
  M.nnoremap_which(
    "<Leader>h5",
    "<cmd>lua require('harpoon.ui').nav_file(5)<CR>",
    "switch to mark 5",
    "Navigation",
    "harpoon_nav_file5_which",
    "Move to harpoon file 5"
  )

  -- =========================================
  -- +LSP
  -- =========================================
  -- TODO: override builtin LSP mappings
  -- ["b"] =
  -- ["c"] = compile
  -- ["g"] =
  -- ["h"] =
  -- ["m"] =
  -- ["n"] =
  -- ["s"] =
  -- ["u"] =
  -- ["v"] =
  -- ["y"] =
  m.name("<Leader>l", "+LSP")
  M.nnoremap_which("<Leader>la", "<cmd>CodeActionMenu<cr>", "code actions", "Code", "code_action_menu", "Show menu for code actions.")
  M.nnoremap_which("<Leader>lA", "<cmd>lua vim.lsp.codelens.run()<cr>", "codelens actions", "Code", "codelens_action_menu", "Show menu for codelens actions.")
  -- nnoremap("<Leader>lb", "<cmd>lua require'nvim-biscuits'.toggle_biscuits()<cr>", "toggle biscuits")
  M.nnoremap_which("<Leader>ld", "<cmd>TroubleToggle lsp_definitions<cr>", "definitions", "Code", "trouble_lsp_definitions", "Toggle LSP definitions.")
  M.nnoremap_which("<Leader>le", "<cmd>TroubleToggle lsp_references<cr>", "references", "Code", "trouble_lsp_references", "Toggle LSP references.")
  M.nnoremap_which("<Leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", "format", "Code", "lsp_format", "Format buffer")
  M.nnoremap_which("<Leader>ll", "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<cr>", "line diagnostics", "Code", "line_diagnostics", "Show line diagnostics in a popup window")
  -- TODO: use aerial.nvim
  M.nnoremap_which("<Leader>lo", "<cmd>SymbolsOutline<cr>", "symbol outline", "Code", "symbols_outline", "Toggle SymbolsOutline (tree-like view of for symbols powered by LSP)")
  m.name("<Leader>lp", "+Peek")
  M.nnoremap_which("<Leader>lpd", "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "peek definition", "Code", "peek_definition", "Peek definition.")
  M.nnoremap_which("<Leader>lpt", "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "peek type definition", "Code", "peek_type_definition", "Peek type definition.")
  M.nnoremap_which("<Leader>lpi", "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "peek implementation", "Code", "peek_implementation", "Peek implementation.")
  M.nnoremap_which("<Leader>lr", "<cmd>lua require('renamer').rename()<cr>", "rename", "Code", "renamer", "Rename symbol.")
  -- nnoremap("<Leader>lt", "<cmd>TroubleToggle lsp_definitions<cr>", "definitions")
  M.nnoremap_which("<Leader>lx", "<cmd>TroubleToggle document_diagnostics<cr>", "document diagnostics", "Code", "trouble_document_diagnostics", "Toggle document diagnostics.")
  M.nnoremap_which("<Leader>lX", "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics", "Code", "trouble_workspace_diagnostics", "Toggle workspace diagnostics.")

  nnoremap("<Leader>li", "", "which_key_ignore")
  nnoremap("<Leader>lI", "", "which_key_ignore")
  nnoremap("<Leader>lj", "", "which_key_ignore")
  nnoremap("<Leader>lk", "", "which_key_ignore")
  nnoremap("<Leader>ls", "", "which_key_ignore")
  nnoremap("<Leader>lS", "", "which_key_ignore")

  -- +M (Localleader)
  -- TODO: should i use minor_mode.nvim for this?
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

  -- =========================================
  -- +Notes
  -- =========================================
  m.name("<Leader>n", "+Notes")
  M.nnoremap_which("<Leader>nf", "<cmd>Lf ~/.config/lvim/lua/notes/obsidian-notes/<cr>", "manage notes", "Notes", "open_notes_folder", "Open my Obsidian notes folder.")
  M.nnoremap_which("<Leader>nw", "<plug>(wiki-index)", "wiki index", "Notes", "open_wiki_index", "Open Vimwiki index file.")

  -- =========================================
  -- +Replace
  -- =========================================
  m.name("<Leader>r", "+Replace")
  M.nnoremap_which("<Leader>rf", "<cmd>lua require('spectre').open_file_search()<cr>", "replace file", "Replace", "spectre_file_search", "Find and replace in current file.")
  M.nnoremap_which("<Leader>rr", "<cmd>lua require('spectre').open()<cr>", "replace", "Replace", "spectre_search", "Find and replace in workspace.")
  M.nnoremap_which("<Leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "replace word", "Replace", "spectre_word_search", "Find and replace selected word.")

  -- +Search
  -- =========================================
  m.name("<Leader>s", "+Search")
  M.nnoremap_which("<Leader>sb", "<cmd>lua require'user.telescope.custom_pickers'.grep_current_buffer()<cr>", "grep in buffer", "Search", "grep_current_buffer", "Greps in current buffer.")
  M.nnoremap_which("<Leader>sc", "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_config_files()<CR>", "config", "Search", "search_config_files", "Search my config files.")
  M.nnoremap_which("<Leader>sC", "<cmd>lua require'user.telescope.custom_pickers'.grep_config_files()<cr>", "grep in config", "Search", "grep_config_files", "Greps in my config files.")
  M.nnoremap_which("<Leader>sd", "<cmd>Dash<cr>", "docs", "Search", "dash", "Search for documentation in Dash.")
  M.nnoremap_which("<Leader>se", "<cmd>Telescope bookmarks<cr>", "browser bookmarks", "Search", "search_browser_bookmarks", "Search browser bookmarks.")
  M.nnoremap_which("<Leader>s;", "<cmd>Telescope commands<cr>", "vim commands", "Search", "search_vim_commands", "Search vim commands.")
  M.nnoremap_which("<Leader>s.", "<cmd>lua require('user.telescope.custom_pickers').find_dotfiles()<CR>", "dotfiles", "Search", "search_dotfiles", "Search my dotfiles.")
  M.nnoremap_which("<Leader>s>", "<cmd>lua require'user.telescope.custom_pickers'.grep_dotfiles()<cr>", "grep in dotfiles", "Search", "grep_dotfiles", "Greps in my dotfiles.")
  M.nnoremap_which("<Leader>sf", "<cmd>lua require('user.telescope.custom_pickers').find_files()<CR>", "files in project", "Search", "search_project_files", "Search files in current project.")
  M.nnoremap_which("<Leader>sh", "<cmd>Telescope help_tags<cr>", "help tags", "Search", "search_help_tags", "Search help tags.")
  M.nnoremap_which("<Leader>sk", "<cmd>Telescope mapper<cr>", "keymaps", "Search", "search_keymappings_mapper", "Search keymappings through mapper.")
  M.nnoremap_which("<Leader>sl", "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", "LunarVim files", "Search", "search_lunarvim_files", "Search LunarVim files.")
  M.nnoremap_which("<Leader>sn", "<cmd>lua require('user.telescope.custom_pickers').find_notes()<cr>", "notes", "Search", "search_notes", "Search my Obsidian notes.")
  M.nnoremap_which("<Leader>sp", "<cmd>Telescope projects<cr>", "projects", "Search", "search_projects", "Search projects and project files.")
  M.nnoremap_which("<Leader>sr", "<cmd>Telescope oldfiles<cr>", "recent files", "Search", "search_recent_files", "Search recently opened files.")
  M.nnoremap_which("<Leader>sg", "<cmd>lua require('user.telescope.custom_pickers').grep_files()<cr>", "grep in project", "Search", "grep_project_files", "Greps in current project.")
  M.nnoremap_which("<Leader>sz", "<cmd>lua require('user.telescope.custom_pickers').grep_last_search()<cr>", "grep last search", "Search", "grep_last_search", "Greps last search.")
  -- nnoremap("<Leader>sP", "<cmd>lua require'user.telescope.custom_pickers'.conda()<cr>", "conda")
  -- nnoremap("<Leader>sz", "<cmd>Telescope zoxide list<cr>", "zoxide")

  nnoremap("<Leader>sM", "", "which_key_ignore")
  nnoremap("<Leader>sR", "", "which_key_ignore")
  nnoremap("<Leader>st", "", "which_key_ignore")

  -- +Treesitter
  -- ==================================================================================
  M.nnoremap_which("<Leader>Tc", "<cmd>TSContextToggle<cr>", "toggle context", "Code", "ts_context_toggle", "Toggle Treesitter context.")
  M.nnoremap_which("<Leader>Tp", "<cmd>TSPlagroundToggle<cr>", "toggle playground", "Code", "ts_playground_toggle", "Toggle Treesitter playground.")

  nnoremap("<Leader>Ti", "", "which_key_ignore")

  -- +Windows
  -- ==================================================================================
  M.nnoremap_which("<Leader>wd", "<cmd>close<cr>", "delete window", "Windows", "delete_window", "Deletes current window.")
  M.nnoremap_which("<Leader>wo", "<cmd>only<cr>", "delete other windows", "Windows", "only_window", "Deletes all other windows.")
  M.nnoremap_which("<Leader>ws", "<cmd>split<cr>", "split", "Windows", "split_window", "Splits window horizontally.")
  M.nnoremap_which("<Leader>wv", "<cmd>vsplit<cr>", "vsplit", "Windows", "vsplit_window", "Splits window vertically.")
  M.nnoremap_which("<Leader>wz", "<Plug>Zoom<cr>", "toggle zoom window", "Windows", "zoom_window", "Zooms in current window.")

  nnoremap("<Leader>wj", "", "switch window down")
  nnoremap("<Leader>wk", "", "switch window up")
  nnoremap("<Leader>wl", "", "switch window left")
  nnoremap("<Leader>w;", "", "switch window right")

  M.nnoremap_which("ga", "<cmd>CodeActionMenu<cr>", "code actions", "Code", "code_action_menu_g", "Show menu for code actions")
  M.nnoremap_which("gl", "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<cr>", "show line diagnostics", "Code", "line_diagnostics_g", "Show line diagnostics in a popup window")
  M.nnoremap_which("ge", "<cmd>TroubleToggle lsp_references<cr>", "references", "Code", "trouble_lsp_references_g", "Toggle lsp references")

  lvim.builtin.which_key.on_config_done = function(wk)
    local keys = {
      ["]f"] = "next start func",
      ["]]"] = "next start class",
      ["]F"] = "next end func",
      ["]["] = "next end class",
      ["[f"] = "previous start func",
      ["[["] = "previous start class",
      ["[F"] = "previous end func",
      ["[]"] = "previous end class",
      ["ga"] = { "<cmd>CodeActionMenu<CR>", "code actions" },
      ["gl"] = { "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<CR>", "show line diagnostics" },
      ["ge"] = { "<cmd>Trouble lsp_references<CR>", "references" },
      -- ["gI"] = { "<cmd>lua require('user.telescope').lsp_implementations()<CR>", "Goto Implementation" },
      ["<leader>la"] = { "<cmd>CodeActionMenu<cr>", "code actions" },
      ["<leader>lw"] = {
        name = "+swap",
        a = "next parameter",
        A = "previous parameter",
        f = "next function",
        F = "previous functon",
        e = "next element",
        E = "prevous element",
      },
      -- ["ga"] = { "<cmd>lua require('user.telescope').code_actions()<CR>", "Code Action" },
      -- ["gR"] = { "<cmd>Trouble lsp_references<CR>", "Goto References" },
      -- ["gI"] = { "<cmd>lua require('user.telescope').lsp_implementations()<CR>", "Goto Implementation" },
      -- add labels to vim-sandwich
      -- d = {
      --   s = { name = "sandwich delete query", s = "auto", i = "instant" }, -- just a labeel
      -- },
      -- y = {
      --   ["<C-g>"] = "which_key_ignore",
      --   S = { name = "end of line", i = "instant", f = "func", t = "tag" },
      --   s = {
      --     name = "sandwich add query",
      --     s = { name = "line", f = "func", t = "tag", i = "instant" },
      --     i = {
      --       name = "inner",
      --       p = "paragraph",
      --       s = "sentence",
      --       t = "tag",
      --       w = "word",
      --       [")"] = "parentheses",
      --       ["]"] = "brackets",
      --       ["}"] = "braces",
      --       ["'"] = "'",
      --       ['"'] = '"',
      --       [">"] = ">",
      --       ["`"] = "`",
      --     },
      --     a = {
      --       name = "outer",
      --       p = "paragraph",
      --       s = "sentence",
      --       t = "tag",
      --       w = "word",
      --       [")"] = "parentheses",
      --       ["]"] = "brackets",
      --       ["}"] = "braces",
      --       ["'"] = "'",
      --       ['"'] = '"',
      --       [">"] = ">",
      --       ["`"] = "`",
      --     },
      --     w = "next word",
      --     e = "end of word",
      --     f = "find",
      --     t = "until",
      --     ["/"] = "search",
      --   },
      -- },
      -- c = {
      --   s = {
      --     name = "sandwich replace query",
      --     s = { name = "auto", t = "tag", f = "func" },
      --     i = "instant",
      --   },
      -- },
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

M.nnoremap = function(lhs, rhs, category, id, desc)
  mapx.nnoremap(lhs, rhs)
  mapper.map_virtual("n", lhs, "", { noremap = true }, category, id, desc)
end
M.vnoremap = function(lhs, rhs, category, id, desc)
  mapx.vnoremap(lhs, rhs)
  mapper.map_virtual("v", lhs, "", { noremap = true }, category, id, desc)
end
M.inoremap = function(lhs, rhs, category, id, desc)
  mapx.inoremap(lhs, rhs)
  mapper.map_virtual("i", lhs, "", { noremap = true }, category, id, desc)
end

M.nnoremap_which = function(lhs, rhs, label, category, id, desc)
  mapx.nnoremap(lhs, rhs, label)
  mapper.map_virtual("n", lhs, "", { noremap = true }, category, id, desc)
end


return M
