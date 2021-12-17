return {
  "karb94/neoscroll.nvim",
  event = "BufRead",
  config = function()
    require("neoscroll").setup {
      easing_function = "quadratic", -- Default easing function
      mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
    }
  end,
}
