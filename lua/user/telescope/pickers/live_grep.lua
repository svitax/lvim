return function(cwd)
  local themes = require "telescope.themes"
  local builtin = require "telescope.builtin"
  local opts = {
    -- sort_lastused = true,
    -- sort_mru = true,
    -- sorting_strategy = "ascending",
    cwd = cwd,
    only_sort_text = true,
  }
  local theme_opts = themes.get_dropdown {
    winblend = lvim.winblend,
    layout_strategy = "vertical",
    layout_config = {
      vertical = { width = 0.9, height = 0.9, preview_height = 0.3 },
      -- prompt_position = "bottom",
      prompt_position = "top",
    },
  }

  local grep_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  builtin.live_grep(grep_conf)
end
