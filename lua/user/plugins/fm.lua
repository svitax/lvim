return {
  -- TODO: must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
  "is0n/fm-nvim",
  cmd = { "Lf", "Nnn", "Ranger" },
  config = function()
    require("fm-nvim").setup {
      border = "rounded",
      edit_cmd = "edit",
      height = 0.90,
      width = 0.90,
      -- mappings = {
      --   vert_split = "<C-v>",
      --   horz_split = "<C-s>",
      --   tabedit = "<C-t>",
      --   edit = "<C-e>",
      -- },
    }
  end,
}
