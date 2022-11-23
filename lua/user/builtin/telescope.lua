-- local actions = require "telescope.actions"
-- lvim.builtin.telescope.defaults.mappings.n.q = actions.close
lvim.builtin.telescope.defaults.mappings.i["<C-h>"] = "<c-s-w>"
lvim.builtin.telescope.defaults.wrap_results = true
lvim.builtin.telescope.pickers = {
  find_files = { theme = "ivy" },
  grep_string = { theme = "ivy" },
  live_grep = { theme = "ivy" },
  buffers = { theme = "ivy" },
  oldfiles = { theme = "ivy" },
  help_tags = { theme = "ivy" },
  man_pages = { theme = "ivy" },
  marks = { theme = "ivy" },
  colorscheme = { theme = "ivy" },
  current_buffer_fuzzy_find = { theme = "ivy" },
}
