M = {}

M.config = function()
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
  -- Undo break points (for a finer-grained undo command)
  -- should I add space to this list?
  lvim.keys.visual_mode[","] = ",<c-g>u"
  lvim.keys.visual_mode["."] = ".<c-g>u"
  lvim.keys.visual_mode["!"] = "!<c-g>u"
  lvim.keys.visual_mode["?"] = "?<c-g>u"
  lvim.keys.visual_mode["<cr>"] = "<cr><c-g>u"

  -- NOTE: Insert mode
  -- Move current line up/down
  lvim.keys.insert_mode["<C-M-j>"] = "<Esc>:m .+1<CR>==gi"
  lvim.keys.insert_mode["<C-M-k>"] = "<Esc>:m .-2<CR>==gi"

  -- NOTE: Terminal mode
  -- this prevents lazygit from working properly
  -- lvim.keys.term_mode["<esc>"] = [[<C-\><C-n>]]

  -- you can also use the native vim way directly
  -- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })

  -- NOTE: WhichKey
  -- lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope find_files<CR>", "Find File" }
  lvim.builtin.which_key.mappings["c"] = { "<cmd>Bdelete<CR>", "Delete buffer" }

  -- +Buffers
  -- =========================================
  -- :lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})
  lvim.builtin.which_key.mappings["b"]["b"] = {
    ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer=false, layout_config={height=0.25}}))<cr>",
    "Switch buffer",
  }
  lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>Bdelete<CR>", "Delete buffer" }
  lvim.builtin.which_key.mappings["b"]["s"] = { "<cmd>new<CR>", "New horizontal buffer" }
  lvim.builtin.which_key.mappings["b"]["v"] = { ":vnew<cr>", "New vertical buffer" }
  lvim.builtin.which_key.mappings["b"]["w"] = { "<cmd>Bwipeout<CR>", "Wipeout buffers" }
  -- lvim.builtin.which_key.mappings["b"]["b"] = { "<cmd>Telescope buffers<CR>", "Switch buffer" }
  -- lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>BufferClose!<CR>", "Delete buffer" }
  -- lvim.builtin.which_key.mappings["b"]["l"] = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all buffers to the left" }
  -- lvim.builtin.which_key.mappings["b"][";"] = { "<cmd>BufferCloseBuffersRight<cr>", "Close all buffers to the right" }

  lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle debug UI" }
  lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }

  -- lvim.builtin.which_key.mappings["g"]["b"] = { ":VGit buffer_preview<CR>", "Diff current buffer" }
  -- lvim.builtin.which_key.mappings["g"]["h"] = { ":VGit buffer_history<cr>", "Diff buffer history" }
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

  -- +Git
  -- =========================================
  lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "View diffs" }
  lvim.builtin.which_key.mappings["g"]["D"] = { "<cmd>DiffviewClose<cr>", "Close diff view" }
  lvim.builtin.which_key.mappings["g"]["i"] = { "<cmd>Octo issue list<cr>", "GitHub issues" }
  lvim.builtin.which_key.mappings["g"]["l"] = { "<cmd>lua require'gitsigns'.blame_line(true)<cr>", "Blame message" }
  lvim.builtin.which_key.mappings["g"]["P"] = { "<cmd>Octo pr list<cr>", "GitHub pull requests" }

  -- +LSP
  -- =========================================
  lvim.builtin.which_key.mappings["ld"] = {
    "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
    "List document diagnostics",
  }
  lvim.builtin.which_key.mappings["lD"] = {
    "<cmd>TroubleToggle lsp_definitions<cr>",
    "List definitions",
  }
  lvim.builtin.which_key.mappings["lR"] = {
    "<cmd>TroubleToggle lsp_references<cr>",
    "List references",
  }
  lvim.builtin.which_key.mappings["l"]["w"] = {
    "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
    "List workspace diagnostics",
  }
  lvim.builtin.which_key.mappings["l"]["p"] = {
    name = "Peek",
    d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Peek definition" },
    t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Peek type definition" },
    i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Peek implementation" },
  }

  -- +Files
  -- =========================================
  lvim.builtin.which_key.mappings["e"] = { "<cmd>lua require'lir.float'.toggle()<cr>", "Explorer" }
  lvim.builtin.which_key.mappings["f"] = {
    name = "+Files",
    b = { "<cmd>edit .<cr>", "File manager in this buffer" },
    f = { "<cmd>lua require'lir.float'.toggle()<cr>", "Floating file manager" },
    t = { "<cmd>lua require'core.nvimtree'.toggle_tree()<CR>", "Explorer" },
    n = {
      "<cmd>lua require('lir.float').toggle('~/.config/lvim/lua/notes/obsidian-notes')<CR>",
      "Notes dir",
    },
  }

  -- +Replace
  -- =========================================
  lvim.builtin.which_key.mappings["r"] = {
    name = "+Replace",
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace word" },
  }

  -- +Search
  -- =========================================
  lvim.builtin.which_key.mappings["sc"] = {
    "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
    "Search colorschemes",
  }
  lvim.builtin.which_key.mappings["s"]["n"] = {
    "<cmd>lua require('telescope.builtin').find_files({cwd = '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'})<CR>",
    "Search Obsidian notes",
  }
  lvim.builtin.which_key.mappings["s"]["p"] = { "<cmd>Telescope project<cr>", "Search project" }
  lvim.builtin.which_key.mappings["s"]["T"] = { "<cmd>TodoTrouble<cr>", "Search todos" }

  -- +Open
  -- =========================================
  lvim.builtin.which_key.mappings["o"] = {
    name = "+Open",
    w = { "<cmd>Bracey<cr>", "Web server with live reload" },
  }

  -- +Window
  -- =========================================
  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    d = { "<cmd>close<CR>", "Delete current window" },
    D = { "<cmd>only<CR>", "Delete all other windows" },
    s = { "<cmd>split<CR>", "Split window horizontally" },
    j = { "<C-w>j<cr>", "Move to window below" },
    k = { "<C-w>k<cr>", "Move to window above" },
    l = { "<C-w>h<cr>", "Move to left window" },
    v = { "<cmd>vsplit<CR>", "Split window vertically" },
    [";"] = { "<C-w>l<cr>", "Move to right window" },
  }
end

return M
