local M = {}

M.config = function()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  lvim.builtin.cmp.documentation.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

  lvim.builtin.cmp.experimental = {
    custom_menu = true,
    ghost_text = true,
    native_menu = false,
  }

  lvim.builtin.cmp.formatting.duplicates = {
    buffer = 0,
    path = 0,
    nvim_lsp = 0,
    nvim_lua = 1,
    luasnip = 1,
  }
  -- lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
  lvim.builtin.cmp.formatting.fields = { "kind", "abbr", "menu" }
  lvim.builtin.cmp.formatting.kind_icons = require("user.builtins.lsp_kind").symbols()

  lvim.builtin.cmp.formatting.source_names = {
    -- nvim_lsp_signature_help = "  ",
    -- nvim_lsp_signature_help = "(Sig)",
    nvim_lsp = "(LSP)",
    nvim_lua = "(Lua)",
    luasnip = "(Snip)",
    -- path = "  ",
    path = "(Path)",
    calc = "  ",
    -- cmp_git = "  ",
    cmp_git = "(Git)",
    conventionalcommits = "(CC)",
    -- cmp_tabnine = ""ﮧ"",
    emoji = "  ",
    buffer = "(Buffer)",
    fuzzy_buffer = "(Buffer)",
    -- npm = "[NPM]",
    rg = "(RG)",
    -- spell = " 暈",
    -- treesitter = "  ",
    treesitter = "(TS)",
    -- ["vim-dadbod-completion"] = "  ",
    orgmode = "(Org)", -- "  "
    cmdline = "(Cmd)",
    cmdline_history = "(Hist)",
    latex_symbols = "(Tex)",
    cmp_pandoc = "(Pandoc)",
    conjure = "(Conjure)",
  }

  -- sources haave to be in order of priority
  lvim.builtin.cmp.sources = {
    { name = "conjure" },
    -- { name = "nvim_lsp_signature_help" },
    { name = "cmp_pandoc" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path", max_item_count = 10 },
    { name = "calc" },
    { name = "cmp_git" },
    { name = "conventionalcommits" },
    -- { name = "cmp_tabnine", max_item_count = 3 },
    { name = "crates" },
    { name = "emoji" },
    { name = "buffer", max_item_count = 5, keyword_length = 5 },
    -- { name = "fuzzy_buffer", max_item_count = 5, keyword_length = 5 },
    -- { name = "npm", keyword_length = 4 },
    { name = "rg", max_item_count = 10 },
    -- { name = "spell", max_item_count = 5 },
    { name = "orgmode" },
    { name = "latex_symbols", max_item_count = 20 },
    -- { name = "treesitter" },
  }

  -- require("cmp").setup.cmdline(":", {
  --   sources = {
  --     { name = "cmdline" },
  --     { name = "cmdline_history" },
  --     { name = "path" },
  --   },
  -- })

  -- require("cmp").setup.cmdline("/", {
  --   sources = {
  --     -- { name = "nvim_lsp_document_symbol" },
  --     -- { name = "buffer" },
  --     -- { name = "cmdline_history" },
  --   },
  -- })

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end
  lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    elseif check_backspace() then
      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
    else
      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
      fallback()
    end
  end
  lvim.builtin.cmp.mapping["<S-Tab>"] = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, true), "")
      fallback()
    end
  end
  lvim.builtin.cmp.mapping["<CR>"] = function(fallback)
    if vim.bo.filetype == "tex" then
      lvim.builtin.cmp.confirm_opts.select = false
    else
      lvim.builtin.cmp.confirm_opts.select = true
    end
    if not cmp.confirm(lvim.builtin.cmp.confirm_opts) then
      -- if luasnip.jumpable() then
      --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-next", true, true, true), "")
      -- else
      --   fallback()
      -- end
      fallback()
    end
  end

  -- NOTE: I have it as Select because it lets me use ghost_text better.
  -- NOTE: If I decide not to use ghost_text, I can change this back to Insert
  -- lvim.builtin.cmp.mapping["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }
  -- lvim.builtin.cmp.mapping["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }
  -- lvim.builtin.cmp.mapping["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }
  -- lvim.builtin.cmp.mapping["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }
  lvim.builtin.cmp.mapping["<C-j>"] = cmp.mapping {
    i = cmp.mapping.select_next_item {
      behavior = cmp.SelectBehavior.Select,
    },
    c = cmp.mapping.select_next_item {
      behavior = cmp.SelectBehavior.Insert,
    },
  }
  lvim.builtin.cmp.mapping["<C-k>"] = cmp.mapping {
    i = cmp.mapping.select_prev_item {
      behavior = cmp.SelectBehavior.Select,
    },
    c = cmp.mapping.select_prev_item {
      behavior = cmp.SelectBehavior.Insert,
    },
  }

  lvim.builtin.cmp.mapping["<C-e>"] = cmp.mapping {
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }
  -- lvim.builtin.cmp.mapping["<Esc>"] = function(fallback)
  --   if cmp.visible() then
  --     cmp.close() -- cmp.mapping.close()
  --   else
  --     fallback()
  --   end
  -- end

  -- ["<C-Space>"] = cmp.mapping.complete(),
  --   ["<C-e>"] = cmp.mapping.close(),
  --   ["<CR>"] = cmp.mapping.confirm {
  --     behavior = cmp.ConfirmBehavior.Replace,
  --     select = true,
  --   },
end

return M
