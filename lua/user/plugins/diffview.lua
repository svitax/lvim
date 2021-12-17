return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  config = function()
    require("diffview").setup {
      enhanced_diff_hl = true,
      file_panel = {
        position = "right",
      },
      key_bindings = {
        file_panel = { q = "<Cmd>DiffviewClose<CR>" },
        view = { q = "<Cmd>DiffviewClose<CR>" },
      },
    }
  end,
}
