return {
  "mg979/vim-visual-multi",
  -- event = "WinEnter",
  config = function()
    vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi theming
    -- vim.g.VM_default_mappings = false
    vim.cmd "let g:VM_default_mappings = 0"
    vim.cmd "let g:VM_custom_motions = {';': 'l', 'l': 'h', 'h': ';'}"
    vim.cmd "let g:VM_maps = {}"
    vim.cmd "let g:VM_maps['Find Under'] = '<C-y>'" -- replace C-n
    vim.cmd "let g:VM_maps['Find Subword Under'] = '<C-y>'" -- replace visual C-n
    -- vim.cmd "let g:VM_maps['Select Cursor Down'] = '<C-Down>'"
    -- vim.cmd "let g:VM_maps['Select Cursor Up']   = '<C-Up>'"
    -- vim.cmd "let g:VM_maps['Add Cursor At Pos']  = '<C-m>'"
  end,
}
