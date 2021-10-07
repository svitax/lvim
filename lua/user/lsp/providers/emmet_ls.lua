local M = {}

M.config = function()
  local lspconfig = require "lspconfig"
  local configs = require "lspconfig/configs"
  local util = require "lspconfig/util"

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  if not lspconfig.emmet_ls then
    configs.emmet_ls = {
      default_config = {
        cmd = { "emmet-language-server", "--stdio" },
        filetypes = {
          "html",
          "css",
          "sass",
          "scss",
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },

        root_dir = util.root_pattern("package.json", ".git"),
        settings = {},
      },
    }
  end
  lspconfig.emmet_ls.setup { capabilities = capabilities }
end

return M

-- local M = {}
--
-- M.setup = function()
--   local lspconfig = require "lspconfig"
--   local configs = require "lspconfig/configs"
--
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   }
--
--   if not lspconfig.emmet_ls then
--     configs.emmet_ls = {
--       default_config = {
--         cmd = { "emmet-ls", "--stdio" },
--         filetypes = {
--           "html",
--           "css",
--           "javascript",
--           "typescript",
--           "typescriptreact",
--           "javascriptreact",
--           -- "svelte",
--           -- "vue",
--           -- "eruby",
--         },
--         root_dir = function(_)
--           return vim.loop.cwd()
--         end,
--         settings = {},
--       },
--     }
--   end
--
--   lspconfig.emmet_ls.setup { capabilities = capabilities }
-- end
--
-- return M

--     {
--       "aca/emmet-ls",
--       config = function()
--         local lspconfig = require "lspconfig"
--         local configs = require "lspconfig/configs"
--
--         local capabilities = vim.lsp.protocol.make_client_capabilities()
--         capabilities.textDocument.completion.completionItem.snippetSupport = true
--         capabilities.textDocument.completion.completionItem.resolveSupport = {
--           properties = {
--             "documentation",
--             "detail",
--             "additionalTextEdits",
--           },
--         }
--
--         if not lspconfig.emmet_ls then
--           configs.emmet_ls = {
--             default_config = {
--               cmd = { "emmet-ls", "--stdio" },
--               filetypes = {
--                 "html",
--                 "css",
--                 "javascript",
--                 "typescript",
--                 "eruby",
--                 "typescriptreact",
--                 "javascriptreact",
--                 "svelte",
--                 "vue",
--               },
--               root_dir = function(fname)
--                 return vim.loop.cwd()
--               end,
--               settings = {},
--             },
--           }
--         end
--         lspconfig.emmet_ls.setup { capabilities = capabilities }
--       end,
--     },
--
