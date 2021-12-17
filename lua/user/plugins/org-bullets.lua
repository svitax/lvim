return {
  "akinsho/org-bullets.nvim",
  config = function()
    -- require("user.orgmode").org_bullets_setup()
    local status_ok, org_bullets = pcall(require, "org-bullets")
    if not status_ok then
      return
    end
    org_bullets.setup {
      -- f16e, f21a
      symbols = { "◉", "○", "✸", "✿", "♥", "", "", "", "" },
    }
  end,
}
