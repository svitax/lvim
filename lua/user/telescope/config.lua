-- local builtin = require "telescope.builtin"
-- local themes = require "telescope.themes"
-- local previewers = require "telescope.previewers"
-- local conf = require('telescope.config')

-- Defaults
-- =========================================
return function()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.winblend = lvim.winblend
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      -- ["<esc>"] = actions.close,
      ["<C-y>"] = actions.which_key,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
    n = {
      [";"] = actions.select_default,
      ["<esc>"] = actions.close,
      ["q"] = actions.close,
    },
  }
  lvim.builtin.telescope.defaults.layout_strategy = "bottom_pane"
  lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
  lvim.builtin.telescope.defaults.layout_config.horizontal = {
    width = 0.9,
    height = 0.9,
    width_padding = 0.04,
    height_padding = 0.1,
    preview_width = 0.6,
  }
  lvim.builtin.telescope.defaults.layout_config.vertical = {
    width = 0.9,
    height = 0.9,
    width_padding = 0.05,
    height_padding = 1,
    preview_height = 0.5,
  }
  lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
  lvim.builtin.telescope.defaults.sort_lastused = true
  lvim.builtin.telescope.defaults.sort_mru = true
  -- lvim.builtin.telescope.defaults.path_display.shorten = 10
  lvim.builtin.telescope.defaults.path_display = function(_, path)
    -- would be cool if instead of the path we could show the project
    local tail = require("telescope.utils").path_tail(path)
    return string.format("%s (%s)", tail, path)
  end

  lvim.builtin.telescope.on_config_done = function()
    -- require("telescope").load_extension "fzf"
    require("telescope").load_extension "neoclip"
    -- require("telescope").load_extension "npm"
  end

  -- lvim.builtin.telescope.extensions.fzf = {
  --   fuzzy = true, -- false will only do exact matching
  --   override_generic_sorter = false, -- override the generic sorter
  --   override_file_sorter = true, -- override the file sorter
  --   case_mode = "smart_case", -- or "ignore_case" or "respect_case"
  --   -- the default case_mode is "smart_case"
  -- }
  lvim.builtin.telescope.extensions.frecency = {
    show_scores = true,
    show_unindexed = false,
    workspaces = {
      ["dot"] = "~/.config",
      ["lvim"] = "~/.config/lvim",
      ["web"] = "/home/svitax/Desktop/code/web",
      ["code"] = "/home/svitax/Desktop/code",
      -- ["wiki"] = "/home/my_username/wiki",
    },
  }
end
