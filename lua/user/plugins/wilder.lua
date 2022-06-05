local M = {}

M.config = function()
  local wilder = require "wilder"
  local c = require("fennec-gruvbox.colors").config()

  wilder.setup { modes = { ":", "/", "?" } }

  vim.api.nvim_set_keymap("c", "<Tab>", "<cmd>lua require('wilder').next()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("c", "<S-Tab>", "<cmd>lua require('wilder').previous()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("c", "<C-j>", "<cmd>lua require('wilder').next()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("c", "<C-k>", "<cmd>lua require('wilder').previous()<cr>", { noremap = true })

  wilder.set_option("use_python_remote_plugin", 0)

  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.cmdline_pipeline {
        fuzzy = 1,
        fuzzy_filter = wilder.lua_fzy_filter(),
      },
      wilder.vim_search_pipeline()
    ),
  })

  local highlighters = {
    wilder.pcre2_highlighter(),
    wilder.lua_fzy_highlighter(),
  }

  -- local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    border = "rounded",
    max_height = "20%",
    min_height = 0,
    prompt_position = "top",
    reverse = 0,
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    apply_incsearch_fix = 1,
    highlights = {
      default = "Normal",
      border = "Comment",
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = c.light_blue } }),
    },
    -- separator = " · ",
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags {
        flags = " a + ",
        icons = { ["+"] = "", a = "", h = "" },
      },
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  })

  local wildmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    border = "rounded",
    max_height = "20%",
    min_height = 0,
    prompt_position = "top",
    reverse = 0,
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    apply_incsearch_fix = 1,
    highlights = {
      default = "Normal",
      border = "Comment",
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = c.light_blue } }),
    },
    -- separator = " · ",
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags {
        flags = " a + ",
        icons = { ["+"] = "", a = "", h = "" },
      },
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  })

  wilder.set_option(
    "renderer",
    wilder.renderer_mux {
      [":"] = popupmenu_renderer,
      ["/"] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    }
  )
end

return M
