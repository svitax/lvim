return {
  "gelguy/wilder.nvim",
  event = { "CursorHold", "CmdlineEnter" },
  rocks = { "luarocks-fetch-gitrec", "pcre2" },
  -- rocks = { "luarocks-fetch-gitrec" },
  requires = { { "romgrk/fzy-lua-native" }, { "nixprime/cpsm", run = "PY3=ON ./install.sh" } },
  config = function()
    vim.cmd(string.format("source %s", "~/.config/lvim/vimscript/wilder.vim"))
  end,
  run = ":UpdateRemotePlugins",
  --   run = "./install.sh",
}

-- { "nixprime/cpsm", run = "PY3=ON ./install.sh" },
-- {
--   "karb94/neoscroll.nvim",
--   event = "BufRead",
--   config = function()
--     require("neoscroll").setup {
--       easing_function = "quadratic", -- Default easing function
--       mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
--     }
--   end,
-- },
