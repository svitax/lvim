local M = {}

M.config = function()
  -- Additional Plugins
  lvim.plugins = {
    { "luisiacc/gruvbox-baby" },
    { "svitax/fennec-gruvbox.nvim", branch = "gruvbox-baby" },
    {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = require("nvim-gps").setup {},
    },
    {
      "gfeiyou/command-center.nvim",
      requires = "nvim-telescope/telescope.nvim",
      config = require("user.plugins.command_center").config(),
    },
    {
      "mrjones2014/legendary.nvim",
      config = require("user.plugins.legendary").config(),
    },
    {
      "stevearc/dressing.nvim",
      config = require("user.plugins.dressing").config(),
    },
    {
      "ggandor/lightspeed.nvim",
      config = require("user.plugins.lightspeed").config(),
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = require("user.plugins.colorizer").config(),
      -- event = "BufRead",
    },
    { "folke/trouble.nvim", cmd = "TroubleToggle" },
    {
      "numToStr/Navigator.nvim",
      config = require("Navigator").setup(),
    },
    {
      "kwkarlwang/bufjump.nvim",
      config = require("bufjump").setup(),
    },
    {
      "ghillb/cybu.nvim",
      requires = { "kyazdani42/nvim-web-devicons" }, --optional
      config = require("user.plugins.cybu").config(),
    },
    {
      "kazhala/close-buffers.nvim",
      event = "BufRead",
      config = require("user.plugins.close_buffers").config(),
      -- cmd = { "BDelete", "BDelete!", "BWipeout", "BWipeout!" },
    },
    { -- TODO: must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
      "is0n/fm-nvim",
      cmd = { "Lf", "Nnn", "Ranger" },
      config = require("user.plugins.fm").config(),
    },
  }
end

return M
