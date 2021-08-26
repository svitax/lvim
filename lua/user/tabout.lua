local M = {}

local utils = {

  -- check_back_space = function()
  --   local col = vim.fn.col "." - 1
  --   if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
  --     return true
  --   else
  --     return false
  --   end
  -- end,

  replace_keycodes = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end,
}

M.config = function()
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
    completion = false, -- if the tabkey is used in a completion pum
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "<", close = ">" },
      { open = "_", close = "_" },
      { open = "*", close = "*" },
      { open = "%", close = "%" },
    },
    ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {}, -- tabout will ignore these filetypes
  }

  -- Use (s-)tab to:
  --- jump to prev/next snippet's placeholder
  --- tabout of pair
  function _G.tab_binding()
    if vim.fn.call("vsnip#jumpable", { 1 }) == 1 then
      return utils.replace_keycodes "<Plug>(vsnip-jump-next)"
      -- elseif check_back_space() then
      --   return replace_keycodes "<Tab>"
      --   -- return replace_keycodes "<Plug>(Tabout)"
    else
      -- return vim.fn["compe#complete"]() -- < use this if you want <tab> to always offer completion
      -- return replace_keycodes "<Tab>"
      -- return utils.replace_keycodes "<Plug>(Tabout)"
      return utils.replace_keycodes "<Plug>(TaboutMulti)"
    end
  end

  function _G.s_tab_binding()
    if vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
      return utils.replace_keycodes "<Plug>(vsnip-jump-prev)"
    else
      -- return utils.replace_keycodes "<Plug>(TaboutBack)"
      return utils.replace_keycodes "<Plug>(TaboutBackMulti)"
    end
  end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_binding()", { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_binding()", { expr = true })
end

return M
