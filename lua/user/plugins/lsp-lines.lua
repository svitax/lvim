return {
  -- these virtual lines don't look so great with scrollbar
  -- and theyre kinda buggy when i tried a python file
  -- also should chang virtualtext highlights
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    vim.diagnostic.config { virtual_text = false }
    vim.wo.signcolumn = "yes"
    require("lsp_lines").register_lsp_virtual_lines()
  end,
}
