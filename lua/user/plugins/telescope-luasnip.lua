return {
  "benfowler/telescope-luasnip.nvim",
  -- module = "telescope._extensions.luasnip", -- if you wish to lazy-load
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension "luasnip"
  end,
}
