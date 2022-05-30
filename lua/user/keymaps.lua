local M = {}

M.config = function()
  -- general
  -- to disable icons and use a minimalist setup, uncomment the following
  -- lvim.use_icons = false

  -- keymappings [view all the defaults by pressing <leader>Lk]
  -- add your own keymapping
  lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

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

  -- lightspeed
  lvim.keys.normal_mode["s"] = "<Plug>Lightspeed_s"
  lvim.keys.normal_mode["S"] = "<Plug>Lightspeed_S"
  lvim.keys.normal_mode["gs"] = "<Plug>Lightspeed_gs"
  lvim.keys.normal_mode["gS"] = "<Plug>Lightspeed_gS"

  -- navigate windows/splits
  -- I have <C-;> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing
  lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('Navigator').left()<CR>"
  lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('Navigator').down()<CR>"
  lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('Navigator').up()<CR>"
  lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('Navigator').right()<CR>"

  -- Increment
  lvim.keys.normal_mode["<A-a>"] = "<C-a>"

  -- move current line up/down
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<A-k>"] = ":m .-2<cr>=="

  -- jump back and forth between buffers (mirror C-o/C-i for moving in the jumplist)
  lvim.keys.normal_mode["<A-o>"] = ":lua require('bufjump').backward()<cr>"
  lvim.keys.normal_mode["<A-i>"] = ":lua require('bufjump').forward()<cr>"

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
  lvim.builtin.which_key.mappings["q"] = { "<cmd>qa<cr>", "quit all" }
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
  -- +Git
  -- =========================================
  lvim.builtin.which_key.mappings["gg"] = { ":LazyGit<cr>", "lazygit" }

  -- =========================================
  -- +LSP
  -- =========================================
  lvim.builtin.which_key.mappings["ld"] = { "Trouble lsp_definitions<cr>", "definitions" }
  lvim.builtin.which_key.mappings["le"] = { "Trouble lsp_references<cr>", "references" }
  lvim.builtin.which_key.mappings["lL"] = { "Trouble loclist<cr>", "loclist" }
  lvim.builtin.which_key.mappings["lq"] = { "Trouble quicklist<cr>", "quicklist" }
  lvim.builtin.which_key.mappings["lx"] = { "Trouble document_diagnostics<cr>", "buffer diagnostics" }
  lvim.builtin.which_key.mappings["lX"] = { "Trouble workspace_diagnostics<cr>", "workspace diagnostics" }

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

M.set_lightspeed_keymaps = function()
  vim.cmd [[
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"
  ]]
end

return M
