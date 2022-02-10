return {
  "nvim-telescope/telescope-hop.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension "hop"
  end,
}
