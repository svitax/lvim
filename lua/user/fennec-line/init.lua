local colors = require "user.lualine.colors"

local M = {}
M.init = function()
  lvim.builtin.lualine.options = {
    icons_enabled = true,
    disabled_filetypes = {},
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme.
      -- So we are just setting default looks o statusline
      normal = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.fg2, bg = colors.bg },
        b = { fg = colors.fg2, bg = colors.bg },
        c = { fg = colors.fg2, bg = colors.bg },
        x = { fg = colors.fg2, bg = colors.bg },
        y = { fg = colors.fg2, bg = colors.bg },
        z = { fg = colors.fg2, bg = colors.bg },
      },
    },
  }
  lvim.builtin.lualine.sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  }
  lvim.builtin.lualine.inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  }
end
return M
