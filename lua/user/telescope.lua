local M = {}

M.config = function()
  -- lvim.builtin.telescope.defaults.mappings.i["<C-h>"] = require("telescope").extensions.hop.hop
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.n["q"] = actions.close
  lvim.builtin.telescope.defaults.path_display.shorten = 4
  lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
  lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
  lvim.builtin.telescope.defaults.layout_config.horizontal = {
    width_padding = 0.04,
    height_padding = 0.1,
    preview_width = 0.6,
  }
  lvim.builtin.telescope.defaults.layout_config.vertical = {
    width_padding = 0.05,
    height_padding = 1,
    preview_height = 0.5,
  }
end

return M
