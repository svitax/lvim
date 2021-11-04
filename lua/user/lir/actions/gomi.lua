-- gomi (rm replacement)
-- https://github.com/b4b4r07/gomi
M = {}

M.wipeout_marked = function()
  local lir = require "lir"
  local utils = require "lir.utils"
  local actions = require "lir.actions"

  local function esc_path(path)
    return vim.fn.shellescape(vim.fn.fnamemodify(path, ":p"), true)
  end
  local ctx = lir.get_context()

  local marked_items = ctx:get_marked_items()
  if #marked_items == 0 then
    utils.error "Please mark one or more."
    return
  end

  if vim.fn.confirm("Delete files?", "&Yes\n&No", 2) ~= 1 then
    return
  end

  local files_path_list = {}
  local dir_path_list = {}
  vim.tbl_map(function(items)
    if items.is_dir then
      table.insert(dir_path_list, esc_path(items.fullpath))
    else
      table.insert(files_path_list, esc_path(items.fullpath))
      -- delete its buffer
      local bufnr = vim.fn.bufnr(items.fullpath)
      if bufnr ~= -1 then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  end, marked_items)

  vim.fn.system("gomi " .. vim.fn.join(files_path_list))
  vim.fn.system("gomi " .. vim.fn.join(dir_path_list))

  actions.reload()
end

M.wipeout = function()
  local lir = require "lir"
  local actions = require "lir.actions"

  local function esc_path(path)
    return vim.fn.shellescape(vim.fn.fnamemodify(path, ":p"), true)
  end

  local ctx = lir.get_context()
  local name = ctx:current().fullpath

  if vim.fn.confirm("Delete?: " .. name, "&Yes\n&No", 1) ~= 1 then
    return
  end

  -- if not a directory, delete buffer
  if not ctx:is_dir_current() then
    local bufnr = vim.fn.bufnr(name)
    if bufnr ~= -1 then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
    vim.fn.system("gomi " .. esc_path(name))
  else
    vim.fn.system("gomi " .. esc_path(name))
  end

  actions.reload()
end

return M
