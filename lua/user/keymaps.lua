local M = {}

M.opts_visual_block = M.generic_opts
M.generic_opts = { noremap = true, silent = true }
M.opts_insert = M.generic_opts
M.opts_normal = M.generic_opts
M.opts_visual = M.generic_opts
M.opts_visual_block = M.generic_opts
M.opts_command = M.generic_opts
M.opts_term = { silent = true }

M.config = function()
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                      User commands                       │
  -- ╰──────────────────────────────────────────────────────────╯
  require("user.usercmd").set_user_commands()

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                          Normal                          │
  -- ╰──────────────────────────────────────────────────────────╯
  import("legendary", function(legendary)
    local map = legendary.keymap

    -- Make sure tmux has the following so Home and End works as intended inside it
    -- bind-key -n Home send Escape "OH"
    -- bind-key -n End send Escape "OF"

    -- I use jkl; instead of hjkl
    map { ";", "l", description = "Right", mode = { "n", "v" } }
    map { "l", "h", description = "Left", mode = { "n", "v" } }

    -- since I don't use h to move cursor, might as well use it to enter command mode
    map { "h", ":", description = "Command", mode = { "n", "v" } }

    -- keep cursor centered when using n(next) and N(previous)
    map { "n", "nzzzv", description = "Go to next match (centered)", mode = { "n", "v" } }
    map { "N", "Nzzzv", description = "Go to previous match (centered)", mode = { "n", "v" } }

    -- keep cursor centered and in-place when joining lines with J
    map { "J", "mzJ`z", description = "Join with next line (cursor in-place)", mode = { "n", "v" } }

    -- open URI under cursor, otherwise default to O
    map { "O", ":OpenURIUnderCursor<cr>", description = "Open URI under cursor or open new line above ", mode = { "n", "v" } }

    -- Increment and decrement
    -- lvim.keys.normal_mode["<A-;>"] = "<C-a>"
    -- lvim.keys.normal_mode["<A-l>"] = "<C-x>"

    -- move current line up/down
    map { "<A-j>", ":m .+1<cr>==", description = "Move current line down", mode = { "n" } }
    map { "<A-k>", ":m .-2<cr>==", description = "Move current line up", mode = { "n" } }

    -- toggleterm maps
    map {
      "<A-a>",
      "<cmd>lua require('user.builtin.toggleterm').toggle_term2()<cr>",
      description = "Toggle terminal 2",
      mode = { "n", "v" },
    }
    map {
      "<A-s>",
      "<cmd>lua require('user.builtin.toggleterm').toggle_term3()<cr>",
      description = "Toggle terminal 3",
      mode = { "n", "v" },
    }
    -- lvim.keys.normal_mode["<A-d>"] = ""
    -- lvim.keys.normal_mode["<A-f>"] = ""
    -- lvim.keys.normal_mode["<A-g>"] = ""

    -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to Shift+Left and Cmd+Right mapped to Shift+Right)
    map { "<S-Left>", "_", description = "First non-whitespace character", mode = { "n", "v" } }
    map { "<S-Right>", "$", description = "End of line", mode = { "n", "v" } }

    -- no highlight on esc
    map { "<Esc>", "<cmd>nohlsearch<cr>", description = "Clear 'hlsearch' highlights", mode = { "n" } }

    -- save file with <C-s>
    map { "<C-s>", "<cmd>up!<cr>", description = "Save (only if modified)", mode = { "n", "v" } }

    -- preserve cursor position on yank
    map { "y", "y`]", description = "Copy (preserve cursor position)", mode = { "v" } }

    -- Move visual selection up/down
    map { "<A-j>", ":m '>+1<cr>gv=gv", description = "Move current selection down", mode = { "v" } }
    map { "<A-k>", ":m '<-2<cr>gv=gv", description = "Move current selection up", mode = { "v" } }

    -- Undo break points (for a finer-grained undo command)
    map { ",", ",<c-g>u", description = "", mode = { "i" } }
    map { ".", ".<c-g>u", description = "", mode = { "i" } }
    map { "!", "!<c-g>u", description = "", mode = { "i" } }
    map { "?", "?<c-g>u", description = "", mode = { "i" } }
    map { "<cr>", "<cr>c-g>u", description = "", mode = { "i" } }
    map { "<space>", "<space><c-g>u", description = "", mode = { "i" } }

    -- <C-Bs> maps to <C-h> in terminals, but I like to have <C-bs> delete the previous word.
    map { "<C-h>", "<C-w>", description = "Delete previous word (<C-bs>)", mode = { "i" } }
    map { "<C-bs>", "<C-w>", description = "Delete previous word (<C-bs>)", mode = { "i" } }

    -- <A-bs> is mapped to delete previous word on my keyboard (macos), make that consistent inside nvim
    map { "<A-bs>", "<C-w>", description = "Delete previous word", mode = { "i" } }

    -- Fix previous spelling mistake
    map { "<A-h>", "<c-g>u<Esc>[s1z=`]a<c-g>u", description = "Fix previous spelling mistake", mode = { "i" } }

    -- select all
    map { "<A-a>", "<esc>ggVG<cr>", description = "Select all", mode = { "i" } }

    -- ergonmic mappings for end of line and beginning of line my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12
    map { "<S-Left>", "<Esc>_i", description = "First non-whitespace character", mode = { "i" } }
    map { "<S-Right>", "<Esc>$a", description = "End of line", mode = { "i" } }

    -- emacs-like maps for insert mode
    -- lvim.keys.insert_mode["<C-a>"] = "<esc>I"
    -- lvim.keys.insert_mode["<C-e>"] = "<esc>A"
    -- lvim.keys.insert_mode["<C-f>"] = "<Right>"
    -- lvim.keys.insert_mode["<C-b>"] = "<Left>"

    -- unmap a default keymapping
    -- lvim.keys.normal_mode["<C-Up>"] = false
  end)

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Telescope                         │
  -- ╰──────────────────────────────────────────────────────────╯
  -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
  -- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
  local _, actions = pcall(require, "telescope.actions")
  lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
      ["<C-h>"] = { "<c-s-w>", type = "command" },
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<cr>"] = actions.select_default,
    },
    -- for normal mode
    n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["q"] = actions.close,
      [";"] = actions.select_default,
      ["<Esc>"] = actions.close,
    },
  }
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         Whichkey                         │
  -- ╰──────────────────────────────────────────────────────────╯
  -- lvim.builtin.which_key.mappings["<cr>"] = { "Jump to bookmark" }
  lvim.builtin.which_key.mappings["<space>"] =
    { "<cmd>lua require('user.telescope.custom_pickers').find_files()<cr>", "Find file in project" }
  -- lvim.builtin.which_key.mappings["<tab>"] = { "workspace group" }
  lvim.builtin.which_key.mappings["*"] = { "<cmd>Telescope grep_string<cr>", "Search symbol" }
  -- lvim.builtin.which_key.mappings[","] = { "Switch workspace buffer" }
  -- lvim.builtin.which_key.mappings["."] = { "Find file" } -- picks a project then finds over it
  lvim.builtin.which_key.mappings["?"] = { "<cmd>lua require('user.telescope.custom_pickers').fuzzy_grep_files()<cr>", "Search project" }
  lvim.builtin.which_key.mappings[":"] = { "<cmd>Telescope commands theme=ivy<cr>", "Commands" }
  lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<cr>", "Dashboard" }
  -- lvim.builtin.which_key.mappings[";"] = { "Eval expression" }
  -- lvim.builtin.which_key.mappings["<"] = { "Switch buffer" }
  -- lvim.builtin.which_key.mappings["`"] = { "Switch to last buffer" }
  lvim.builtin.which_key.mappings["'"] = { "<cmd>Telescope resume<cr>", "Resume last search" }
  -- lvim.builtin.which_key.mappings["a"] = { "Actions" }
  lvim.builtin.which_key.mappings["e"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["h"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["i"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["j"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["k"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["m"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["o"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["q"] = { "<cmd>lua require('user.usercmd').smart_quit()<cr>", "Quit" }
  lvim.builtin.which_key.mappings["r"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["u"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["v"] = "which_key_ignore"
  -- lvim.builtin.which_key.mappings["x"] = { "Pop up scratch buffer" }
  -- lvim.builtin.which_key.mappings["X"] = { "Org Capture" }
  -- lvim.builtin.which_key.mappings["~"] = { "Toggle last popup" }

  -- lvim.builtin.which_key.mappings["h"] = { "help gorup" }
  -- lvim.builtin.which_key.mappings["i"] = { "insert group" }
  -- lvim.builtin.which_key.mappings["n"] = { "notes group" }
  -- lvim.builtin.which_key.mappings["o"] = { "open group" }
  -- lvim.builtin.which_key.mappings["p"] = { "project group" }
  -- lvim.builtin.which_key.mappings["q"] = { "quit/session group" }
  -- lvim.builtin.which_key.mappings["s"] = { "search group" }
  -- lvim.builtin.which_key.mappings["t"] = { "toggle group" }
  -- lvim.builtin.which_key.mappings["w"] = { "window group" }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +Buffers                         │
  -- ╰──────────────────────────────────────────────────────────╯
  --
  -- TODO: lvim.builtin.which_key.mappings["b"] = { "buffer group" }
  lvim.builtin.which_key.mappings["b"] = { "buffers" }
  M.set_buffers_keymaps()

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          +code                           │
  --  ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["c"] = {
    name = "code",
    ["a"] = { "<cmd>Lspsaga code_action<cr>", "Code actions" },
    -- ["c"] = { "Compile" },
    -- ["C"] = { "Recompile" },
    ["d"] = { vim.lsp.buf.definition, "Jump to definition" },
    ["D"] = { vim.lsp.buf.references, "Jump to references" },
    -- ["e"] = { "Evaluate buffer/region" },
    -- ["E"] = { "Evaluate & replace region" },
    ["f"] = { require("lvim.lsp.utils").format, "Format buffer/region" },
    ["h"] = { "<cmd>Lspsaga lsp_finder<cr>", "Definitions & references" },
    ["i"] = { vim.lsp.buf.implementation, "Find implementation" },
    ["j"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Jump to next diagnostic" },
    ["k"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Jump to prev diagnostic" },
    ["K"] = { vim.lsp.buf.hover, "Show documentation" },
    ["l"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
    -- ["o"] = { "organize imports" },
    ["p"] = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
    -- ["r"] = { "<cmd>IncRename<cr>", "Rename symbol" },
    ["s"] = { vim.lsp.buf.signature_help, "Show signature help" },
    -- ["S"] = { "Send to repl" },
    -- ["t"] = { "Fid type definition" },
    -- ["w"] = { "Delete trailing whitespace" },
    -- ["W"] = { "Delete trailing newlines" },
    ["x"] = { "<cmd>Telescope diagnostics theme=ivy<cr>", "List errors" },
    -- ["y"] = { "call hierarchy" },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +comment                         │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment line" }
  lvim.builtin.which_key.mappings["C"] = {
    name = "comment",
    ["a"] = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", "comment end of line" },
    ["b"] = { "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", "comment block" },
    ["c"] = {
      "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>",
      "comment line",
    },
    ["o"] = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", "comment below" },
    ["O"] = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", "comment above" },
  }

  lvim.builtin.which_key.vmappings["/"] =
    { "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "comment line" }
  lvim.builtin.which_key.vmappings["C"] = {
    name = "comment",
    ["c"] = { "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "comment line" },
    ["b"] = { "<ESC><CMD>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>", "comment block" },
  }

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          +files                          │
  --  ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["f"] = {
    name = "files",
    ["."] = { "<cmd>lua require('user.telescope.custom_pickers').find_dotfiles()<cr>", "Find file in dotfiles" },
    -- ["c"] = { "", "Open project editorconfig" },
    -- ["C"] = { "", "Copy this file" },
    -- ["d"] = { "", "Find directory" }, -- Search for directories, on <cr> open dired
    -- ["D"] = { "", "Delete this file" },
    ["e"] = { "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_files()<cr>", "Find file in .local/lunarvim" },
    -- ["E"] = { "", "Browse .local/lunarvim" },
    ["f"] = { "<cmd>lua require('user.telescope.custom_pickers').find_files()<cr>", "Find file" },
    -- ["F"] = { "", "Find file from here" }, -- Populate current file path but don't allow to delete it
    ["l"] = { "<cmd>Lf %<cr>", "file manager" },
    ["p"] = {
      "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_config_files()<cr>",
      "Find file in private config",
    },
    -- ["P"] = { "", "Browse private config" },
    -- ["P"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_config_files()<cr>", "Grep in private config" },
    ["r"] = {
      "<cmd>lua require('telescope').extensions.recent_files.pick(require('telescope.themes').get_ivy{})<cr>",
      "Recent files",
    },
    -- ["R"] = { "", "Rename/move file" },
    -- ["s"] = { "", "Save file" },
    -- ["S"] = { "", "Save file as..." },
    -- ["u"] = { "", "Sudo find file" },
    -- ["U"] = { "", "Sudo this file" },
    -- ["y"] = { "", "Yank file path" },
    -- ["Y"] = { "", "Yank file path from project" },
  }
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                           +git                           │
  -- ╰──────────────────────────────────────────────────────────╯
  -- TODO: lvim.builtin.which_key.mappings["g"] = { "git group" }
  lvim.builtin.which_key.mappings["g"] = {
    name = "+Git",
    b = { "<cmd>Telescope git_branches theme=ivy<cr>", "checkout branch" },
    c = { "<cmd>Telescope git_commits theme=ivy<cr>", "checkout commit" },
    C = { "<cmd>Telescope git_bcommits theme=ivy<cr>", "checkout commit (for current file)" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "git diff" },
    -- j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "next Hunk" },
    -- k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "prev Hunk" },
    -- l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "blame" },
    o = { "<cmd>Telescope git_status theme=ivy<cr>", "open changed file" },
    -- p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "preview hunk" },
    -- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "reset hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "reset buffer" },
    -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "stage hunk" },
    s = { "Staging mode" },
    -- u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "undo stage hunk" },
  }
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          +help                           │
  --  ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["h"] = {
    name = "+help",
    ["e"] = { "<cmd>Telescope noice theme=ivy", "View echo history" },
    ["E"] = { "<cmd>Noice errors<cr>", "View errors" },
    ["b"] = { "<cmd>Legendary<cr>", "View keymaps" },
    ["i"] = { "<cmd>LspInfo<cr>", "LSP info" },
    ["I"] = { "<cmd>LspInstallInfo<cr>", "LSP info" },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                          +Notes                          │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["n"] = {
    name = "+Notes",
    -- ["a"] = { "", "agenda" },
    ["e"] = {
      "<cmd>lua require('fm-nvim').Lf(vim.fn.fnameescape(vim.fn.expand '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax/evergreen-notes/'))<cr>",
      "browse evergreen notes",
    },
    ["f"] = {
      "<cmd>lua require('fm-nvim').Lf(vim.fn.fnameescape(vim.fn.expand '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'))<cr>",
      "browse fleeting notes",
    },
    ["g"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_notes()<cr>", "grep in notes" },
    ["l"] = {
      "<cmd>lua require('fm-nvim').Lf(vim.fn.fnameescape(vim.fn.expand '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax/literature-notes/'))<cr>",
      "browse literature notes",
    },
    -- ["n"] = { "", "new note" },
    ["j"] = { "<cmd>MkdnNextHeading<cr>", "next heading" },
    ["k"] = { "<cmd>MkdnPrevHeading<cr>", "previous heading" },
    ["s"] = { "<cmd>lua require('user.telescope.custom_pickers').find_notes()<cr>", "search file in notes" },
    ["r"] = { "<cmd>MkdnMoveSource<cr>", "rename link's source" },
    ["t"] = { "<cmd>MkdnToggleToDo<cr>", "toggle todo item" },
    ["n"] = { "<cmd>MkdnUpdateNumbering<cr>", "update list numbering" },
    ["y"] = { "<cmd>MkdnYankAnchorLink<cr>", "yank anchor link" },
    ["Y"] = { "<cmd>MkdnYankFileAnchorLink<cr>", "yank file anchor link" },
  }
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         +project                         │
  --  ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["p"] = {
    name = "project",
    -- ["!"] = { "", "Run cmd in project root" },
    -- ["&"] = { "", "Async cmd in project root" },
    -- ["."] = { "", "Browse project" },
    -- [">"] = { "", "Browse other project" },
    -- ["a"] = { "", "Add new project" },
    -- ["b"] = { "", "Switch to project buffer" },
    -- ["c"] = { "", "Compile in project" },
    -- ["C"] = { "", "Repeat last command" },
    -- ["d"] = { "", "Remove known project" },
    -- ["D"] = { "", "Discover projects in folder" },
    -- ["e"] = { "", "Edit project .dir-local" },
    ["f"] = { "<cmd>lua require('user.telescope.custom_pickers').find_files()<cr>", "Find file in project" },
    ["F"] = { "<cmd>Telescope projects theme=ivy<cr>", "Find file in other project" },
    -- ["g"] = { "", "Configure project" },
    -- ["i"] = { "", "Invalidate project cache" },
    -- ["k"] = { "", "Kill project buffers" },
    -- ["o"] = { "", "Find other file" },
    ["p"] = { "<cmd>Telescope projects theme=ivy<cr>", "Switch project" }, -- change <cr> to cd into project
    -- ["r"] = { "", "Find recent project files" },
    -- ["R"] = { "", "Run project" },
    -- ["s"] = { "", "Save project files" },
    ["t"] = { "<cmd>TodoQuickList<cr>", "List project todos" },
    -- ["T"] = { "", "Test project" },
    -- ["x"] = { "", "Pop up scratch buffer" },
    -- ["X"] = { "", "Switch to scratch buffer" },
  }

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         +Packer                          │
  --  ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["P"] = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "packer compile" },
    i = { "<cmd>PackerInstall<cr>", "packer install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "recompile" },
    s = { "<cmd>PackerSync<cr>", "packer sync" },
    S = { "<cmd>PackerSync --preview<cr>", "packer sync --preview" },
    t = { "<cmd>PackerStatus<cr>", "packer status" },
    U = { "<cmd>PackerUpdate --preview<cr>", "packer update --preview" },
    u = { "<cmd>PackerUpdate --preview<cr>", "packer update" },
  }
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +search                          │
  -- ╰──────────────────────────────────────────────────────────╯
  -- search group
  lvim.builtin.which_key.mappings["s"] = {
    name = "+Search",
    [">"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_dotfiles()<cr>", "Search dotfiles" },
    ["b"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_current_buffer()<cr>", "Search buffer" },
    -- ["B"] = { "Search all open buffers" }, -- (grep all open buffers)
    ["C"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_config_files()<cr>", "Search private config" },
    -- ["d"] = { "Search current directory" }, -- grep current dir
    -- ["D"] = { "Search other directory" }, -- browse dirs then grep that dir on <cr>
    ["e"] = { "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_files()<cr>", "Search .local/lunarvim" }, -- grep lunarvim files
    -- ["e"] = { "<cmd>Telescope noice theme=ivy<cr>", "messages & errors" },
    -- <leader>sf - Locate file
    -- ["f"] = { "locate file" },
    -- ["i"] = { "Jump to symbol" },
    ["j"] = { "<cmd>Telescope jumplist theme=ivy<cr>", "Search jumplist" },
    -- ["k"] = { "Look up in local docsets" },
    -- ["K"] = { "Look up in all docsets" },
    -- ["l"] = { "Jump to visible link" }, -- (opens URI on <cr>)
    -- ["L"] = { "Jump to link" }, -- (opens URI on <cr> and jumps to the link in buffer)
    -- ["l"] = { "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_files()<cr>", "lunarvim files" },
    -- ["m"] = { "Jump to bookmark" },
    -- ["n"] = { "<cmd>lua require('user.telescope.custom_pickers').find_notes()<cr>", "notes" },
    -- ["o"] = { "Look up online" }, -- telescope-search?
    -- ["O"] = { "Look up online (w/ prompt)" },
    -- ["p"] = { "<cmd>ProjectMgr<cr>", "project manager" },
    -- ["p"] = { "<cmd>lua require('user.telescope.projects').find_projects()<cr>", "projects" },
    ["p"] = { "<cmd>lua require('user.telescope.custom_pickers').fuzzy_grep_files()<cr>", "Search project" },
    -- ["p"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_files()<cr>", "Search project" },
    -- ["P"] = { "Search other project" }, -- browse projects then grep that project on <cr>
    -- <leader>sr - Jump to mark
    -- ["r"] = { "Jump to mark" },
    -- ["r"] = { "<cmd>Telescope oldfiles theme=ivy<cr>", "recent files" },
    ["s"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_current_buffer()<cr>", "Search buffer" },
    -- ["S"] = { "Search buffer for thing at..." }, -- prefill with word/region under cursor
    -- ["t"] = { "Dictionary" },
    -- ["T"] = { "Thesaurus" },
    -- ["g"] = { "<cmd>lua require('user.telescope.custom_pickers').fuzzy_grep_files()<cr>", "fuzzy grep in project" },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +Windows                         │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["w"] = { "windows" }
  M.set_windows_keymaps()
end

function M.set_legendary_keymaps()
  lvim.builtin.which_key.mappings["s"]["k"] = { "<cmd>Legendary<cr>", "keymaps" }
end

function M.set_trouble_keymaps()
  lvim.builtin.which_key.mappings["l"]["D"] = { "<cmd>Trouble lsp_definitions<cr>", "definitions" }
  lvim.builtin.which_key.mappings["l"]["e"] = { "<cmd>Trouble lsp_references<cr>", "references" }
  lvim.builtin.which_key.mappings["l"]["L"] = { "<cmd>Trouble loclist<cr>", "loclist" }
  lvim.builtin.which_key.mappings["l"]["q"] = { "<cmd>Trouble quicklist<cr>", "quicklist" }
  lvim.builtin.which_key.mappings["l"]["x"] = { "<cmd>Trouble document_diagnostics<cr>", "buffer diagnostics" }
  lvim.builtin.which_key.mappings["l"]["X"] = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace diagnostics" }
end

function M.set_bufjump_keymaps()
  -- jump back and forth between buffers (mirror C-o/C-i for moving in the jumplist)
  vim.keymap.set("n", "<A-o>", "<cmd>lua require('bufjump').backward()<cr>", M.opts_normal)
  vim.keymap.set("n", "<A-i>", "<cmd>lua require('bufjump').forward()<cr>", M.opts_normal)
end

function M.set_cybu_keymaps()
  -- cycle buffers
  vim.keymap.set("n", "<S-h>", "<cmd>CybuPrev<cr>", M.opts_normal)
  vim.keymap.set("n", "<S-l>", "<cmd>CybuNext<cr>", M.opts_normal)
  -- lvim.builtin.which_key.mappings["b"]["n"] = { "<cmd>CybuNext<cr>", "next buffer" }
  -- lvim.builtin.which_key.mappings["b"]["p"] = { "<cmd>CybuPrev<cr>", "previous buffer" }
end

-- TODO: do I need close_buffers_keymaps? I folded all of this into a Buffers hydra.
function M.set_close_buffers_keymaps()
  -- lvim.builtin.which_key.mappings["b"]["a"] = { "<cmd>BDelete all<cr>", "delete all buffers" }
  -- lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>BDelete this<CR>", "delete buffer" }
  -- lvim.builtin.which_key.mappings["b"]["h"] = { "<cmd>BDelete! hidden<cr>", "delete hidden buffers" }
  -- lvim.builtin.which_key.mappings["b"]["o"] = { "<cmd>BDelete! other<CR>", "delete other buffers" }
end

function M.set_fm_keymaps()
  -- lvim.builtin.which_key.mappings["f"] = {
  -- "<cmd>lua require('fm-nvim').Lf(vim.fn.fnameescape(vim.fn.expand '%:p'))<cr>",
  -- "<cmd>Lf %<cr>",
  -- "file manager",
  -- }
end

function M.set_lazygit_keymaps()
  -- lvim.builtin.which_key.mappings["g"]["g"] = { "<cmd>LazyGit<cr>", "lazygit" }
  lvim.builtin.which_key.mappings["g"]["g"] = { "<cmd>FloatermNew lazygit<cr>", "lazygit" }
end

function M.set_marks_keymaps()
  lvim.builtin.which_key.mappings["s"]["m"] = {
    "<cmd>lua require('user.telescope.custom_pickers').marks()<cr>",
    "marks",
  }
end

function M.set_leap_keymaps(multi_cursor_s, multi_cursor_lines)
  lvim.builtin.which_key.mappings["y"] = { multi_cursor_s, "multi cursor" }
  lvim.builtin.which_key.mappings["u"] = { multi_cursor_lines, "multi cursor lines" }
  -- vim.keymap.set("n", "s", leap_all_windows, { silent = true })
  -- vim.keymap.set("v", "s", leap_all_windows, { silent = true })
  -- vim.keymap.set("o", "z", leap_all_windows, { silent = true })
end

function M.set_lsp_buf_keymaps()
  lvim.lsp.buffer_mappings.normal_mode = {
    ["K"] = { vim.lsp.buf.hover, "show hover" },
    ["gd"] = { vim.lsp.buf.definition, "goto definition" },
    ["gD"] = { vim.lsp.buf.declaration, "goto declaration" },
    ["gr"] = { vim.lsp.buf.references, "goto references" },
    ["gI"] = { vim.lsp.buf.implementation, "goto implementation" },
    ["gS"] = { vim.lsp.buf.signature_help, "show signature help" },
  }
end

function M.set_dap_keymaps()
  lvim.builtin.which_key.mappings["d"] = {
    name = "+Debug",
    b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "create breakpoint" },
    B = {
      "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "breakpoint condition",
    },
    c = { "<cmd>lua require('dap').continue()<CR>", "continue" },
    i = { "<cmd>lua require('dap').step_into()<CR>", "step into" },
    m = {
      "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
      "log point message",
    },
    o = { "<cmd>lua require('dap').step_out()<CR>", "step out" },
    r = {
      name = "+Repl",
      o = { "<cmd>lua require('dap').repl.open()<CR>", "open" },
      l = { "<cmd>lua require('dap').repl.run_last()<CR>", "run last" },
    },
    s = { "<cmd>lua require('dap.ui.variables').scopes()<CR>", "scopes" },
    t = { "<cmd>lua require('dapui').toggle()<CR>", "toggle" },
    v = { "<cmd>lua require('dap').step_over()<CR>", "step over" },
    V = {
      name = "+Variables",
      h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "hover" },
      v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "visual hover" },
    },
    w = {
      name = "+Widgets",
      h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "hover" },
      f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "float" },
    },
  }
end

function M.set_comment_box_keymaps()
  lvim.builtin.which_key.mappings["C"]["j"] = { "<cmd>CBlbox<cr>", "Comment left aligned box" }
  lvim.builtin.which_key.mappings["C"]["J"] = { "<cmd>CBalbox<cr>", "Comment adapted left aligned box" }
  lvim.builtin.which_key.mappings["C"]["k"] = { "<cmd>CBcbox<cr>", "Comment centered box" }
  lvim.builtin.which_key.mappings["C"]["K"] = { "<cmd>CBacbox<cr>", "Comment adapted centered box" }
  lvim.builtin.which_key.mappings["C"]["l"] = { "<cmd>CBline<cr>", "Comment left aligned line" }

  lvim.builtin.which_key.vmappings["C"]["j"] = { "<cmd>CBlbox<cr>", "Comment left aligned box" }
  lvim.builtin.which_key.vmappings["C"]["J"] = { "<cmd>CBalbox<cr>", "Comment adapted left aligned box" }
  lvim.builtin.which_key.vmappings["C"]["k"] = { "<cmd>CBcbox<cr>", "Comment centered box" }
  lvim.builtin.which_key.vmappings["C"]["K"] = { "<cmd>CBacbox<cr>", "Comment adapted centered box" }
end

function M.set_harpoon_keymaps()
  -- Harpoon marks
  vim.keymap.set("n", "<A-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", M.opts_normal)
  vim.keymap.set("n", "<A-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", M.opts_normal)
  vim.keymap.set("n", "<A-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", M.opts_normal)
  vim.keymap.set("n", "<A-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", M.opts_normal)
  vim.keymap.set("n", "<A-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", M.opts_normal)
  vim.keymap.set("n", "<A-6>", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", M.opts_normal)

  lvim.builtin.which_key.mappings["h"] = {
    name = "+Harpoon",
    ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "goto file 1" },
    ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "goto file 2" },
    ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "goto file 3" },
    ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "goto file 4" },
    ["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "goto file 5" },
    ["6"] = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "goto file 6" },
    ["a"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "add file mark" },
    ["h"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "show file marks" },
    ["n"] = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "next file" },
    ["p"] = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "previous file" },
  }
end

function M.set_neogen_keymaps()
  lvim.builtin.which_key.mappings["l"]["g"] = { "<cmd>Neogen<cr>", "generate doc" }
end

function M.set_yanky_keymaps(yanky_hydra)
  -- better yank (stays in position after yank)
  -- vim.keymap.set("n", "y", "<Plug>(YankyYank)", { noremap = true })
  -- vim.keymap.set("x", "y", "<Plug>(YankyYank)", { noremap = true })
  lvim.builtin.which_key.mappings["s"]["y"] = { "<cmd>Telescope yank_history theme=ivy<cr>", "yanks" }

  local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  -- choose/change the mappings if you want
  for key, putAction in pairs {
    ["p"] = "<Plug>(YankyPutAfter)",
    ["P"] = "<Plug>(YankyPutBefore)",
    ["gp"] = "<Plug>(YankyGPutAfter)",
    ["gP"] = "<Plug>(YankyGPutBefore)",
  } do
    vim.keymap.set({ "n", "x" }, key, function()
      vim.fn.feedkeys(t(putAction))
      yanky_hydra:activate()
    end)
  end

  -- better pasting in visual mode
  -- lvim.keys.visual_mode["p"] = [["_dP]]
end

function M.set_markdown_preview_keymaps()
  lvim.builtin.which_key.mappings["n"]["p"] = { "<cmd>MarkdownPreview<cr>", "markdown preview" }
end

function M.set_session_lens_keymaps()
  lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>SearchSession<cr>", "sessions" }
end

-- TODO: do I need smart_splits_keymaps? I folded all of this into a Windows hydra.
function M.set_smart_splits_keymaps()
  -- lvim.builtin.which_key.mappings["w"]["J"] = {
  --   "<cmd>lua require('smart-splits').resize_down()<cr>",
  --   "resize window down",
  -- }
  -- lvim.builtin.which_key.mappings["w"]["K"] = { "<cmd>lua require('smart-splits').resize_up()<cr>", "resize window up" }
  -- lvim.builtin.which_key.mappings["w"]["L"] = {
  --   "<cmd>lua require('smart-splits').resize_left()<cr>",
  --   "resize window left",
  -- }
  -- lvim.builtin.which_key.mappings["w"]["r"] = {
  --   "<cmd>lua require('smart-splits').start_resize_mode()<cr>",
  --   "win-resize move",
  -- }
  -- lvim.builtin.which_key.mappings["w"][":"] = {
  --   "<cmd>lua require('smart-splits').resize_right()<cr>",
  --   "resize window right",
  -- }
end

-- TODO: do I need winshift_keymaps? I folded all of this into a Windows hydra.
function M.set_winshift_keymaps()
  -- lvim.builtin.which_key.mappings["w"]["a"] = { "<cmd>WinShift<cr>", "win-move mode" }
  -- lvim.builtin.which_key.mappings["w"]["j"] = { "<cmd>WinShift down<cr>", "switch window down" }
  -- lvim.builtin.which_key.mappings["w"]["k"] = { "<cmd>WinShift up<cr>", "switch window up" }
  -- lvim.builtin.which_key.mappings["w"]["l"] = { "<cmd>WinShift left<cr>", "switch window left" }
  -- lvim.builtin.which_key.mappings["w"]["w"] = { "<cmd>WinShift swap<cr>", "swap window" }
  -- lvim.builtin.which_key.mappings["w"][";"] = { "<cmd>WinShift right<cr>", "switch window right" }
end

function M.set_windex_keymaps()
  -- navigate windows/splits
  -- I have <C-;> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing
  vim.keymap.set("n", "<C-l>", "<cmd>lua require('windex').switch_window('left')<cr>", M.opts_normal)
  vim.keymap.set("n", "<C-j>", "<cmd>lua require('windex').switch_window('down')<cr>", M.opts_normal)
  vim.keymap.set("n", "<C-k>", "<cmd>lua require('windex').switch_window('up')<cr>", M.opts_normal)
  vim.keymap.set("n", "<C-h>", "<cmd>lua require('windex').switch_window('right')<cr>", M.opts_normal)

  -- lvim.builtin.which_key.mappings["w"]["z"] = {
  --   "<cmd>lua require('windex').toggle_maximize()<cr>",
  --   "toggle maximize window",
  -- }
  -- lvim.builtin.which_key.mappings["w"]["S"] = {
  --   "<cmd>lua require('windex').create_pane('horizontal')<cr>",
  --   "split tmux pane",
  -- }
  -- lvim.builtin.which_key.mappings["w"]["V"] = {
  --   "<cmd>lua require('windex').create_pane('vertical')<cr>",
  --   "vsplit tmux pane",
  -- }
end

function M.set_textcase_keymaps()
  lvim.builtin.which_key.mappings["i"] = {
    name = "+Textcase",
    ["u"] = { ":lua require('textcase').current_word('to_upper_case')<CR>", "cur_w uppercase" },
    ["l"] = { ":lua require('textcase').current_word('to_lower_case')<CR>", "cur_w lowercase" },
    ["s"] = { ":lua require('textcase').current_word('to_snake_case')<CR>", "cur_w snake case" },
    ["d"] = { ":lua require('textcase').current_word('to_dash_case')<CR>", "cur_w dash case" },
    ["n"] = { ":lua require('textcase').current_word('to_constant_case')<CR>", "cur_w constant case" },
    ["."] = { ":lua require('textcase').current_word('to_dot_case')<CR>", "cur_w dot case" },
    ["a"] = { ":lua require('textcase').current_word('to_phrase_case')<CR>", "cur_w phrase case" },
    ["c"] = { ":lua require('textcase').current_word('to_camel_case')<CR>", "cur_w camel case" },
    ["p"] = { ":lua require('textcase').current_word('to_pascal_case')<CR>", "cur_w pascal case" },
    ["t"] = { ":lua require('textcase').current_word('to_title_case')<CR>", "cur_w title case" },
    ["f"] = { ":lua require('textcase').current_word('to_path_case')<CR>", "cur_w path case" },

    ["U"] = { ":lua require('textcase').lsp_rename('to_upper_case')<CR>", "lsp uppercase" },
    ["L"] = { ":lua require('textcase').lsp_rename('to_lower_case')<CR>", "lsp lowercase" },
    ["S"] = { ":lua require('textcase').lsp_rename('to_snake_case')<CR>", "lsp snake case" },
    ["D"] = { ":lua require('textcase').lsp_rename('to_dash_case')<CR>", "lsp dash case" },
    ["N"] = { ":lua require('textcase').lsp_rename('to_constant_case')<CR>", "lsp constant case" },
    [">"] = { ":lua require('textcase').lsp_rename('to_dot_case')<CR>", "lsp dot case" },
    ["A"] = { ":lua require('textcase').lsp_rename('to_phrase_case')<CR>", "lsp phrase case" },
    ["C"] = { ":lua require('textcase').lsp_rename('to_camel_case')<CR>", "lsp camel case" },
    ["P"] = { ":lua require('textcase').lsp_rename('to_pascal_case')<CR>", "lsp pascal case" },
    ["T"] = { ":lua require('textcase').lsp_rename('to_title_case')<CR>", "lsp title case" },
    ["F"] = { ":lua require('textcase').lsp_rename('to_path_case')<CR>", "lsp path case" },
  }
  lvim.builtin.which_key.vmappings["i"] = lvim.builtin.which_key.mappings["i"]
end

function M.set_inc_rename_keymaps()
  vim.keymap.set("n", "<leader>cr", function()
    return ":IncRename " .. vim.fn.expand "<cword>"
  end, { expr = true })
  lvim.builtin.which_key.mappings["c"]["r"] = { "Rename symbol" }
end

function M.set_spectre_keymaps()
  lvim.builtin.which_key.mappings["r"] = {
    name = "+Rename",
    ["f"] = { "<cmd>lua require('spectre').open_file_search()<cr>", "replace in file" },
    ["r"] = { "<cmd>lua require('spectre').open()<cr>", "replace in workspace" },
    ["w"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "replace word" },
  }
end

function M.set_asynctasks_keymaps()
  lvim.builtin.which_key.mappings["a"] = {
    name = "+Tasks",
    ["a"] = { ":AsyncTask<space>", "async task", silent = false },
    ["e"] = { "<cmd>AsyncTaskEdit<cr>", "edit task file" },
    ["l"] = { "<cmd>AsyncTaskLast<cr>", "run last task" },
    ["L"] = { "<cmd>AsyncTaskList", "show tasks" },
    ["m"] = { "<cmd>AsyncTaskMacro<cr>", "display task macros" },
    ["p"] = { ":AsyncTaskProfile<space>", "change task profile", silent = false },
    ["r"] = { "<cmd>Telescope asynctasks all theme=ivy<cr>", "run task" },
  }
end

function M.set_vim_test_keymaps()
  lvim.builtin.which_key.mappings["t"] = {
    name = "+Test",
    ["f"] = { "<cmd>TestFile<cr>", "run tests in file" },
    ["l"] = { "<cmd>TestLast<cr>", "run last test" },
    ["n"] = { "<cmd>TestNearest<cr>", "run nearest test" },
    ["s"] = { "<cmd>TestSuite<cr>", "run test suite" },
    ["v"] = { "<cmd>TestVisit<cr>", "visit last test file" },
  }
end

function M.set_qf_helper_keymaps()
  lvim.builtin.which_key.mappings["o"] = {
    name = "+Open",
    ["q"] = { "<cmd>QFToggle<cr>", "toggle quickfix" },
    ["l"] = { "<cmd>LLToggle<cr>", "toggle loclist" },
    -- ["t"] = { "toggle filetree" },
  }
end

function M.set_dbui_keymaps()
  lvim.builtin.which_key.mappings["e"] = { name = "+Databases" }
  lvim.builtin.which_key.mappings["e"]["a"] = { ":DBUIAddConnection<space>", "add database connection", silent = false }
  lvim.builtin.which_key.mappings["e"]["e"] = { "<Plug>(DBUI_EditBindParameters)", "dbui edit bind parameters" }
  lvim.builtin.which_key.mappings["e"]["f"] = { "<cmd>DBUIFindBuffer<cr>", "find/assign buffer database" }
  lvim.builtin.which_key.mappings["e"]["l"] = { ":DBUILastQueryInfo<cr>", "last query info" }
  lvim.builtin.which_key.mappings["e"]["r"] = { "<cmd>DBUIRenameBuffer<cr>", "rename buffer database" }
  lvim.builtin.which_key.mappings["e"]["R"] = { "<Plug>(DBUI_ToggleResultLayout)", "dbui expanded results view" }
  lvim.builtin.which_key.mappings["e"]["s"] = { "<Plug>(DBUI_ExecuteQuery)", "dbui execute query" }
  lvim.builtin.which_key.mappings["e"]["t"] = { "<cmd>DBUIToggle<cr>", "toggle dbui" }
end

function M.set_lspsaga_keymaps()
  lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>Lspsaga code_action<cr>", "code actions" }
  lvim.builtin.which_key.mappings["l"]["p"] = { "<cmd>Lspsaga peek_definition<cr>", "peek definition" }
  lvim.builtin.which_key.mappings["l"]["h"] = { "<cmd>Lspsaga lsp_finder<cr>", "definitions & references" }
  lvim.builtin.which_key.mappings["l"]["j"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "next diagnostic" }
  lvim.builtin.which_key.mappings["l"]["k"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "prev diagnostic" }
  lvim.builtin.which_key.mappings["l"]["l"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", "show line diagnostics" }
  vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<cr>", M.opts_normal)
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<cr>", M.opts_normal)
  vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", M.opts_normal)
  vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", M.opts_normal)
  vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", M.opts_normal)
end

function M.set_grapple_keymaps()
  lvim.builtin.which_key.mappings["m"] = { "<cmd>lua require('grapple').toggle()<cr>", "toggle file tag" }
end

function M.set_portal_keymaps()
  lvim.builtin.which_key.mappings["o"] = { "<cmd>lua require('portal').jump_backward({query = {'tagged'}})<cr>", "jump back tags" }
  lvim.builtin.which_key.mappings["i"] = { "<cmd>lua require('portal').jump_forward({query = {'tagged'}})<cr>", "jump forward tags" }

  vim.keymap.set("n", "<C-o>", "<cmd>lua require('portal').jump_backward({query = {'different', 'valid'}})<cr>", {})
  vim.keymap.set("n", "<C-i>", "<cmd>lua require('portal').jump_forward({query = {'different', 'valid'}})<cr>", {})

  vim.keymap.set("n", "<A-o>", "<cmd>lua require('portal').jump_backward({query = {'different'}})<cr>", {})
  vim.keymap.set("n", "<A-i>", "<cmd>lua require('portal').jump_forward({query = {'different'}})<cr>", {})
end

function M.set_dial_keymaps()
  -- Increment and decrement
  -- TODO: use lvim which_key mappings instead, need noremap=true
  vim.api.nvim_set_keymap("n", "<A-;>", require("dial.map").inc_normal(), { noremap = true })
  vim.api.nvim_set_keymap("n", "<A-l>", require("dial.map").dec_normal(), { noremap = true })
  vim.api.nvim_set_keymap("v", "<A-;>", require("dial.map").inc_visual(), { noremap = true })
  vim.api.nvim_set_keymap("v", "<A-l>", require("dial.map").dec_visual(), { noremap = true })
  vim.api.nvim_set_keymap("v", "g<A-;>", require("dial.map").inc_gvisual(), { noremap = true })
  vim.api.nvim_set_keymap("v", "g<A-l>", require("dial.map").dec_gvisual(), { noremap = true })
end

function M.set_package_info_keymaps()
  import({ "hydra", "which-key" }, function(modules)
    local hydra = modules.hydra
    local which_key = modules.which_key

    hydra {
      name = "package-info",
      hint = [[
 _t_: toggle versions      _s_: show versions       _c_: hide versions
 ^
 _i_: install dependency   _u_: update dependency   _d_: delete dependency
 ^
 _p_: change dependency version                   ^^_q_, _<Esc>_: quit
    ]],
      config = {
        invoke_on_body = true,
        color = "pink", -- exit yanky mode if foreign keys are pressed
        hint = {
          type = "window", -- one of "statusline", "cmdline", "window"
          position = "bottom", -- only applies for type = "window"
          border = "rounded", -- only applies for type = "window"
        },
      },
      body = "<leader>mp",
      heads = {
        -- show dependency versions.
        { "s", "<cmd>lua require('package-info').show()<cr>", {} },
        -- hide dependency versions.
        { "c", "<cmd>lua require('package-info').hide()<cr>", {} },
        -- toggle dependency versions.
        { "t", "<cmd>lua require('package-info').toggle()<cr>", {} },
        -- update dependency on line.
        { "u", "<cmd>lua require('package-info').update()<cr>", {} },
        -- delete dependency on line.
        { "d", "<cmd>lua require('package-info').delete()<cr>", {} },
        -- install new dependency.
        { "i", "<cmd>lua require('package-info').install()<cr>", {} },
        -- install different dependency version.
        { "p", "<cmd>lua require('package-info').change_version()<cr>", {} },
        { "q", nil, { exit = true, nowait = true, desc = "quit" } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = "quit" } },
      },
    }

    local opts = lvim.builtin.which_key.opts
    local mappings = {
      ["m"] = {
        name = "Mode",
        ["p"] = { "package-info" },
      },
    }
    which_key.register(mappings, opts)
  end)
end

function M.set_gitsigns_keymaps()
  import({ "gitsigns", "hydra" }, function(modules)
    local gs = modules.gitsigns
    local hydra = modules.hydra

    hydra {
      name = "Git",
      hint = [[
 Stage/unstage hunks
 _s_: Stage hunk    _r_: Reset hunk         _S_: Stage buffer   _U_: Undo last stage
 ^
 Navigation
 _a_: All hunks     _n_, _gn_: Next hunk    _N_, _gN_: Prev hunk
 ^
 _=_: Preview hunk  _d_: Show deleted       _b_: Blame line
 ^
 _C_: Commit
 ^
 _q_, _<Esc>_: Quit
    ]],
      body = "<leader>gs",
      config = {
        invoke_on_body = true,
        color = "pink", -- let me press other keys _without_ exiting git mode
        hint = {
          type = "window", -- one of "statusline", "cmdline", "window"
          position = "bottom-right", -- only applies for type = "window"
          border = "rounded", -- only applies for type = "window"
        },

        on_enter = function()
          gs.toggle_signs(true)
          gs.toggle_deleted(true) -- show deleted lines
          gs.toggle_linehl(true) -- light up changed lines
          gs.toggle_word_diff(true) -- highlight changed words
          gs.setqflist("all", { open = false }) -- all hunks in qf, but don't open qf list
        end,
        on_exit = function()
          gs.toggle_deleted(false)
          gs.toggle_linehl(false)
          gs.toggle_word_diff(false)
          vim.cmd "echo" -- clear the echo area
        end,
      },
      mode = { "n", "x" },
      heads = {
        { "gn", ":cn<CR>", { silent = true, desc = "next hunk" } },
        { "gN", ":cp<CR>", { silent = true, desc = "prev hunk" } },
        { "n", gs.next_hunk, { desc = "next hunk" } },
        { "N", gs.prev_hunk, { desc = "prev hunk" } },
        {
          "a",
          function()
            gs.setqflist("all", { open = true })
          end,
          { desc = "set qflist" },
        },
        { "s", gs.stage_hunk, { desc = "stage hunk" } },
        { "U", gs.undo_stage_hunk, { desc = "undo stage" } },
        { "r", gs.reset_hunk, { desc = "reset hunk" } },
        { "S", gs.stage_buffer, { desc = "stage buffer" } },
        { "=", gs.preview_hunk, { desc = "preview hunk" } },
        { "b", gs.blame_line, { desc = "blame line" } },
        { "d", gs.toggle_deleted, { nowait = true, desc = "show deleted lines" } },
        -- TODO: send this to lazygit commit instead (with commitizen maybe)
        { "C", ":tab Git commit<CR>", { silent = true, exit = true, desc = "commit changes" } },
        { "q", nil, { exit = true, nowait = true, desc = "quit" } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = "quit" } },
      },
    }
  end)
end

function M.set_buffers_keymaps()
  import("hydra", function(hydra)
    hydra {
      name = "Buffers",
      hint = [[
 ^^   Delete            ^^   Cycle
 ^^------------         ^^------------
 _d_ : this buffer      _n_ : next buffer
 _a_ : all buffers      _N_ : previous buffer
 _h_ : hidden buffers
 _o_ : other buffers
 ^
 _s_ : save buffer     _c_ : clear session
 _b_ : buffer picker   _q_, _<Esc>_: quit
 ]],
      config = {
        invoke_on_body = true,
        hint = {
          type = "window", -- one of "statusline", "cmdline", "window"
          position = "bottom", -- only applies for type = "window"
          border = "rounded", -- only applies for type = "window"
        },
      },
      body = "<leader>b",
      mode = "n",
      heads = {
        {
          "b",
          "<cmd>lua require('user.telescope.custom_pickers').switch_buffers()<cr>",
          { desc = "switch buffers", exit = true },
        },
        { "c", "<cmd>Clear<cr>", { desc = "clear session", exit = true } },
        { "s", "<cmd>up!<cr>", { desc = "save buffer", exit = true } },
        { "n", "<cmd>CybuNext<cr>", { desc = "next buffer" } },
        { "N", "<cmd>CybuPrev<cr>", { desc = "previous buffer" } },
        { "a", "<cmd>BDelete all<cr>", { desc = "delete all buffers", exit = true } },
        { "d", "<cmd>BDelete this<cr>", { desc = "delete buffer", exit = true } },
        { "h", "<cmd>BDelete! hidden<cr>", { desc = "delete hidden buffers" } },
        { "o", "<cmd>BDelete! other<cr>", { desc = "delete other buffers" } },
        --{ "w",  "", "save all buffers" },
        --{ "x", "", "scratch buffer" },
        { "<Space>", "<cmd>lua require('which-key').show(' ')<cr>", { desc = false, exit = true } },
        { "<Esc>", nil, { exit = true } },
        { "q", nil, { exit = true } },
      },
    }
  end)
end

function M.set_windows_keymaps()
  import("hydra", function(hydra)
    hydra {
      hint = [[
 ^^^^^^     Move    ^^^^^^    ^^     Split         ^^  Tmux Split
 ^^^^^^-------------^^^^^^    ^^---------------    ^^-------------
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _S_ : horizontally
 _l_ ^ ^ _;_   _L_ ^ ^ _:_    _v_: vertically      _V_ : vertically
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    _d_: delete
 focus^^^^^^   window^^^^   ^^_o_: delete others
      ^^^^^^         ^^^^   ^^_z_: zoom
 ^
 ^^^^^^    Modes    ^^^^^^
 ^^^^^^-------------^^^^^^
 _a_: window move
 _r_: window resize^^^^^^^    _q_, _<Esc>_ : quit
]],
      config = {
        invoke_on_body = true,
        hint = {
          type = "window", -- one of "statusline", "cmdline", "window"
          position = "bottom", -- only applies for type = "window"
          border = "rounded",
        },
      },
      mode = "n",
      body = "<leader>w",
      heads = {
        -- Move focus
        { "l", "<cmd>lua require('windex').switch_window('left')<cr>" },
        { "j", "<cmd>lua require('windex').switch_window('down')<cr>" },
        { "k", "<cmd>lua require('windex').switch_window('up')<cr>" },
        { ";", "<cmd>lua require('windex').switch_window('right')<cr>" },
        -- Move window
        { "a", "<cmd>WinShift<cr>", { desc = "win-move mode", exit = true } },
        { "L", "<cmd>WinShift left<CR>" },
        { "J", "<cmd>WinShift down<CR>" },
        { "K", "<cmd>WinShift up<CR>" },
        { ":", "<cmd>WinShift right<CR>" },
        -- Split
        { "s", "<cmd>split<cr>" },
        { "v", "<cmd>vsplit<cr>" },
        { "S", "<cmd>lua require('windex').create_pane('horizontal')<cr>" },
        { "V", "<cmd>lua require('windex').create_pane('vertical')<cr>" },
        { "d", "<cmd>try | close | catch | endtry<CR>", { desc = "delete window" } },
        { "o", "<cmd>try | only | catch | endtry<CR>", { desc = "delete other windows" } },
        -- Size
        { "r", "<cmd>lua require('smart-splits').start_resize_mode()<cr>", { desc = "win-resize mode", exit = true } },
        { "z", "<cmd>lua require('windex').toggle_maximize()<cr>", { exit = true } },
        -- { "<C-j>", "<cmd>lua require('smart-splits').resize_down()<cr>" },
        -- { "<C-k>", "<cmd>lua require('smart-splits').resize_up()<cr>" },
        -- { "<C-l>", "<cmd>lua require('smart-splits').resize_left()<cr>" },
        -- { "<C-;>", "<cmd>lua require('smart-splits').resize_right()<cr>" },
        -- { "=", "<C-w>=", { desc = "equalize" } },
        { "<Space>", "<cmd>lua require('which-key').show(' ')<cr>", { desc = false, exit = true } },
        { "<Esc>", nil, { exit = true } },
        { "q", nil, { exit = true } },
      },
    }
  end)
end

function M.set_typescript_keymaps()
  import("which-key", function(which_key)
    local opts = lvim.builtin.which_key.opts
    local mappings = {
      ["m"] = {
        name = "Mode",
        -- ["p"] = { "package-info" },
        ["i"] = { "<cmd>TypescriptAddMissingImports<cr>", "add missing typescript imports" },
        ["o"] = { "<cmd>TypescriptOrganizeImports<cr>", "organize typescript imports" },
        ["u"] = { "<cmd>TypescriptRemoveUnused<cr>", "remove unused typescript variables" },
        ["f"] = { "<cmd>TypescriptFixAll<cr>", "fix all typescript issues" },
        ["r"] = { "<cmd>TypescriptRenameFile<cr>", "rename typescript file" },
        ["d"] = { "<cmd>TypescriptGoToSourceDefinition<cr>", "go to source definition" },
      },
    }
    which_key.register(mappings, opts)
  end)
end

function M.set_ufo_keymaps()
  -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  lvim.keys.normal_mode["zR"] = { "<cmd>require('ufo').openAllFolds()<cr>", "open all folds" }
  lvim.keys.normal_mode["zM"] = { "<cmd>require('ufo').closeAllFolds()<cr>", "close all folds" }
  lvim.keys.normal_mode["zr"] = { "<cmd>require('ufo').openFoldsExceptKinds()<cr>", "open folds" }
  lvim.keys.normal_mode["zm"] = { "<cmd>require('ufo').closeFoldsWith()<cr>", "close folds" }
end

return M

--[[

+buffer group
<leader>b- - Toggle narrowing
<leader>b[ - Previous buffer
<leader>b] - Next buffer
<leader>bb - Switch workspace buffer
<leader>bB - Switch buffer
<leader>bc - Clone buffer
<leader>bC - Clone buffer other window
<leader>bd - Kill buffer
<leader>bi - ibuffer
<leader>bI - ibuffer workspace
<leader>bk - Kill buffer
<leader>bK - Kill all buffers
<leader>bl - l Switch to last buffer
<leader>bm - Set bookmark
<leader>bM - Delete bookmark
<leader>bn - Next buffer
<leader>bN - New empty buffer
<leader>bO - Kill other buffers
<leader>bp - Previous buffer
<leader>br - Revert buffer
<leader>bR - Rename buffer
<leader>bs - Save buffer
<leader>bS - Save all buffers
<leader>bu - Save buffer as root
<leader>bx - Pop up scratch buffer
<leader>bX - Switch to scratch buffer
<leader>by - Yank buffer
<leader>bz - Bury buffer
<leader>bZ - Kill buried buffers

git group
<leader>g' - Forge dispatch
<leader>g. - Magit file dispatch
<leader>g/ - Magit dispatch
<leader>g[ - Jump to previous hunk
<leader>g] - Jump to next hunk
<leader>gb - Magit switch branch
<leader>gB - Magit blame
<leader>gc - git create group
  <leader>gcb - git create branch
  <leader>gcc - git create commit
  <leader>gcf - git create fixup
  <leader>gci - git create issue
  <leader>gcp - git create pull request
  <leader>gcr - git initialize repo
  <leader>gcR - git clone repo
<leader>gC - Magit clone
<leader>gD - Magit file delete
<leader>gf - git find group
  <leader>gfc - git find commit
  <leader>gff - git find file
  <leader>gfg - find gitconfig file
  <leader>gfi - git find issue
  <leader>gfp - git find pull request
<leader>gF - Magit fetch
<leader>gg - Magit status
<leader>gG - Magit status here
<leader>gl - git list group
  <leader>gli - git list issues
  <leader>gln - git list notifications
  <leader>glp - git list pull requests
  <leader>glr - git list repositories
  <leader>gls - git list submodules
<leader>gL - Magit buffer log
<leader>gm - SMerge
<leader>go - open in browser group
  <leader>goc - git browse commit
  <leader>goh - git browse homepage
  <leader>goi - git browse an issue
  <leader>goI - git browse issues
  <leader>goo - git browse file or region
  <leader>gop - git browse a pull request
  <leader>goP - git browse pull requests
  <leader>gor - git browse remote
<leader>gr - Revert hunk at point
<leader>gR - Revert file
<leader>gs - Stage hunk at point
<leader>gS - Git stage file
<leader>gt - Git time machine
<leader>gU - Git unstage file
<leader>gy - Copy link to remote
<leader>gY - Copy link to homepage

insert group
<leader>ie - Insert emoji
<leader>if - Insert current file name
<leader>iF - Insert current file path
<leader>ip - Insert evil ex path ???
<leader>ir - Insert from evil register
<leader>is - Insert snippet (telescope-luasnip)
<leader>iu - Insert unicode
<leader>iy - Insert from clipboard (yanky history)

notes group
<leader>n* - Search notes for symbol
<leader>na - Org agenda
<leader>nc - Toggle last org-clock
<leader>nC - Cancel org-clock
<leader>nd - Open deft
<leader>nf - Find file in notes (find file)
<leader>nF - Browse notes (on <cr> of a dir, open in dired)
<leader>nl - Org store link
<leader>nm - Tags search
<leader>nn - Org capture
<leader>nN - Goto capture
<leader>no - Active org-clock
<leader>ns - Search notes (grep)
<leader>nS - Search org agenda headlines
<leader>nt - Todo list
<leader>nv - View search
<leader>ny - Org export to clipboard
<leader>nY - Org export to clipboard as...

open group
<leader>o- - Dired
<leader>oa - org agenda group
<leader>oA - Org agenda
<leader>ob - Default browser
<leader>od - Start debugger
<leader>of - New frame
<leader>oF - Select frame
<leader>or - Repl
<leader>or - Repl (same window)

quit/session group
<leader>qd - Restart emacs server
<leader>qf - Delete frame
<leader>qF - Clear current frame
<leader>qK - Kill Neovim (and daemon)
<leader>ql - Restore last session
<leader>qL - Restore session from file
<leader>qq - Quit Neovim
<leader>qQ - Quit Neovim without saving
<leader>qr - Restart & restore Neovim
<leader>qR - Restart Neovim
<leader>qs - Quick save current session
<leader>qS - Save session to file

toggle group
<leader>tb - Big mode
<leader>tc - Fill Column Indicator
<leader>tf - Flycheck
<leader>tF - Frame fullscreen
<leader>tg - Evil goggles
<leader>tI - Indent style
<leader>tl - Line numbers
<leader>tr - Read-only mode
<leader>tv - Visible mode
<leader>tw - Soft-line wrapping

window group
]]
