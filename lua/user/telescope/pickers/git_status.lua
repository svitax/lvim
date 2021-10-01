return function()
  local themes = require "telescope.themes"
  local builtin = require "telescope.builtin"
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  builtin.git_status(opts)
end
