local M = {}

M.config = function()
  local status_ok, indent_scope = pcall(require, "mini.indentscope")
  if not status_ok then
    return
  end

  indent_scope.setup {
    symbol = "│",
    -- ¦, ┆, │, ⎸, or ▏
  }

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "alpha",
    command = "lua vim.b.miniindentscope_disable = true",
  })
end

return M
