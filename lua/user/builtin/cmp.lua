local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
  return
end

local luasnip = require "luasnip"
local methods = require("lvim.core.cmp").methods
local types = require "cmp.types"

local tab = function(fallback)
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
    -- else
    --   methods.feedkeys("<Plug>(Tabout)", "")
  end
end

local shift_tab = function(fallback)
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
    -- else
    --   methods.feedkeys("<Plug>(Tabout)", "")
  end
end

cmp.setup.filetype("markdown", {
  mapping = cmp.mapping.preset.insert {
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources {
    { name = "conventionalcommits" },
    { name = "git" },
    { name = "buffer" },
    -- { name = "rg" },
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

lvim.builtin.cmp.experimental.ghost_text = true
lvim.builtin.cmp.sources = {
  { name = "kitty", priority = 100 },
  {
    name = "nvim_lsp",
    priority = 100,
    entry_filter = function(entry, ctx)
      local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
      if kind == "Snippet" and ctx.prev_context.filetype == "java" then
        return false
      end
      if kind == "Text" then
        return false
      end
      return true
    end,
  },
  -- { name = "cmdline" },
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
  { name = "vim-dadbod-completion" },
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
  name = "(CC)",
  git = "(Git)",
  plugins = "(Plugins)",
  ["vim-dadbod-completion"] = "(DB)",
}

-- local icons = lvim.icons
lvim.builtin.cmp.formatting.max_width = 30
lvim.builtin.cmp.formatting.format = function(entry, vim_item)
  local max_width = lvim.builtin.cmp.formatting.max_width
  if max_width ~= 0 and #vim_item.abbr > max_width then
    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
  end
  if lvim.use_icons then
    vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]

    if entry.source.name == "copilot" then
      vim_item.kind = lvim.icons.git.Octoface
      vim_item.kind_hl_group = "CmpItemKindCopilot"
    end

    if entry.source.name == "cmp_tabnine" then
      vim_item.kind = lvim.icons.misc.Robot
      vim_item.kind_hl_group = "CmpItemKindTabnine"
    end

    if entry.source.name == "crates" then
      vim_item.kind = lvim.icons.misc.Package
      vim_item.kind_hl_group = "CmpItemKindCrate"
    end

    if entry.source.name == "lab.quick_data" then
      vim_item.kind = lvim.icons.misc.CircuitBoard
      vim_item.kind_hl_group = "CmpItemKindConstant"
    end

    if entry.source.name == "emoji" then
      vim_item.kind = lvim.icons.misc.Smiley
      vim_item.kind_hl_group = "CmpItemKindEmoji"
    end
  end

  if entry.source.name == "nvim_lsp" then
    vim_item.menu = "(" .. entry.source.source.client.name .. ")"
  else
    vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name]
    vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name] or lvim.builtin.cmp.formatting.duplicates_default
  end

  return vim_item
end

-- NOTE: deprioritize emmet_ls snippet
local function deprioritize_snippet(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end
lvim.builtin.cmp.sorting = {
  priority_weight = 2,
  comparators = {
    deprioritize_snippet,
    cmp.config.compare.offset,
    cmp.config.compare.exact,
    cmp.config.compare.scopes,
    cmp.config.compare.score,
    cmp.config.compare.recently_used,
    cmp.config.compare.locality,
    cmp.config.compare.kind,
    cmp.config.compare.sort_text,
    cmp.config.compare.length,
    cmp.config.compare.order,
  },
}

lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(tab, { "i", "c" })
lvim.builtin.cmp.mapping["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "c" })
lvim.builtin.cmp.mapping["<A-u>"] = cmp.mapping.scroll_docs(-4)
lvim.builtin.cmp.mapping["<A-d>"] = cmp.mapping.scroll_docs(4)
