-- gomi (rm replacement)
-- TODO: make gomi work with no files marked
return function()
  local lir = require "lir"
  local utils = require "lir.utils"
  local actions = require "lir.actions"

  local function esc_path(path)
    return vim.fn.shellescape(vim.fn.fnamemodify(path, ":p"), true)
  end
  -- https://github.com/b4b4r07/gomi
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
  -- vim.fn.system("gomi -f" .. vim.fn.join(path_list))
  actions.reload()
  -- =========================================
end
