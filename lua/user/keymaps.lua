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
  -- I use jkl; instead of hjkl
  lvim.keys.normal_mode[";"] = "l"
  lvim.keys.normal_mode["l"] = "h"

  -- since I don't use h to move cursor, might as well use it to enter command mode
  lvim.keys.normal_mode["h"] = ":"

  -- keep cursor centered when using n(next) and N(previous)
  lvim.keys.normal_mode["n"] = "nzzzv"
  lvim.keys.normal_mode["N"] = "Nzzzv"

  -- keep cursor centered and in-place when joining lines with J
  lvim.keys.normal_mode["J"] = "mzJ`z"

  -- open URI under cursor, otherwise default to O
  lvim.keys.normal_mode["O"] = ":OpenURIUnderCursor<cr>"

  -- Increment and decrement
  lvim.keys.normal_mode["<A-;>"] = "<C-a>"
  lvim.keys.normal_mode["<A-l>"] = "<C-x>"

  -- move current line up/down
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<A-k>"] = ":m .-2<cr>=="

  -- toggleterm maps
  lvim.keys.normal_mode["<A-a>"] = "<cmd>lua require('user.plugins.toggleterm').toggle_term2()<cr>"
  lvim.keys.normal_mode["<A-s>"] = "<cmd>lua require('user.plugins.toggleterm').toggle_term3()<cr>"
  -- lvim.keys.normal_mode["<A-d>"] = ""
  -- lvim.keys.normal_mode["<A-f>"] = ""
  -- lvim.keys.normal_mode["<A-g>"] = ""

  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to Shift+Left and Cmd+Right mapped to Shift+Right)
  lvim.keys.normal_mode["<S-Left>"] = "_"
  lvim.keys.normal_mode["<S-Right>"] = "$"

  -- no highlight on esc
  lvim.keys.normal_mode["<Esc>"] = "<cmd>nohlsearch<cr>"

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                          Visual                          │
  -- ╰──────────────────────────────────────────────────────────╯

  -- I use jkl; instead of hjkl
  lvim.keys.visual_mode[";"] = "l"
  lvim.keys.visual_mode["l"] = "h"

  -- Move visual selection up/down
  lvim.keys.visual_mode["<A-j>"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<A-k>"] = ":m '<-2<cr>gv=gv"

  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to Shift+Left and Cmd+Right mapped to Shift+Right)
  lvim.keys.visual_mode["<S-Left>"] = "_"
  lvim.keys.visual_mode["<S-Right>"] = "$"

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                          Insert                          │
  -- ╰──────────────────────────────────────────────────────────╯

  -- Undo break points (for a finer-grained undo command)
  lvim.keys.insert_mode[","] = ",<c-g>u"
  lvim.keys.insert_mode["."] = ".<c-g>u"
  lvim.keys.insert_mode["!"] = "!<c-g>u"
  lvim.keys.insert_mode["?"] = "?<c-g>u"
  lvim.keys.insert_mode["<cr>"] = "<cr><c-g>u"
  lvim.keys.insert_mode["<space>"] = "<space><c-g>u"

  -- Fix previous spelling mistake
  lvim.keys.insert_mode["<A-h>"] = "<c-g>u<Esc>[s1z=`]a<c-g>u"

  -- A-del is mapped to delete previous word on my keyboard (macos), make that consistent inside nvim
  lvim.keys.insert_mode["<A-bs>"] = "<c-w>"

  -- select all
  lvim.keys.insert_mode["<A-a>"] = "<ESC>ggVG<CR>"

  -- ergonmic mappings for end of line and beginning of line my terminal has Cmd+Left mapped to S4 and Cmd+Right mapped to 12
  lvim.keys.insert_mode["<S-Left>"] = "<Esc>_i"
  lvim.keys.insert_mode["<S-Right>"] = "<Esc>$a"

  -- A-del is mapped to delete previous word on my keyboard (macos), make that consistent inside nvim
  lvim.keys.insert_mode["<A-bs>"] = "<c-w>"

  -- emacs-like maps for insert mode
  -- lvim.keys.insert_mode["<C-a>"] = "<esc>I"
  -- lvim.keys.insert_mode["<C-e>"] = "<esc>A"
  -- lvim.keys.insert_mode["<C-f>"] = "<Right>"
  -- lvim.keys.insert_mode["<C-b>"] = "<Left>"

  -- unmap a default keymapping
  -- lvim.keys.normal_mode["<C-Up>"] = false

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Telescope                         │
  -- ╰──────────────────────────────────────────────────────────╯
  -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
  -- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
  local _, actions = pcall(require, "telescope.actions")
  lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         Whichkey                         │
  -- ╰──────────────────────────────────────────────────────────╯

  -- lvim.builtin.which_key.mappings["a"] = { "<cmd>up!<cr>", "write buffer" }
  lvim.builtin.which_key.mappings["c"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["e"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["i"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["j"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["k"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["m"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["o"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["q"] = { "<cmd>lua require('user.usercmd').smart_quit()<cr>", "quit" }
  lvim.builtin.which_key.mappings["r"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["u"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["v"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["x"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["y"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["z"] = "which_key_ignore"
  lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<cr>", "dashboard" }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +Buffers                         │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["b"] = {
    name = "+Buffers",
    ["b"] = { "<cmd>lua require('user.telescope.custom_pickers').switch_buffers()<cr>", "switch buffers" },
    ["c"] = { "<cmd>Clear<cr>", "clear session" },
    ["s"] = { "<cmd>up!<cr>", "save buffer" },
    -- ["w"] = { "", "save all buffers" },
    -- ["x"] = { "", "scratch buffer" },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +Comment                         │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["/"] = {
    "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>",
    "comment line",
  }
  lvim.builtin.which_key.mappings["c"] = {
    name = "+Comment",
    ["a"] = { "<cmd>lua require('Comment.api').insert_linewise_eol()<cr>", "comment end of line" },
    ["b"] = { "<cmd>lua require('Comment.api').toggle_current_blockwise()<cr>", "comment block" },
    ["c"] = {
      "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>",
      "comment line",
    },
    ["o"] = { "<cmd>lua require('Comment.api').insert_linewise_below()<cr>", "comment below" },
    ["O"] = { "<cmd>lua require('Comment.api').insert_linewise_above()<cr>", "comment above" },
  }

  lvim.builtin.which_key.vmappings["/"] = {
    "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
    "comment line",
  }
  lvim.builtin.which_key.vmappings["c"] = {
    name = "+Comment",
    ["c"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "comment line" },
    ["b"] = { "<ESC><CMD>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<cr>", "comment block" },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                           +Git                           │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["g"] = {
    name = "+Git",
    b = { "<cmd>Telescope git_branches<cr>", "checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "checkout commit (for current file)" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "git diff" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "blame" },
    o = { "<cmd>Telescope git_status<cr>", "open changed file" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "preview hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "reset hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "reset buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "stage hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "undo stage hunk" },
    h = {
      name = "+Github",
      c = {
        name = "+Commits",
        c = { "<cmd>GHCloseCommit<cr>", "close commit" },
        e = { "<cmd>GHExpandCommit<cr>", "expand commit" },
        o = { "<cmd>GHOpenToCommit<cr>", "open to commit" },
        p = { "<cmd>GHPopOutCommit<cr>", "pop out commit" },
        z = { "<cmd>GHCollapseCommit<cr>", "collapse commit" },
      },
      i = {
        name = "+Issues",
        p = { "<cmd>GHPreviewIssue<cr>", "preview issue" },
      },
      l = {
        name = "+Litee",
        t = { "<cmd>LTPanel<cr>", "toggle litee panel" },
      },
      r = {
        name = "+Review",
        b = { "<cmd>GHStartReview<cr>", "begin review" },
        c = { "<cmd>GHCloseReview<cr>", "close review" },
        d = { "<cmd>GHDeleteReview<cr>", "delete review" },
        e = { "<cmd>GHExpandReview<cr>", "expand review" },
        s = { "<cmd>GHSubmitReview<cr>", "submit review" },
        z = { "<cmd>GHCollapseReview<cr>", "collapse review" },
      },
      p = {
        name = "+Pull Request",
        c = { "<cmd>GHClosePR<cr>", "close pr" },
        d = { "<cmd>GHPRDetails<cr>", "pr details" },
        e = { "<cmd>GHExpandPR<cr>", "expand pr" },
        o = { "<cmd>GHOpenPR<cr>", "open pr" },
        p = { "<cmd>GHPopOutPR<cr>", "pop out pr" },
        r = { "<cmd>GHRefreshPR<cr>", "refresh pr" },
        t = { "<cmd>GHOpenToPR<cr>", "open to pr" },
        z = { "<cmd>GHCollapsePR<cr>", "collapse pr" },
      },
      t = {
        name = "+Threads",
        c = { "<cmd>GHCreateThread<cr>", "create thread" },
        n = { "<cmd>GHNextThread<cr>", "next thread" },
        t = { "<cmd>GHToggleThread<cr>", "toggle thread" },
      },
    },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                           +LSP                           │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["l"] = {
    name = "+LSP",
    -- ["A"] = { vim.lsp.codelens.run, "codelens action" },
    -- ["b"] = { "", "" },
    -- ["c"] = { "", "compile" },
    -- ["e"] = { "", "evaluate" },
    ["f"] = { require("lvim.lsp.utils").format, "format" },
    -- ["h"] = { "", "" },
    ["i"] = { "<cmd>LspInfo", "lsp info" },
    ["I"] = { "<cmd>LspInstallInfo", "lsp install info" },
    ["j"] = { vim.diagnostic.goto_next, "next diagnostic" },
    ["k"] = { vim.diagnostic.goto_prev, "prev diagnostic" },
    -- ["o"] = { "", "organize imports" },
    ["p"] = {
      name = "+peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "peek definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "peek type definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "peek implementation" },
    },
    -- ["r"] = { "<cmd>LspRename<cr>", "rename" },
    -- ["s"] = { "", "symbols" },
    ["t"] = { "<cmd>TodoTrouble<cr>", "todos" },
    -- ["w"] = { "", "del trailing whitespace" },
    -- ["W"] = { "", "del trailing newlines" },
    -- ["y"] = { "", "call hierarchy" },
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

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +Search                          │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["s"] = {
    name = "+Search",
    ["."] = { "<cmd>lua require('user.telescope.custom_pickers').find_dotfiles()<cr>", "dotfiles" },
    [">"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_dotfiles()<cr>", "grep in dotfiles" },
    ["b"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_current_buffer()<cr>", "grep in buffer" },
    ["c"] = {
      "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_config_files()<cr>",
      "lunarvim config files",
    },
    ["C"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_config_files()<cr>", "grep in config files" },
    -- ["d"] = { "", "files in directory" },
    ["f"] = { "<cmd>lua require('user.telescope.custom_pickers').find_files()<cr>", "files in project" },
    ["l"] = { "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_files()<cr>", "lunarvim files" },
    ["n"] = { "<cmd>lua require('user.telescope.custom_pickers').find_notes()<cr>", "notes" },
    -- ["o"] = { "", "look up online" },
    ["p"] = { "<cmd>lua require('user.telescope.projects').find_projects()<cr>", "projects" },
    ["r"] = { "<cmd>Telescope oldfiles theme=ivy<cr>", "recent files" },
    -- ["t"] = { "", "dictionary" },
    -- ["T"] = { "", "thesaurus" },
    ["g"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_files()<cr>", "grep in project" },
  }

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         +Windows                         │
  -- ╰──────────────────────────────────────────────────────────╯
  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    ["d"] = { "<cmd>close<cr>", "delete window" },
    ["o"] = { "<cmd>only<cr>", "delete other windows" },
    ["s"] = { "<cmd>split<CR>", "split window" },
    ["v"] = { "<cmd>vsplit<cr>", "vsplit window" },
  }
end

function M.set_legendary_keymaps()
  lvim.builtin.which_key.mappings["s"]["k"] = { "<cmd>Legendary<cr>", "keymaps" }
end

function M.set_trouble_keymaps()
  lvim.builtin.which_key.mappings["l"]["d"] = { "<cmd>Trouble lsp_definitions<cr>", "definitions" }
  lvim.builtin.which_key.mappings["l"]["D"] = { "<cmd>Trouble lsp_references<cr>", "references" }
  lvim.builtin.which_key.mappings["l"]["l"] = { "<cmd>Trouble loclist<cr>", "loclist" }
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
  lvim.builtin.which_key.mappings["b"]["n"] = { "<cmd>CybuNext<cr>", "next buffer" }
  lvim.builtin.which_key.mappings["b"]["p"] = { "<cmd>CybuPrev<cr>", "previous buffer" }
end

function M.set_close_buffers_keymaps()
  lvim.builtin.which_key.mappings["b"]["a"] = { "<cmd>BDelete all<cr>", "delete all buffers" }
  lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>BDelete this<CR>", "delete buffer" }
  lvim.builtin.which_key.mappings["b"]["h"] = { "<cmd>BDelete! hidden<cr>", "delete hidden buffers" }
  lvim.builtin.which_key.mappings["b"]["o"] = { "<cmd>BDelete! other<CR>", "delete other buffers" }
end

function M.set_fm_keymaps()
  lvim.builtin.which_key.mappings["f"] = {
    -- "<cmd>lua require('fm-nvim').Lf(vim.fn.fnameescape(vim.fn.expand '%:p'))<cr>",
    "<cmd>Lf %<cr>",
    "file manager",
  }
end

function M.set_lazygit_keymaps()
  lvim.builtin.which_key.mappings["g"]["g"] = { "<cmd>LazyGit<cr>", "lazygit" }
end

function M.set_marks_keymaps()
  lvim.builtin.which_key.mappings["s"]["m"] = {
    "<cmd>lua require('user.telescope.custom_pickers').marks()<cr>",
    "marks",
  }
end

function M.set_surround_keymaps()
  -- Make special mapping for "add surrounding for line"
  vim.api.nvim_set_keymap("n", "gss", "gs_", { noremap = false })
  -- Remap adding surrounding to Visual mode selection
  vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
end

function M.set_code_action_menu_keymaps()
  lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>CodeActionMenu<cr>", "code actions" }
end

function M.set_leap_keymaps()
  vim.keymap.set("n", "s", leap_all_windows, { silent = true })
  vim.keymap.set("v", "s", leap_all_windows, { silent = true })
  vim.keymap.set("o", "z", leap_all_windows, { silent = true })
end

function M.set_lsp_buf_keymaps()
  lvim.lsp.buffer_mappings.normal_mode = {
    ["K"] = { vim.lsp.buf.hover, "show hover" },
    ["gd"] = { vim.lsp.buf.definition, "goto definition" },
    ["gD"] = { vim.lsp.buf.declaration, "goto declaration" },
    ["gr"] = { vim.lsp.buf.references, "goto references" },
    ["gI"] = { vim.lsp.buf.implementation, "goto implementation" },
    ["gS"] = { vim.lsp.buf.signature_help, "show signature help" },
    ["gp"] = {
      function()
        require("lvim.lsp.peek").Peek "definition"
      end,
      "peek definition",
    },
    ["gl"] = {
      function()
        local config = lvim.lsp.diagnostics.float
        config.scope = "line"
        vim.diagnostic.open_float(0, config)
      end,
      "show line diagnostics",
    },
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
  lvim.builtin.which_key.mappings["c"]["j"] = { "<cmd>CBlbox<cr>", "left aligned box" }
  lvim.builtin.which_key.mappings["c"]["J"] = { "<cmd>CBalbox<cr>", "adapted left aligned box" }
  lvim.builtin.which_key.mappings["c"]["k"] = { "<cmd>CBcbox<cr>", "centered box" }
  lvim.builtin.which_key.mappings["c"]["K"] = { "<cmd>CBacbox<cr>", "adapted centered box" }
  lvim.builtin.which_key.mappings["c"]["l"] = { "<cmd>CBline<cr>", "left aligned line" }

  lvim.builtin.which_key.vmappings["c"]["j"] = { "<cmd>CBlbox<cr>", "left aligned box" }
  lvim.builtin.which_key.vmappings["c"]["J"] = { "<cmd>CBalbox<cr>", "adapted left aligned box" }
  lvim.builtin.which_key.vmappings["c"]["k"] = { "<cmd>CBcbox<cr>", "centered box" }
  lvim.builtin.which_key.vmappings["c"]["K"] = { "<cmd>CBacbox<cr>", "adapted centered box" }
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

function M.set_yanky_keymaps()
  -- better yank (stays in position after yank)
  vim.keymap.set("n", "y", "<Plug>(YankyYank)", { noremap = false })
  vim.keymap.set("x", "y", "<Plug>(YankyYank)", { noremap = false })

  -- yanky put (for yank-ring)
  vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", M.opts_normal)
  vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", M.opts_visual)
  vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", M.opts_normal)
  vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", M.opts_visual)
  vim.keymap.set("n", "<A-n>", "<Plug>(YankyCycleForward)", M.opts_normal)
  vim.keymap.set("n", "<A-p>", "<Plug>(YankyCycleBackward)", M.opts_normal)

  -- better pasting in visual mode
  -- lvim.keys.visual_mode["p"] = [["_dP]]
end

function M.set_markdown_preview_keymaps()
  lvim.builtin.which_key.mappings["n"]["p"] = { "<cmd>MarkdownPreview<cr>", "markdown preview" }
end

function M.set_session_lens_keymaps()
  lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>SearchSession<cr>", "sessions" }
end

function M.set_smart_splits_keymaps()
  lvim.builtin.which_key.mappings["w"]["J"] = {
    "<cmd>lua require('smart-splits').resize_down()<cr>",
    "resize window down",
  }
  lvim.builtin.which_key.mappings["w"]["K"] = { "<cmd>lua require('smart-splits').resize_up()<cr>", "resize window up" }
  lvim.builtin.which_key.mappings["w"]["L"] = {
    "<cmd>lua require('smart-splits').resize_left()<cr>",
    "resize window left",
  }
  lvim.builtin.which_key.mappings["w"]["r"] = {
    "<cmd>lua require('smart-splits').start_resize_mode()<cr>",
    "win-resize move",
  }
  lvim.builtin.which_key.mappings["w"][":"] = {
    "<cmd>lua require('smart-splits').resize_right()<cr>",
    "resize window right",
  }
end

function M.set_winshift_keymaps()
  lvim.builtin.which_key.mappings["w"]["a"] = { "<cmd>WinShift<cr>", "win-move mode" }
  lvim.builtin.which_key.mappings["w"]["j"] = { "<cmd>WinShift down<cr>", "switch window down" }
  lvim.builtin.which_key.mappings["w"]["k"] = { "<cmd>WinShift up<cr>", "switch window up" }
  lvim.builtin.which_key.mappings["w"]["l"] = { "<cmd>WinShift left<cr>", "switch window left" }
  lvim.builtin.which_key.mappings["w"]["w"] = { "<cmd>WinShift swap<cr>", "swap window" }
  lvim.builtin.which_key.mappings["w"][";"] = { "<cmd>WinShift right<cr>", "switch window right" }
end

function M.set_windex_keymaps()
  -- navigate windows/splits
  -- I have <C-;> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing
  vim.keymap.set("n", "<C-l>", "<cmd>lua require('windex').switch_window('left')<cr>", M.opts_normal)
  vim.keymap.set("n", "<C-j>", "<cmd>lua require('windex').switch_window('down')<cr>", M.opts_normal)
  vim.keymap.set("n", "<C-k>", "<cmd>lua require('windex').switch_window('up')<cr>", M.opts_normal)
  vim.keymap.set("n", "<C-h>", "<cmd>lua require('windex').switch_window('right')<cr>", M.opts_normal)

  lvim.builtin.which_key.mappings["w"]["z"] = {
    "<cmd>lua require('windex').toggle_maximize()<cr>",
    "toggle maximize window",
  }
  lvim.builtin.which_key.mappings["w"]["S"] = {
    "<cmd>lua require('windex').create_pane('horizontal')<cr>",
    "split tmux pane",
  }
  lvim.builtin.which_key.mappings["w"]["V"] = {
    "<cmd>lua require('windex').create_pane('vertical')<cr>",
    "vsplit tmux pane",
  }
end

function M.set_textcase_keymaps()
  lvim.builtin.which_key.mappings["i"] = {
    name = "+Textcase",
    ["u"] = { ":lua require('textcase').lsp_rename('to_upper_case')<CR>", "uppercase" },
    ["l"] = { ":lua require('textcase').lsp_rename('to_lower_case')<CR>", "lowercase" },
    ["s"] = { ":lua require('textcase').lsp_rename('to_snake_case')<CR>", "snake case" },
    ["d"] = { ":lua require('textcase').lsp_rename('to_dash_case')<CR>", "dash case" },
    ["n"] = { ":lua require('textcase').lsp_rename('to_constant_case')<CR>", "constant case" },
    ["."] = { ":lua require('textcase').lsp_rename('to_dot_case')<CR>", "dot case" },
    ["a"] = { ":lua require('textcase').lsp_rename('to_phrase_case')<CR>", "phrase case" },
    ["c"] = { ":lua require('textcase').lsp_rename('to_camel_case')<CR>", "camel case" },
    ["p"] = { ":lua require('textcase').lsp_rename('to_pascal_case')<CR>", "pascal case" },
    ["t"] = { ":lua require('textcase').lsp_rename('to_title_case')<CR>", "title case" },
    ["f"] = { ":lua require('textcase').lsp_rename('to_path_case')<CR>", "path case" },
  }
  lvim.builtin.which_key.vmappings["i"] = lvim.builtin.which_key.mappings["i"]
end

function M.set_inc_rename_keymaps()
  vim.keymap.set("n", "<leader>lr", function()
    return ":IncRename " .. vim.fn.expand "<cword>"
  end, { expr = true })
  lvim.builtin.which_key.mappings["l"]["r"] = { "rename" }
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
    ["r"] = { "<cmd>Telescope asynctasks all<cr>", "run task" },
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

return M
