local M = {}

M.config = function()
  -- set all my user commands
  require("user.usercmd").set_user_commands()

  -- keymappings [view all the lunarvim defaults by pressing <leader>Lk]

  -- save with c-s
  lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

  -- more ergonomic matchup
  lvim.keys.normal_mode["<Tab>"] = "<plug>(matchup-%)"
  lvim.keys.visual_mode["<Tab>"] = "<plug>(matchup-%)"
  vim.api.nvim_set_keymap("o", "<Tab>", "<plug>(matchup-%)", { noremap = true })

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

  -- navigate windows/splits
  -- I have <C-;> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing
  lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('Navigator').left()<CR>"
  lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('Navigator').down()<CR>"
  lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('Navigator').up()<CR>"
  lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('Navigator').right()<CR>"

  -- Increment and decrement
  lvim.keys.normal_mode["<A-;>"] = "<C-a>"
  lvim.keys.normal_mode["<A-l>"] = "<C-x>"

  -- Harpoon marks
  lvim.keys.normal_mode["<A-1>"] = "<cmd>lua require('harpoon.ui').nav_file(1)<cr>"
  lvim.keys.normal_mode["<A-2>"] = "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"
  lvim.keys.normal_mode["<A-3>"] = "<cmd>lua require('harpoon.ui').nav_file(3)<cr>"
  lvim.keys.normal_mode["<A-4>"] = "<cmd>lua require('harpoon.ui').nav_file(4)<cr>"
  lvim.keys.normal_mode["<A-5>"] = "<cmd>lua require('harpoon.ui').nav_file(5)<cr>"
  lvim.keys.normal_mode["<A-6>"] = "<cmd>lua require('harpoon.ui').nav_file(6)<cr>"

  -- move current line up/down
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<A-k>"] = ":m .-2<cr>=="

  -- jump back and forth between buffers (mirror C-o/C-i for moving in the jumplist)
  lvim.keys.normal_mode["<A-o>"] = ":lua require('bufjump').backward()<cr>"
  lvim.keys.normal_mode["<A-i>"] = ":lua require('bufjump').forward()<cr>"

  -- toggleterm maps
  lvim.keys.normal_mode["<A-a>"] = "<cmd>lua require('user.plugins.toggleterm').toggle_term2()<cr>"
  lvim.keys.normal_mode["<A-s>"] = "<cmd>lua require('user.plugins.toggleterm').toggle_term3()<cr>"
  -- lvim.keys.normal_mode["<A-d>"] = ""
  -- lvim.keys.normal_mode["<A-f>"] = ""
  -- lvim.keys.normal_mode["<A-g>"] = ""

  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to Shift+Left and Cmd+Right mapped to Shift+Right)
  lvim.keys.normal_mode["<S-Left>"] = "_"
  lvim.keys.normal_mode["<S-Right>"] = "$"

  -- cycle buffers
  lvim.keys.normal_mode["<S-h>"] = ":CybuPrev<cr>"
  lvim.keys.normal_mode["<S-l>"] = ":CybuNext<cr>"

  -- no highlight on esc
  lvim.keys.normal_mode["<Esc>"] = "<cmd>nohlsearch<cr>"

  -----[[------------]]-----
  ---       Visual       ---
  -----]]------------[[-----

  -- I use jkl; instead of hjkl
  lvim.keys.visual_mode[";"] = "l"
  lvim.keys.visual_mode["l"] = "h"

  -- better pasting in visual mode
  lvim.keys.visual_mode["p"] = [["_dP]]

  -- Move visual selection up/down
  lvim.keys.visual_mode["<A-j>"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<A-k>"] = ":m '<-2<cr>gv=gv"

  -- ergonmic mappings for end of line and beginning of line (my terminal has Cmd+Left mapped to Shift+Left and Cmd+Right mapped to Shift+Right)
  lvim.keys.visual_mode["<S-Left>"] = "_"
  lvim.keys.visual_mode["<S-Right>"] = "$"

  -----[[------------]]-----
  ---       Insert       ---
  -----]]------------[[-----

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
  -----[[------------]]-----
  ---      Whichkey      ---
  -----]]------------[[-----

  lvim.builtin.which_key.mappings["a"] = { "<cmd>up!<cr>", "write buffer" }
  lvim.builtin.which_key.mappings["c"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["e"] = "which_key_ignore"
  lvim.builtin.which_key.mappings["f"] = { "<cmd>Lf %<cr>", "file manager" }
  lvim.builtin.which_key.mappings["q"] = { "<cmd>lua require('user.usercmd').smart_quit()<cr>", "quit" }
  lvim.builtin.which_key.mappings["t"] = { "<cmd>NvimTreeToggle<cr>", "file tree" }
  lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<cr>", "dashboard" }
  lvim.builtin.which_key.mappings["/"] = {
    "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>",
    "comment line",
  }

  -- =========================================
  -- +Buffers
  -- =========================================
  lvim.builtin.which_key.mappings["b"] = {
    name = "+Buffers",
    ["a"] = { "<cmd>BDelete all<cr>", "delete all buffers" },
    ["b"] = { "<cmd>lua require('user.telescope.custom_pickers').switch_buffers()<cr>", "switch buffers" },
    ["d"] = { "<cmd>BDelete this<CR>", "close this buffer" },
    ["h"] = { "<cmd>BDelete! hidden<cr>", "close hidden buffers" },
    ["n"] = { "<cmd>CybuNext<cr>", "next buffer" },
    ["o"] = { "<cmd>BDelete! other<CR>", "close other buffers" },
    ["p"] = { "<cmd>CybuPrev<cr>", "previous buffer" },
  }

  -- =========================================
  -- +Debug
  -- =========================================

  -- see "user.plugins.dap"

  -- =========================================
  -- +Git
  -- =========================================
  lvim.builtin.which_key.mappings["g"] = {
    name = "+Git",
    b = { "<cmd>Telescope git_branches<cr>", "checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "checkout commit (for current file)" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "git diff" },
    g = { ":LazyGit<cr>", "lazygit" },
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

  -- =========================================
  -- +Harpoon
  -- =========================================
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

  -- =========================================
  -- +LSP
  -- =========================================
  lvim.builtin.which_key.mappings["la"] = { "<cmd>CodeActionMenu<cr>", "code actions" }
  lvim.builtin.which_key.mappings["l"]["d"] = { "<cmd>Trouble lsp_definitions<cr>", "definitions" }
  lvim.builtin.which_key.mappings["le"] = { "<cmd>Trouble lsp_references<cr>", "references" }
  lvim.builtin.which_key.mappings["lL"] = { "<cmd>Trouble loclist<cr>", "loclist" }
  lvim.builtin.which_key.mappings["lq"] = { "<cmd>Trouble quicklist<cr>", "quicklist" }
  lvim.builtin.which_key.mappings["l"]["r"] = { "<cmd>LspRename<cr>", "rename" }
  lvim.builtin.which_key.mappings["lx"] = { "<cmd>Trouble document_diagnostics<cr>", "buffer diagnostics" }
  lvim.builtin.which_key.mappings["lX"] = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace diagnostics" }

  -- =========================================
  -- +Search
  -- =========================================
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
    ["f"] = { "<cmd>lua require('user.telescope.custom_pickers').find_files()<cr>", "files in project" },
    ["k"] = { "<cmd>Legendary<cr>", "keymaps" },
    ["l"] = { "<cmd>lua require('user.telescope.custom_pickers').find_lunarvim_files()<cr>", "lunarvim files" },
    ["m"] = { "<cmd>lua require('user.telescope.custom_pickers').marks()<cr>", "marks" },
    ["n"] = { "<cmd>lua require('user.telescope.custom_pickers').find_notes()<cr>", "notes" },
    ["p"] = { "<cmd>Telescope projects theme=ivy<cr>", "projects" },
    ["r"] = { "<cmd>Telescope oldfiles theme=ivy<cr>", "recent files" },
    ["g"] = { "<cmd>lua require('user.telescope.custom_pickers').grep_files()<cr>", "grep in project" },
  }

  -- =========================================
  -- +Windows
  -- =========================================
  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    ["d"] = { "<cmd>close<cr>", "delete window" },
    ["o"] = { "<cmd>only<cr>", "delete other windows" },
    ["s"] = { "<cmd>split<CR>", "split window" },
    ["v"] = { "<cmd>vsplit<cr>", "vsplit window" },
    ["z"] = { "<Plug>Zoom<cr>", "toggle zoom window" },
    ["j"] = { "", "switch window down" },
    ["k"] = { "", "switch window up" },
    ["l"] = { "", "switch window left" },
    [";"] = { "", "switch window right" },
  }
end

return M
