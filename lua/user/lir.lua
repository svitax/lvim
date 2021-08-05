local status_ok, lir = pcall(require, "lir")
if not status_ok then
  return
end
local api = vim.api
local config = require "lir.config"
local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"
local utils = require "lir.utils"
local Path = require "plenary.path"

-- Custom Lir actions

local function home()
  vim.cmd("edit " .. vim.fn.expand "$HOME")
end

-- START gomi
local function esc_path(path)
  return vim.fn.shellescape(vim.fn.fnamemodify(path, ":p"), true)
end
-- https://github.com/b4b4r07/gomi
local function gomi()
  local ctx = lir.get_context()

  local marked_items = ctx:get_marked_items()
  if #marked_items == 0 then
    utils.error "Please mark one or more."
    return
  end

  local path_list = vim.tbl_map(function(items)
    return esc_path(items.fullpath)
  end, marked_items)

  if vim.fn.confirm("Delete files?", "&Yes\n&No", 2) ~= 1 then
    return
  end
  vim.fn.system("gomi " .. vim.fn.join(path_list))
  actions.reload()
end
-- START gomi

-- local function nop() end

local function goto_git_root()
  local dir = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd())
  if dir == nil or dir == "" then
    return
  end
  vim.cmd("e " .. dir)
end

local no_confirm_patterns = {
  "^LICENSE$",
  "^Makefile$",
}

local lcd = function(path)
  vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], path))
end

local need_confirm = function(filename)
  for _, pattern in ipairs(no_confirm_patterns) do
    if filename:match(pattern) then
      return false
    end
  end
  return true
end

local function input_newfile()
  local save_curdir = vim.fn.getcwd()
  lcd(lir.get_context().dir)
  local name = vim.fn.input("New file: ", "", "file")
  lcd(save_curdir)

  if name == "" then
    return
  end

  if name == "." or name == ".." then
    utils.error("Invalid file name: " .. name)
    return
  end

  -- If I need to check, I will.
  if need_confirm(name) then
    -- '.' is not included or '/' is not included, then
    -- I may have entered it as a directory, I'll check.
    if not name:match "%." and not name:match "/" then
      if vim.fn.confirm("Directory?", "&No\n&Yes", 1) == 2 then
        name = name .. "/"
      end
    end
  end

  local path = Path:new(lir.get_context().dir .. name)
  if string.match(name, "/$") then
    -- mkdir
    name = name:gsub("/$", "")
    path:mkdir {
      parents = true,
      mode = tonumber("700", 8),
      exists_ok = false,
    }
  else
    -- touch
    path:touch {
      parents = true,
      mode = tonumber("644", 8),
    }
  end

  -- If the first character is '.' and show_hidden_files is false, set it to true
  if name:match [[^%.]] and not config.values.show_hidden_files then
    config.values.show_hidden_files = true
  end

  actions.reload()

  -- Jump to a line in the parent directory of the file you created.
  local lnum = lir.get_context():indexof(name:match "^[^/]+")
  if lnum then
    vim.cmd(tostring(lnum))
  end
end

-- Construct the Lir floating window options according to the window we are
-- currently in. The position of the window will be centered in the current
-- window, thus not blocking other windows if opened.
---@return table<string, any>
local function construct_win_opts()
  local winpos = api.nvim_win_get_position(0)
  local winwidth = api.nvim_win_get_width(0)
  local winheight = api.nvim_win_get_height(0)

  local width = math.min(80, winwidth - 14)
  local height = winheight - 6
  local row = (winheight / 2) - (height / 2) - 1
  local col = (winwidth / 2) - (width / 2)

  return {
    width = width,
    height = height,
    row = row + winpos[1],
    col = col + winpos[2],
    border = "single",
  }
end

lir.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    -- goto_git_root
    ["g"] = goto_git_root,
    -- home
    ["h"] = home,

    -- TODO look into making an edit command that doesn't split if the file is already open in a buffer
    [";"] = actions.edit,
    ["<cr>"] = actions.edit,

    ["<C-s>"] = actions.split,
    ["S"] = actions.split,
    ["V"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,

    ["l"] = actions.up,
    ["q"] = actions.quit,

    -- ["A"] = actions.mkdir,
    -- ["a"] = actions.newfile,
    ["a"] = input_newfile,
    ["r"] = actions.rename,
    -- TODO: get lir.mmv to work (i think something is wrong with nvr)
    -- ["R"] = require("lir.mmv.actions").mmv,
    ["@"] = actions.cd,
    ["y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    -- ["d"] = actions.delete,
    ["D"] = gomi,

    ["m"] = function()
      mark_actions.toggle_mark()
      vim.cmd "normal! j"
    end,
    ["Y"] = clipboard_actions.copy,
    ["X"] = clipboard_actions.cut,
    ["P"] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    win_opts = construct_win_opts,
    -- win_opts = function()
    --   --   local width = math.floor(vim.o.columns * 0.8)
    --   --   local height = math.floor(vim.o.lines * 0.8)
    --   return {
    --     border = "single",
    --     -- border = require("lir.float.helper").make_border_opts({
    --     --   "+",
    --     --   "─",
    --     --   "+",
    --     --   "│",
    --     --   "+",
    --     --   "─",
    --     --   "+",
    --     --   "│",
    --     -- }, "Normal"),
    --     --     width = width,
    --     --     height = height,
    --     --     row = 1,
    --     --     col = math.floor((vim.o.columns - width) / 2),
    --   }
    -- end,
  },
  hide_cursor = false,
}

-- custom folder icon
require("nvim-web-devicons").setup {
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#a9b665",
      name = "LirFolderNode",
    },
  },
}

-- use visual mode
function _G.LirSettings()
  -- Close on lose focus
  vim.cmd [[augroup LirCloseOnWinLeave]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd WinLeave <buffer> if get(w:, 'lir_is_float', v:false) | call nvim_win_close(0, v:true) | endif]]
  vim.cmd [[augroup END]]
  -- Visual mode marks
  api.nvim_buf_set_keymap(
    0,
    "x",
    "m",
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true }
  )

  -- echo cwd
  api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]

-- TODO add to fennec-gruvbox theme
-- Highlight groups
-- hi LirFloatNormal guibg=#32302f
-- hi LirDir guifg=#7ebae4
-- hi LirSymLink guifg=#7c6f64
-- hi LirEmptyDirText guifg=#7c6f64
