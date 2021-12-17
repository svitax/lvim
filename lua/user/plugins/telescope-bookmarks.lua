return {
  "dhruvmanila/telescope-bookmarks.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension "bookmarks"
  end,
}
