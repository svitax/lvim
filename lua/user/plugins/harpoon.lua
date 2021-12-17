return {
  "ThePrimeagen/harpoon",
  event = "WinEnter",
  config = function()
    require("harpoon").setup {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    }
  end,
}
