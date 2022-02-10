return {
  "plasticboy/vim-markdown",
  config = function()
    -- " Configuration for vim-markdown
    vim.g.vim_markdown_conceal = 2
    vim.g.vim_markdown_conceal_code_blocks = 0
    vim.g.vim_markdown_math = 1
    vim.g.vim_markdown_toml_frontmatter = 1
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_strikethrough = 1
    vim.g.vim_markdown_autowrite = 1
    vim.g.vim_markdown_edit_url_in = "tab"
    vim.g.vim_markdown_follow_anchor = 1
    vim.g.vim_markdown_auto_insert_bullets = 1
    vim.g.vim_markdown_new_list_item_indent = 0
  end,
  ft = { "md", "markdown", "rmd" },
}
