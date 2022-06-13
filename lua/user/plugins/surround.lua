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
      add = "gs",
      delete = "ds",
      find = "",
      find_left = "",
      highlight = "gh",
      replace = "cs",
      update_n_lines = "",
    },
    search_method = "cover_or_next",
  }

  require("user.keymaps").set_surround_keymaps()
end

return M
