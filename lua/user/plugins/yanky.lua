local M = {}

M.config = function()
  local status_ok, yanky = pcall(require, "yanky")
  if not status_ok then
    return
  end

  yanky.setup {
    picker = {
      select = {
        action = require("yanky.picker").actions.put "gp", -- put after cursor and leave the cursor after
      },
    },
  }

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       Yanky hydra                        │
  --  ╰──────────────────────────────────────────────────────────╯
  local status_ok, hydra = pcall(require, "hydra")
  if not status_ok then
    return
  end

  local yanky_hydra = hydra {
    name = "Yank ring",
    hint = [[
 Cycle yanks
 _<A-n>_: Cycle forward    _<A-p>_: Cycle backward
 ^
 Put
 _p_: Put after     _P_: Put before
 ^
 _q_, _<Esc>_: Quit
    ]],
    mode = "n",
    config = {
      color = "red", -- exit yanky mode if foreign keys are pressed
      hint = {
        type = "window", -- one of "statusline", "cmdline", "window"
        position = "bottom-right", -- only applies for type = "window"
        border = "rounded", -- only applies for type = "window"
      },
    },
    heads = {
      { "p", "<Plug>(YankyPutAfter)", { desc = "put after" } },
      { "P", "<Plug>(YankyPutBefore)", { desc = "put before" } },
      { "<A-n>", "<Plug>(YankyCycleForward)", { private = true, desc = "↓ cycle forward" } },
      { "<A-p>", "<Plug>(YankyCycleBackward)", { private = true, desc = "↑ cycle backward" } },
      { "q", nil, { exit = true, nowait = true, desc = "quit" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = "quit" } },
    },
  }

  require("user.keymaps").set_yanky_keymaps(yanky_hydra)

  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end
  telescope.load_extension "yank_history"
end

return M
