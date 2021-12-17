return {
  "CosmicNvim/cosmic-ui",
  requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "ray-x/lsp_signature.nvim" },
  config = function()
    require("cosmic-ui").setup {
      diagnostic = false,
      rename = false,
    }
  end,
  after = "nvim-lspconfig",
}
