-- TODO: markdown formatting not working with prettier
lvim.lang.markdown.formatters = {
  {
    exe = "prettier",
    args = {},
  },
}
lvim.lang.markdown.linters = {
  {
    -- TODO: install vale (copy from abzcoding/lvim)
    -- @usage can be write_good or vale or markdownlint
    -- exe = "vale",
    exe = "",
    args = {},
  },
}
