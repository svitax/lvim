local utils = require "user.lualine.utils"

return {
  -- my_extension = { sections = { lualine_c = { "mode" } }, filetypes = { "lua" } },
  nerdtree = {
    sections = {
      lualine_c = {
        function()
          return "  " .. utils.get_short_cwd()
          -- פּ
        end,
      },
    },
    filetypes = { "NvimTree" },
  },
}
