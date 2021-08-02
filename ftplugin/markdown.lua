-- lvim.lang.markdown.formatters = {
--   {
--     exe = "prettier",
--     args = {},
--   },
-- }
-- lvim.lang.markdown.linters = {
--   {
--     -- @usage can be write_good or vale or markdownlint
--     -- exe = "vale",
--     exe = "",
--     args = {},
--   },
-- }

-- TODO: markdown formatting not working with prettier
lvim.lang.markdown = {
  formatters = {
    {
      exe = "prettier",
      args = {},
    },
  },
  -- TODO: install vale (copy from abzcoding/lvim)
  linters = {
    -- exe = "vale",
    exe = "",
    args = {},
  },
  lsp = {
    provider = "",
    setup = {},
  },
}
