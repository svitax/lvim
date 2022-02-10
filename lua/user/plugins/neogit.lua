return {
  "TimUntersberger/neogit",
  requires = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    local neogit = require "neogit"
    neogit.setup {
      disable_context_highlighting = true,
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
      use_magit_keybindings = true
    }
    -- neogit.config.use_magit_keybindings()
  end,
}
