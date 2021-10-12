local M = {}

M.config = function()
  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp" },
    -- { name = "cmp_tabnine", max_item_count = 3 },
    { name = "buffer", max_item_count = 5 },
    { name = "path", max_item_count = 5 },
    { name = "luasnip", max_item_count = 10 },
    { name = "nvim_lua" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    -- { name = "crates" },
  }
  lvim.builtin.cmp.documentation.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  lvim.builtin.cmp.experimental = {
    ghost_text = false,
    native_menu = false,
    custom_menu = true,
  }
  lvim.builtin.cmp.formatting.kind_icons = require("user.builtins.lsp_kind").symbols()
  lvim.builtin.cmp.formatting.source_names = {
    buffer = "(Buffer)",
    nvim_lsp = "(LSP)",
    luasnip = "(Snip)",
    treesitter = " ",
    nvim_lua = "(NvLua)",
    spell = " 暈",
    emoji = "  ",
    path = "  ",
    calc = "  ",
    -- cmp_tabnine = "  ",
  }
  -- lvim.builtin.cmp.formatting.duplicates = {
  --   buffer = 1,
  --   path = 1,
  --   nvim_lsp = 0,
  -- }
  -- lvim.builtin.cmp.formatting.duplicates_default = 0
  -- lvim.builtin.cmp.formatting = {
  --   format = function(entry, vim_item)
  --     local cmp_kind = require("user.builtins.lsp_kind").cmp_kind
  --     vim_item.kind = cmp_kind(vim_item.kind)
  --     vim_item.menu = ({
  --       buffer = "(Buffer)",
  --       nvim_lsp = "(LSP)",
  --       luasnip = "(Snip)",
  --       treesitter = " ",
  --       nvim_lua = "(NvLua)",
  --       spell = " 暈",
  --       emoji = "  ",
  --       path = "  ",
  --       calc = "  ",
  --       -- cmp_tabnine = "  ",
  --     })[entry.source.name]
  --     vim_item.dup = ({
  --       buffer = 1,
  --       path = 1,
  --       nvim_lsp = 0,
  --     })[entry.source.name] or 0
  --     return vim_item
  --   end,
  -- }

  local cmp = require "cmp"
  local luasnip = require "luasnip"
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
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
    else
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
      -- fallback()
    end
  end
  lvim.builtin.cmp.mapping["<S-Tab>"] = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, true), "")
      -- fallback()
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

  -- ["<C-Space>"] = cmp.mapping.complete(),
  --   ["<C-e>"] = cmp.mapping.close(),
  --   ["<CR>"] = cmp.mapping.confirm {
  --     behavior = cmp.ConfirmBehavior.Replace,
  --     select = true,
  --   },
end

return M
