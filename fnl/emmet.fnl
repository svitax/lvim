(local lspconfig (require :lspconfig))
(local configs (require :lspconfig/configs))
(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem.snippetSupport true)
(when (not lspconfig.emmet_ls)
  (set configs.emmet_ls
       {:default_config {:cmd {1 :emmet-ls 2 :--stdio}
                         :filetypes {1 :html
                                     2 :css
                                     3 :svelte
                                     4 :javascript
                                     5 :typescript
                                     6 :typescriptreact
                                     7 :javascriptreact
                                     8 :vue}
                         :root_dir (fn [_]
                                     (vim.loop.cwd))
                         :settings {}}}))
(lspconfig.emmet_ls.setup {: capabilities})	
