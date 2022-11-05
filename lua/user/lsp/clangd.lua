-- TODO: can I use nlsp-settings for this instead?
local capabilities = require("lvim.lsp").common_capabilities()
capabilities.offsetEncoding = { "utf-16" }
-- capabilities.fallbackFlags = { "-std=c++11" }
local init_option = { fallbackFlags = { "-std=c++17" } }

return {
  capabilities = capabilities,
  init_option = init_option,
}
