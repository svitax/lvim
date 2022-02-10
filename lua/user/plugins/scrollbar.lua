return {
  "petertriho/nvim-scrollbar",
  config = function()
    local c = require("user.theme").gruvchad()
    require("scrollbar").setup {
      handle = {
        color = c.one_bg2,
      },
      marks = {
        Search = { color = c.orange },
        Error = { color = c.red },
        Warn = { color = c.yellow },
        Info = { color = c.green },
        Hint = { color = c.purple },
        Misc = { color = c.dark_purple },
      },
    }
  end,
}
