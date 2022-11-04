local M = {}

M.config = function()
  -- require("lvim.lsp.manager").setup "sqls"
  lvim.lsp.diagnostics.virtual_text = false
  lvim.lsp.document_highlight = true

  require("user.keymaps").set_lsp_buf_keymaps()

  -- ---@usage disable automatic installation of servers
  -- lvim.lsp.automatic_servers_installation = false

  ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
  ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
  -- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
  -- local opts = {} -- check the lspconfig documentation for a list of all possible options
  -- require("lvim.lsp.manager").setup("pyright", opts)

  -- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
  -- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
  -- vim.tbl_map(function(server)
  --   return server ~= "emmet_ls"
  -- end, lvim.lsp.automatic_configuration.skipped_servers)
end

return M
