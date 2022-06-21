local M = {}

M.tab = function(fallback)
  local methods = require("lvim.core.cmp").methods
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  local status_ok, neogen = pcall(require, "neogen")
  if not status_ok then
    return
  end

  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.api.nvim_get_mode().mode == "c" then
    fallback()
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif methods.jumpable() then
    luasnip.jump(1)
  elseif neogen.jumpable() then
    neogen.jump_next()
  elseif methods.check_backspace() then
    fallback()
  else
    methods.feedkeys("<Plug>(Tabout)", "")
  end
end

M.shift_tab = function(fallback)
  local methods = require("lvim.core.cmp").methods
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  local status_ok, neogen = pcall(require, "neogen")
  if not status_ok then
    return
  end

  if cmp.visible() then
    cmp.select_prev_item()
  elseif vim.api.nvim_get_mode().mode == "c" then
    fallback()
  elseif methods.jumpable(-1) then
    luasnip.jump(-1)
  elseif neogen.jumpable(true) then
    neogen.jump_prev()
  elseif methods.check_backspace() then
    fallback()
  else
    methods.feedkeys("<Plug>(Tabout)", "")
  end
end

M.config = function()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources {
      { name = "git" },
      { name = "buffer" },
      { name = "rg" },
    },
  })

  -- if lvim.work then
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.insert {
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    },
    sources = {
      { name = "cmdline" },
      -- { name = "cmdline_history" },
      { name = "path" },
    },
    formatting = {
      max_width = 30,
    },
  })

  for _, cmd_type in ipairs { "/", "?", "@" } do
    cmp.setup.cmdline(cmd_type, {
      mapping = cmp.mapping.preset.insert {
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      },
      sources = {
        { name = "buffer" },
        -- { name = "cmdline_history" },
      },
    })
  end
  -- end

  lvim.builtin.cmp.sources = {
    { name = "kitty", priority = 100 },
    { name = "nvim_lsp", priority = 100 },
    { name = "path" },
    { name = "luasnip", priority = 90 },
    { name = "nvim_lua", priority = 80 },
    -- { name = "cmp_tabnine", priority = 70, max_item_count = 5 },
    { name = "buffer", priority = 60 },
    -- { name = "rg", max_item_count = 5, priority = 50 },
    { name = "git" },
    { name = "markdown-link" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "tmux" },
    { name = "plugins" },
  }

  lvim.builtin.cmp.formatting.source_names = {
    cmdline = "(Cmd)",
    cmdline_history = "(Hist)",
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    -- cmp_tabnine = "(Tabnine)",
    tmux = "(TMUX)",
    nvim_lua = "(Lua)",
    rg = "(Ripgrep)",
    kitty = "(Kitty)",
    git = "(Git)",
    ["markdown-link"] = "(Markdown)",
    plugins = "(Plugins)",
  }

  local icons = require "user.icons"
  lvim.builtin.cmp.formatting.max_width = 30
  lvim.builtin.cmp.formatting.fields = { "kind", "abbr", "menu" }
  lvim.builtin.cmp.formatting.format = function(entry, vim_item)
    if entry.source.name == "cmdline" then
      vim_item.kind = "⌘"
      vim_item.menu = ""
      return vim_item
    end
    vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name] or vim_item.kind
    vim_item.kind = icons.kind[vim_item.kind] or vim_item.kind

    return vim_item
  end

  lvim.builtin.cmp.sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      -- require "cmp_tabnine.compare",
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  }

  lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(M.tab, { "i", "c" })
  lvim.builtin.cmp.mapping["<S-Tab>"] = cmp.mapping(M.shift_tab, { "i", "c" })
  lvim.builtin.cmp.mapping["<C-u>"] = cmp.mapping.scroll_docs(-4)
  lvim.builtin.cmp.mapping["<C-d>"] = cmp.mapping.scroll_docs(4)
end

return M
