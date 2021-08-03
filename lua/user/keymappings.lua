M = {}

M.config = function()
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
  lvim.keys.normal_mode["<C-M-j>"] = ":m .+1<cr>=="
  lvim.keys.normal_mode["<C-M-k>"] = ":m .-2<cr>=="

  -- NOTE: Visual mode
  -- better movement keys
  lvim.keys.visual_mode[";"] = "l"
  lvim.keys.visual_mode["l"] = "h"
  -- Move visual selection up/down
  lvim.keys.visual_mode["<C-M-j>"] = ":m '>+1<cr>gv=gv"
  lvim.keys.visual_mode["<C-M-k>"] = ":m '<-2<cr>gv=gv"

  -- Undo break points (for a finer-grained undo command)
  -- should I add space to this list?
  lvim.keys.visual_mode[","] = ",<c-g>u"
  lvim.keys.visual_mode["."] = ".<c-g>u"
  lvim.keys.visual_mode["!"] = "!<c-g>u"
  lvim.keys.visual_mode["?"] = "?<c-g>u"
  lvim.keys.visual_mode["<cr>"] = "<cr><c-g>u"

  -- NOTE: Visual mode
  -- Move current line up/down
  lvim.keys.insert_mode["<C-M-j>"] = "<Esc>:m .+1<CR>==gi"
  lvim.keys.insert_mode["<C-M-k>"] = "<Esc>:m .-2<CR>==gi"

  -- you can also use the native vim way directly
  -- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })

  -- NOTE: WhichKey
  -- lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope find_files<CR>", "Find File" }
  lvim.builtin.which_key.mappings["b"]["b"] = { "<cmd>Telescope buffers<CR>", "Switch buffer" }
  lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>BufferClose!<CR>", "Delete buffer" }
  lvim.builtin.which_key.mappings["b"]["h"] = { "<cmd>new<CR>", "New horizontal buffer" }
  lvim.builtin.which_key.mappings["b"]["l"] = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all buffers to the left" }
  lvim.builtin.which_key.mappings["b"]["v"] = { ":vnew<cr>", "New vertical buffer" }
  lvim.builtin.which_key.mappings["b"][";"] = { "<cmd>BufferCloseBuffersRight<cr>", "Close all buffers to the right" }

  lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle debug UI" }
  lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
  lvim.builtin.which_key.mappings["dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" }

  -- lvim.builtin.which_key.mappings["g"]["b"] = { ":VGit buffer_preview<CR>", "Diff current buffer" }
  -- lvim.builtin.which_key.mappings["g"]["h"] = { ":VGit buffer_history<cr>", "Diff buffer history" }
  lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "View diffs" }
  lvim.builtin.which_key.mappings["g"]["D"] = { "<cmd>DiffviewClose<cr>", "Close diff view" }
  lvim.builtin.which_key.mappings["g"]["i"] = { "<cmd>Octo issue list<cr>", "GitHub issues" }
  lvim.builtin.which_key.mappings["g"]["l"] = { "<cmd>lua require'gitsigns'.blame_line(true)<cr>", "Blame message" }
  lvim.builtin.which_key.mappings["g"]["P"] = { "<cmd>Octo pr list<cr>", "GitHub pull requests" }

  lvim.builtin.which_key.mappings["l"]["d"] = {
    "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
    "List document diagnostics",
  }
  lvim.builtin.which_key.mappings["l"]["D"] = {
    "<cmd>TroubleToggle lsp_definitions<cr>",
    "List definitions",
  }
  lvim.builtin.which_key.mappings["l"]["R"] = {
    "<cmd>TroubleToggle lsp_references<cr>",
    "List references",
  }
  lvim.builtin.which_key.mappings["l"]["w"] = {
    "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
    "List workspace diagnostics",
  }

  lvim.builtin.which_key.mappings["r"] = { "<cmd>RnvimrToggle<cr>", "Ranger" }

  lvim.builtin.which_key.mappings["s"]["n"] = {
    "<cmd>lua require('telescope.builtin').find_files({cwd = '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'})<CR>",
    "Search Obsidian notes",
  }
  lvim.builtin.which_key.mappings["s"]["p"] = { "<cmd>Telescope project<cr>", "Search project" }
  lvim.builtin.which_key.mappings["s"]["T"] = { "<cmd>TodoTrouble<cr>", "Search todos" }

  lvim.builtin.which_key.mappings["o"] = {
    name = "+Open",
    w = { "<cmd>Bracey<cr>", "Web server with live reload" },
  }

  lvim.builtin.which_key.mappings["w"] = {
    name = "+Windows",
    d = { "<cmd>close<CR>", "Delete current window" },
    D = { "<cmd>only<CR>", "Delete all other windows" },
    h = { "<cmd>split<CR>", "Split window horizontally" },
    j = { "<C-w>j<cr>", "Move to window below" },
    k = { "<C-w>k<cr>", "Move to window above" },
    l = { "<C-w>h<cr>", "Move to left window" },
    v = { "<cmd>vsplit<CR>", "Split window vertically" },
    [";"] = { "<C-w>l<cr>", "Move to right window" },
  }
end

return M
