local M = {}

M.config = function()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end
  lvim.builtin.cmp.formatting.source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
    -- nvim_lua = "(Lua)",
  }

  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "cmp_tabnine" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "tmux" },
  }
end

return M
