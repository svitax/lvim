local M = {}

M.config = function()
  local status_ok, surround = pcall(require, "mini.surround")
  if not status_ok then
    return
  end

  surround.setup {
    highlight_duration = 3000,
    n_lines = 30,
    custom_surroundings = {
      ["("] = { output = { left = "( ", right = " )" } },
      ["["] = { output = { left = "[ ", right = " ]" } },
      ["{"] = { output = { left = "{ ", right = " }" } },
      ["<"] = { output = { left = "< ", right = " >" } },
    },
    mappings = {
      add = "ys",
      delete = "ds",
      find = "",
      find_left = "",
      highlight = "yh",
      replace = "cs",
      update_n_lines = "",
    },
    search_method = "cover_or_next",
  }

  -- yss for add surround line
  vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })
end

return M
