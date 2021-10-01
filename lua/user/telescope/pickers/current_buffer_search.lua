return function()
  local themes = require "telescope.themes"
  local builtin = require "telescope.builtin"
  local opts = {
    -- sort_lastused = true,
    -- sort_mru = true,
    -- sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  }
  local theme_opts = themes.get_dropdown {
    winblend = lvim.winblend,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  local grep_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  builtin.current_buffer_fuzzy_find(grep_conf)
end
