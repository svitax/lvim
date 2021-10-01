local M = {}

local utils = {

  check_back_space = function()
    local col = vim.fn.col "." - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
      return true
    else
      return false
    end
  end,

  T = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end,
}

M.config = function()
  local status_cmp_ok, cmp = pcall(require, "cmp")
  if not status_cmp_ok then
    return
  end
  local status_luasnip_ok, luasnip = pcall(require, "luasnip")
  if not status_luasnip_ok then
    return
  end
  local status_ok, tabout = pcall(require, "tabout")
  if not status_ok then
    return
  end

  tabout.setup {
    tabkey = "", -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    enable_backwards = true, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      -- { open = "+", close = ")" },
      { open = "{", close = "}" },
      -- { open = "<", close = ">" },

      -- { open = "", close = "]" },
      -- { open = " ", close = "]" },
      -- { open = "a", close = "]" },
      -- { open = "b", close = "]" },
      -- { open = "c", close = "]" },
      -- { open = "d", close = "]" },
      -- { open = "e", close = "]" },
      -- { open = "f", close = "]" },
      -- { open = "g", close = "]" },
      -- { open = "h", close = "]" },
      -- { open = "i", close = "]" },
      -- { open = "j", close = "]" },
      -- { open = "k", close = "]" },
      -- { open = "l", close = "]" },
      -- { open = "m", close = "]" },
      -- { open = "n", close = "]" },
      -- { open = "o", close = "]" },
      -- { open = "p", close = "]" },
      -- { open = "q", close = "]" },
      -- { open = "r", close = "]" },
      -- { open = "s", close = "]" },
      -- { open = "t", close = "]" },
      -- { open = "u", close = "]" },
      -- { open = "v", close = "]" },
      -- { open = "w", close = "]" },
      -- { open = "x", close = "]" },
      -- { open = "y", close = "]" },
      -- { open = "z", close = "]" },
      -- { open = "A", close = "]" },
      -- { open = "B", close = "]" },
      -- { open = "C", close = "]" },
      -- { open = "D", close = "]" },
      -- { open = "E", close = "]" },
      -- { open = "F", close = "]" },
      -- { open = "G", close = "]" },
      -- { open = "H", close = "]" },
      -- { open = "I", close = "]" },
      -- { open = "J", close = "]" },
      -- { open = "K", close = "]" },
      -- { open = "L", close = "]" },
      -- { open = "M", close = "]" },
      -- { open = "N", close = "]" },
      -- { open = "O", close = "]" },
      -- { open = "P", close = "]" },
      -- { open = "Q", close = "]" },
      -- { open = "R", close = "]" },
      -- { open = "S", close = "]" },
      -- { open = "T", close = "]" },
      -- { open = "U", close = "]" },
      -- { open = "V", close = "]" },
      -- { open = "W", close = "]" },
      -- { open = "X", close = "]" },
      -- { open = "Y", close = "]" },
      -- { open = "Z", close = "]" },
    },
    ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {}, -- tabout will ignore these filetypes
  }

  function _G.tab_binding()
    if vim.fn.pumvisible() ~= 0 then
      return utils.T "<C-n>"
    elseif luasnip.expand_or_jumpable() then
      return utils.T "<Plug>(luasnip-expand-or-jump)"
    else
      return utils.T "<Plug>(Tabout)"
    end
  end

  function _G.s_tab_binding(fallback)
    if vim.fn.pumvisible() == 1 then
      vim.fn.feedkeys(utils.T "<C-p>", "n")
    elseif luasnip.jumpable(-1) then
      vim.fn.feedkeys(utils.T "<Plug>luasnip-jump-prev", "")
    else
      fallback()
    end
  end
  --   -- Use (s-)tab to:
  --   --- jump to prev/next snippet's placeholder
  --   --- tabout of pair
  -- function _G.tab_binding()
  --     if vim.fn.call("vsnip#jumpable", { 1 }) == 1 then
  --       return utils.replace_keycodes "<Plug>(vsnip-jump-next)"
  --       -- elseif check_back_space() then
  --       --   return replace_keycodes "<Tab>"
  --       --   -- return replace_keycodes "<Plug>(Tabout)"
  --     else
  --       -- return vim.fn["compe#complete"]() -- < use this if you want <tab> to always offer completion
  --       -- return replace_keycodes "<Tab>"
  --       return utils.replace_keycodes "<Plug>(Tabout)"
  --       -- return utils.replace_keycodes "<Plug>(TaboutMulti)"
  --     end
  -- end

  --   function _G.s_tab_binding()
  --     if vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
  --       return utils.replace_keycodes "<Plug>(vsnip-jump-prev)"
  --     else
  --       return utils.replace_keycodes "<Plug>(TaboutBack)"
  --       -- return utils.replace_keycodes "<Plug>(TaboutBackMulti)"
  --     end
  --   end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_binding()", { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_binding()", { expr = true })
end

return M
