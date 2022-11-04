local M = {}

M.config = function()
  -- lvim.colorscheme = "fennec-gruvbox"

  -- gruvbox-baby config
  lvim.colorscheme = "gruvbox-baby"
  vim.g.gruvbox_baby_background_color = "dark"
  vim.g.gruvbox_baby_telescope_theme = 1
  -- vim.g.gruvbox_baby_use_original_palette = false
  vim.g.gruvbox_baby_color_overrides = {
    foreground = "#ebdbb2",
    soft_green = "#a9b665",
    forest_green = "#689d6a",
    soft_yellow = "#d1b171",
    light_blue = "#7daea3",
    -- blue_gray = "#89b482",
    magenta = "#ce8196",
    orange = "#e78a4e",
    gray = "#DEDEDE",
    comment = "#665c54",
    red = "#ec6b64",
    error_red = "#c14a4a",
    diff = {
      add = "#26332c",
      change = "#594e36",
      delete = "#572E33",
      text = "#314753",
    },
  }
  local c = require("gruvbox-baby.colors").config()
  -- vim.g.gruvbox_baby_highlights = { Normal = { fg = colors.orange } }
  vim.g.gruvbox_baby_highlights = {
    -- Normal = { fg = "#123123", bg = "NONE", style = "underline" },
    -- START navic
    NavicIconsFile = { fg = c.comment },
    NavicIconsModule = { fg = c.soft_yellow },
    NavicIconsNamespace = { fg = c.comment },
    NavicIconsPackage = { fg = c.comment },
    NavicIconsClass = { fg = c.orange },
    NavicIconsMethod = { fg = c.blue_gray },
    NavicIconsProperty = { fg = c.clean_green },
    NavicIconsField = { fg = c.clean_green },
    NavicIconsConstructor = { fg = c.orange },
    NavicIconsEnum = { fg = c.orange },
    NavicIconsInterface = { fg = c.orange },
    NavicIconsFunction = { fg = c.blue_gray },
    NavicIconsVariable = { fg = c.pink },
    NavicIconsConstant = { fg = c.pink },
    NavicIconsString = { fg = c.clean_green },
    NavicIconsNumber = { fg = c.orange },
    NavicIconsBoolean = { fg = c.orange },
    NavicIconsArray = { fg = c.orange },
    NavicIconsObject = { fg = c.orange },
    NavicIconsKey = { fg = c.magenta },
    NavicIconsKeyword = { fg = c.magenta },
    NavicIconsNull = { fg = c.orange },
    NavicIconsEnumMember = { fg = c.clean_green },
    NavicIconsStruct = { fg = c.orange },
    NavicIconsEvent = { fg = c.orange },
    NavicIconsOperator = { fg = c.comment },
    NavicIconsTypeParameter = { fg = c.clean_green },
    NavicText = { fg = c.comment },
    NavicSeparator = { fg = c.comment },
    -- END navic

    -- START leap.nvim
    LeapBackdrop = { fg = c.comment },
    -- LeapMatch = { fg = c.foreground, style = "bold" },
    -- END leap.nvim

    -- START yanky.nvim
    YankyPut = { bg = c.background_light },
    YankyYanked = { bg = c.medium_gray },
    -- END yanky.nvim

    -- START package-info
    PackageInfoOutdatedVersion = { fg = c.orange },
    PackageInfoUpToDateVersion = { fg = c.comment },
    -- END package-info
  }
  vim.api.nvim_set_hl(0, "LeapMatch", {
    fg = c.foreground, -- for light themes, set to 'black' or similar
    bold = true,
    nocombine = true,
  })
end

return M
