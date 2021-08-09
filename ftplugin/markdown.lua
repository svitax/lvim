print "im in markdown"
-- vim.cmd "set conceallevel=2"
-- -- TODO: markdown formatting not working with prettier
lvim.lang.markdown.formatters = {
  {
    exe = "prettier",
    args = {},
    -- args = { "--stdin", "--stdin-filepath", "$FILENAME", "--write" },
  },
}
lvim.lang.markdown.linters = {
  --   {
  --     -- TODO: install vale (copy from abzcoding/lvim)
  --     -- @usage can be write_good or vale or markdownlint
  --     -- exe = "vale",
  --     exe = "",
  --     args = {},
  --   },
  {
    exe = "markdownlint",
    args = {},
  },
}
