-- TODO: can I use nlsp-settings for this instead?
local capabilities = require("lvim.lsp").common_capabilities()
capabilities.offsetEncoding = { "utf-16" }
-- capabilities.fallbackFlags = { "-std=c++11" }
local init_option = { fallbackFlags = { "-std=c++17" } }
require("lspconfig").clangd.setup { capabilities = capabilities, init_option = init_option }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "uncrustify", filetypes = { "cpp" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "cppcheck", filetypes = { "cpp" } },
  -- { command = "gccdiag", filetypes = { "cpp", "c" } },
}
