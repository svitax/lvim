return function()
  lvim.lsp.override = { "sumneko_lua", "tsserver", "tailwindcss" }
  for _, server_name in pairs(lvim.lsp.override) do
    local lsp_installer_servers = require "nvim-lsp-installer.servers"
    local server_available, requested_server = lsp_installer_servers.get_server(server_name)
    if server_available then
      if not requested_server:is_installed() then
        if lvim.lsp.automatic_servers_installation then
          requested_server:install()
        else
          return
        end
      end
    end

    local default_config = {
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
      capabilities = require("lvim.lsp").common_capabilities(),
    }

    local status_ok, custom_config = pcall(require, "user/lsp/providers/" .. requested_server.name)
    if status_ok then
      local new_config = vim.tbl_deep_extend("force", default_config, custom_config)
      requested_server:setup(new_config)
    else
      requested_server:setup(default_config)
    end
  end

  -- Languages
  -- =========================================
  -- lvim.lsp.automatic_servers_installation = true
  -- lvim.lsp.override = { "dockerls", "sumneko_lua", "texlab", "tsserver", "rust_analyzer" }

  -- lvim.builtin.lspinstall.on_config_done = function()
  --   -- require("user.lsp.tailwind").setup()
  --   -- need to <C-space> to activate emmet snippets sometimes
  --   require("user.lsp.emmet").config()
  -- end
  -- require("user.lsp.emmet").config()
  -- require("user.json_schemas").setup()
end
