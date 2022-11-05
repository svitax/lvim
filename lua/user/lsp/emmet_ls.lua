return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "scss" },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
        ["bem.element"] = "--",
        ["bem.modifier"] = "__",
        -- ["jsx.enabled"] = true,
      },
    },
  },
}
