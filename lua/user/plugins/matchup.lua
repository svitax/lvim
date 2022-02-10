return {
  "andymass/vim-matchup",
  -- event = "CursorMoved",
  config = function()
    -- vim.g.matchup_matchparen_offscreen = { method = "popup", scrolloff = 1 }
    -- vim.g.matchup_matchparen_enabled = 0

    -- vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    -- vim.g.matchup_surround_enabled = 1
    -- vim.g.matchup_matchparen_deferred = 1
    lvim.builtin.treesitter.matchup.enable = true
  end,
}
