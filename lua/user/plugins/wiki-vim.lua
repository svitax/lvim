return {
  "lervag/wiki.vim",
  config = function()
    vim.g.wiki_root = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax"
    vim.g.wiki_filetypes = { "md" }
    vim.g.wiki_link_target_type = "md" -- md style links or wiki style links
    vim.g.wiki_mappings_use_defaults = "local" -- all, local, global, or none
  end,
}
