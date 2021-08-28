local lualine = require "lualine"
local config = require "user.lualine.init"

-- some web-devicon overrides (I need a better place for this)
-- ﱮ (maybe this should be the default if file_icon not found)
-- default color = "#6d8086",
-- some extra icons         
require("nvim-web-devicons").setup {
  override = {
    norg = {
      icon = "",
      color = "#558140",
      name = "Norg",
    },
    org = {
      icon = "",
      color = "#d3869b",
      name = "Org",
    },
    -- sh = {
    --   icon = "",
    --   color = "#a9b665",
    --   name = "Shell",
    -- },
  },
}

-- this registers all of my components
require "user.lualine.components"

-- Now don't forget to initialize lualine
lualine.setup(config)
