return {
  "lazytanuki/nvim-mapper",
  before = "telescope.nvim",
  config = function()
    require("nvim-mapper").setup {
      no_map = true,
      search_path = os.getenv "HOME" .. "/.config/lvim/lua",
      -- Available actions:
      --   * "definition" - Go to keybind definition (default)
      --   * "execute" - Execute the keybind command
      action_on_enter = "definition",
    }
    require("telescope").load_extension "mapper"
  end,
}
