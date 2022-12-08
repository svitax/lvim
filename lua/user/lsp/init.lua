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
-- NOTE: need to skip gopls so lsp-inlayhints can attach.
-- TODO: check if skipping server config can be avoided if I attach lsp-inlayhints through an autocommand (look at the README.)
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })
-- NOTE: skip tailwindcss because I only want to load it if a project has a tailwindcss dependency (see after/ftplugin)
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "cssls" })
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "sumneko_lua" })

lvim.lsp.diagnostics.signs.values = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

local lspconfig = require "lspconfig"
require("lspconfig.configs").fennel_language_server = {
  default_config = {
    -- replace it with true path
    cmd = { "/home/svitax/.cargo/bin/fennel-language-server" },
    filetypes = { "fennel", "fnl" },
    single_file_support = true,
    -- source code resides in directory `fnl/`
    root_dir = lspconfig.util.root_pattern "fnl",
    settings = {
      fennel = {
        workspace = {
          -- If you are using hotpot.nvim or aniseed,
          -- make the server aware of neovim runtime files.
          library = vim.api.nvim_list_runtime_paths(),
        },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}
lspconfig.fennel_language_server.setup {}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  require("user.lsp.formatters").fnlfmt,
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
