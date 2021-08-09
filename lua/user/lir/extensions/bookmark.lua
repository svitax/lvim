return function()
  local status_ok, bkm_actions = pcall(require, "lir.bookmark.actions")
  if not status_ok then
    return
  end

  local actions = require "lir.actions"

  require("lir.bookmark").setup {
    -- bookmark_path = "~/.config/lvim/.lir_bookmark",
    bookmark_path = "~/.config/lvim/lua/user/lir/extensions/.lir_bookmark",
    mappings = {
      [";"] = bkm_actions.edit,

      ["B"] = bkm_actions.open_lir,
      ["l"] = bkm_actions.open_lir,
      ["q"] = actions.quit,
      ["S"] = bkm_actions.split,
      ["V"] = bkm_actions.vsplit,

      -- ["<C-e>"] = bkm_actions.open_lir,
      ["<C-s>"] = bkm_actions.vsplit,
      ["<C-t>"] = bkm_actions.tabedit,
      ["<C-v>"] = bkm_actions.vsplit,
    },
  }
  -- highlight link lirBookmarkDirectory PreProc
end
