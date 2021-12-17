return {
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup {
      select = {
        telescope = {
          -- can be 'dropdown', 'cursor', or 'ivy'
          theme = "ivy",
        },
      },
    }
  end,
}
