lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.document_highlight = true

lvim.lsp.on_attach_callback = function(client, bufnr)
  require("lsp-inlayhints").on_attach(client, bufnr)
  if client.server_capabilities.colorProvider then
    -- Attach document colour support
    require("document-color").buf_attach(bufnr)
  end
end

require("user.keymaps").set_lsp_buf_keymaps()

-- NOTE: need to skip cssls so I can do my custom config later in after/ftplugin/
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "cssls" })
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "sumneko_lua" })

lvim.lsp.diagnostics.signs.values = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

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
