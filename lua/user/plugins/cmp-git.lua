return {
  "petertriho/cmp-git",
  requires = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
  config = function()
    require("cmp_git").setup {
      -- defaults
      filetypes = { "gitcommit", "NeogitCommitMessage" },
      remotes = { "upstream", "origin" }, -- in order of most to least prioritized
    }
  end,
}
