-- edit without splitting (builtin edit splits sometimes)
-- =========================================
return function()
  local lirvim = require "lir.vim"
  local actions = require "lir.actions"
  local get_context = lirvim.get_context
  local history = require "lir.history"

  local ctx = get_context()
  local dir, file = ctx.dir, ctx:current_value()
  if not file then
    return
  end

  local keepalt = (vim.w.lir_is_float and "") or "keepalt"

  if vim.w.lir_is_float and not ctx:is_dir_current() then
    -- 閉じてから開く
    actions.quit()
  end

  -- local cmd = (vim.api.nvim_buf_get_option(0, "modified") and "split") or "edit"
  local cmd = "edit"

  vim.cmd(string.format("%s %s %s", keepalt, cmd, vim.fn.fnameescape(dir .. file)))
  history.add(dir, file)
  -- =========================================
end
