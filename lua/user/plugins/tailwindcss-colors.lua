-- This plugin highlights Tailwind CSS class names
-- when @tailwindcss/language-server is connected via the neovim built-in
-- lsp client.

return {
  "themaxmarchuk/tailwindcss-colors.nvim",
  -- don't load on startup
  opt = true,
  -- load only on require("tailwindcss-colors")
  module = "tailwindcss-colors",
  -- run the setup function after plugin is loaded
  config = function()
    -- pass config options here (or nothing to use defaults)
    require("tailwindcss-colors").setup()
  end,
}
