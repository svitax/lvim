return {
  "jakewvincent/mkdnflow.nvim",
  config = function()
    require("mkdnflow").setup {
      -- Config goes here; leave blank for defaults
      default_mappings = true,
      create_dirs = true,
      links_relative_to = "current",
      filetypes = { md = true, rmd = true, markdown = true },
      evaluate_prefix = true,
      new_file_prefix = [[os.date('%Y-%m-%d_')]],
      wrap_to_beginning = true,
      wrap_to_end = true,
    }
  end,
  event = "BufRead",
}
