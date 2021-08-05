local M = {}

M.config = function()
  -- Vim Markdown
  vim.g.vim_markdown_folding_disabled = 0
  vim.g.vim_markdown_math = 1
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_conceal = 3
  -- vim.cmd("set conceallevel=2")
  vim.g.vim_markdown_follow_anchor = 1
  vim.g.vim_markdown_no_extensions_in_markdown = 1
  vim.g.vim_markdown_autowrite = 1
  -- vim.cmd("let g:markdown_fenced_languages = ['python']")
end

return M
