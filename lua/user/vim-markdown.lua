local M = {}

M.config = function()
  -- Vim Markdown
  vim.g.vim_markdown_folding_disabled = 0
  -- vim.g.vim_markdown_folding_style_pythonic = 1 -- fold in a style like python-mode,
  -- vim.g.vim_markdown_override_foldtext = 0 -- prevent foldtext from being set
  vim.g.vim_markdown_folding_level = 6 -- Folding level is a number between 1 and 6
  -- vim.g.vim_markdown_no_default_key_mappings = 1 -- disable default keymappings
  -- vim.g.vim_markdown_toc_autofit = 1 -- Allow for the TOC window to auto-fit
  -- vim.g.vim_markdown_conceal = 1 -- disable markdown conceal
  -- vim.cmd "set conceallevel=2"
  -- vim.g.tex_conceal = "" -- disable math conceal
  -- vim.g.vim_markdown_conceal_code_blocks = 0 -- disable conceal for code fences
  vim.g.vim_markdown_follow_anchor = 1 -- allows `ge` command to follow named anchors (file#anchor)
  vim.g.vim_markdown_math = 1
  vim.g.vim_markdown_frontmatter = 1 -- Highlight YAML front matter (Jekyll/Hugo)
  -- vim.g.vim_markdown_toml_frontmatter = 1 -- Highlight TOML front matter (Hugo) requires vim-toml
  -- vim.g.vim_markdown_json_frontmatter = 1 -- Highlight JSON front matter (Hugo) requires vim-json
  vim.g.vim_markdown_strikethrough = 1 -- Strikethrough uses two tildes
  -- vim.g.vim_markdown_new_list_item_indent = 2 -- indents new list items (with 2 spaces)
  vim.g.vim_markdown_no_extensions_in_markdown = 1 -- follow link with `ge` without needing the .md extension in link url
  vim.g.vim_markdown_autowrite = 1 -- save any edits made before moving with `ge`
  -- vim.g.vim_markdown_auto_extension_ext = "txt" -- use other file extensions
  vim.g.vim_markdown_auto_insert_bullets = 0 -- disable automatic bulletpoint insertion (don't forget to set new list indent to 0)
  -- vim.g.vim_markdown_edit_url_in = 'tab' -- possible values are tab, vsplit, hsplit, current
  -- vim.cmd("let g:markdown_fenced_languages = ['python']")
end

return M
