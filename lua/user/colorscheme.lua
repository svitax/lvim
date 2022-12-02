local M = {}

M.config = function()
  -- lvim.colorscheme = "fennec-gruvbox"

  -- gruvbox-baby config
  lvim.colorscheme = "gruvbox-baby"
  vim.g.gruvbox_baby_background_color = "dark"
  vim.g.gruvbox_baby_telescope_theme = 1
  -- vim.g.gruvbox_baby_use_original_palette = false
  vim.g.gruvbox_baby_color_overrides = {
    foreground = "#d4be98",
    soft_green = "#a9b665",
    forest_green = "#689d6a",
    soft_yellow = "#d8a657",
    light_blue = "#7daea3",
    blue_gray = "#89b482",
    magenta = "#d3869b",
    orange = "#e78a4e",
    gray = "#DEDEDE",
    -- comment = "#928374",
    red = "#ea6962",
    error_red = "#ea6962",
    diff = {
      add = "#26332c",
      change = "#594e36",
      delete = "#572E33",
      text = "#314753",
    },
  }
  local c = require("gruvbox-baby.colors").config()
  c = vim.tbl_deep_extend("force", c, vim.g.gruvbox_baby_color_overrides)

  vim.g.gruvbox_baby_highlights = {
    GitSignsCurrentLineBlam = { fg = "#928374" },
    TSKeyword = { fg = c.red },
    TSKeywordFunction = { fg = c.red },
    TSConditional = { fg = c.red },
    NormalFloat = { bg = "#1e2021", fg = c.foreground },
    FloatBorder = { bg = "#1e2021", fg = c.foreground },
    -- Normal = { fg = "#123123", bg = "NONE", style = "underline" },
    Search = { fg = c.background, bg = c.foreground },
    IncSearch = { fg = c.forest_green, bg = c.comment },

    -- START treesitter-context
    TreesitterContext = { bg = "#3c3836", fg = c.foreground },
    -- TreesitterContextLineNumber = { bg = "#3c3836", fg = c.foreground },
    -- TreesitterContextBottom = { style = "underline" },
    -- END treesitter-context
    --
    -- START hlargs
    Hlargs = { fg = c.blue_gray },
    -- END hlargs

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

    -- START diagnostics
    DiagnosticError = { fg = c.red },
    DiagnosticWarn = { fg = c.soft_yellow },
    DiagnosticInfo = { fg = c.light_blue },
    -- DiagnosticHint = { fg = c.forest_green },
    -- END diagnostics
  }
  vim.api.nvim_set_hl(0, "LeapMatch", {
    fg = c.foreground, -- for light themes, set to 'black' or similar
    bold = true,
    nocombine = true,
  })
end

return M
