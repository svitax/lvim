local M = {}

M.config = function()
  local status_ok, neoclip = pcall(require, "neoclip")
  if not status_ok then
    return
  end

  neoclip.setup {
    enable_persistant_history = true,
    db_path = vim.fn.stdpath "data" .. "/neoclip.sqlite3",
    keys = {
      i = { select = "<c-p>", paste = "<CR>", paste_behind = "<c-P>" },
      n = { select = "p", paste = "<CR>", paste_behind = "P" },
    },
  }

  local function clip()
    local opts = {
      winblend = lvim.winblend,
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        width = 0.9,
        height = 0.9,
        -- horizontal = { height = { padding = 0.10 }, width = { padding = 0.04 } },
        -- vertical = { preview_height = 0.90 },
      },
      borderchars = {
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      border = {},
      shorten_path = false,
    }
    local dropdown = require("telescope.themes").get_dropdown(opts)
    require("telescope").extensions.neoclip.default(dropdown)
  end
  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    return
  end
  whk.register {
    ["<leader>y"] = { clip, "yank history" },
  }
end

return M
