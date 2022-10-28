local M = {}
M.config = function()
  local c = require("fennec-gruvbox.colors").config()
  local components = require "lvim.core.lualine.components"

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local icons = require "user.icons"

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
    colored = true,
    update_in_insert = false,
    always_visible = false,
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = icons.git.Add, modified = icons.git.Mod, removed = icons.git.Remove .. " " }, -- changes diff symbols
    diff_color = {
      added = { fg = c.soft_green },
      modified = { fg = c.blue_gray },
      removed = { fg = c.red },
    },
    cond = hide_in_width,
  }

  local mode_color = {
    n = c.red,
    i = c.soft_green,
    v = c.soft_yellow,
    [""] = c.blue_gray,
    V = c.soft_yellow,
    c = c.light_blue,
    no = c.magenta,
    s = c.orange,
    S = c.orange,
    [""] = c.orange,
    ic = c.soft_yellow,
    R = c.pink,
    Rv = c.pink,
    cv = c.red,
    ce = c.red,
    r = c.light_blue,
    rm = c.light_blue,
    ["r?"] = c.light_blue,
    ["!"] = c.red,
    t = c.red,
  }

  local mode = {
    function()
      return " "
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()], bg = c.line_bg }
    end,
    padding = { left = 1, right = 0 },
  }

  local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
  }

  local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
    color = { fg = c.line_fg },
  }

  local location = {
    "location",
    padding = 0,
  }

  local session = {
    function()
      local auto_session_library = require "auto-session-library"
      local status_ok, session_name = pcall(auto_session_library.current_session_name)
      if not status_ok then
        return " "
      end
      return " "
    end,
    color = { fg = c.line_fg },
  }

  local harpoon_mark = {
    function()
      local status = require("harpoon.mark").status()
      if status == "" then
        return ""
      end
      -- return just the terminal number, cause the status method returns M1, M2, etc.
      local number = (string.format("%s", status)):sub(-1)
      return "  " .. number
    end,
    -- color = { fg = c.soft_yellow },
    color = function()
      return { fg = mode_color[vim.fn.mode()], bg = c.line_bg }
    end,
  }

  -- cool function for progress
  local progress = function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  local lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local trim = vim.fn.winwidth(0) < 100

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local formatters = require "lvim.lsp.null-ls.formatters"
      local supported_formatters = {}
      for _, fmt in pairs(formatters.list_registered(buf_ft)) do
        local _added_formatter = fmt
        if trim then
          _added_formatter = string.sub(fmt, 1, 4)
        end
        table.insert(supported_formatters, _added_formatter)
      end
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lvim.lsp.null-ls.linters"
      local supported_linters = {}
      for _, lnt in pairs(linters.list_registered(buf_ft)) do
        local _added_linter = lnt
        if trim then
          _added_linter = string.sub(lnt, 1, 4)
        end
        table.insert(supported_linters, _added_linter)
      end
      vim.list_extend(buf_client_names, supported_linters)

      -- remove any duplicate client names before returning them
      local hash = {}
      local unique_buf_client_names = {}
      for _, v in ipairs(buf_client_names) do
        if not hash[v] then
          unique_buf_client_names[#unique_buf_client_names + 1] = v
          hash[v] = true
        end
      end

      return "[" .. table.concat(unique_buf_client_names, ", ") .. "]"
    end,
    color = { gui = "bold" },
    cond = hide_in_width,
  }

  local modified = {
    function()
      local fg = "#228b22" -- not modified
      local mod = " "
      if vim.bo.modified then
        fg = "#c70039" -- unsaved
        mod = ""
      elseif not vim.bo.modifiable then
        fg = "#a70089"
        mod = ""
      end -- readonly
      vim.cmd("hi! lualine_filename_status guifg=" .. fg)
      -- return "%t %m"
      return mod
    end,
    color = { fg = c.line_fg },
    -- color = "lualine_filename_status",
  }

  lvim.builtin.lualine.sections = {
    -- python_env
    -- lualine_a = { branch, diagnostics },
    lualine_a = { mode, harpoon_mark, branch },
    lualine_b = { components.python_env },
    lualine_c = { diagnostics },
    -- lualine_c = {},
    -- lualine_c = {
    --   { nvim_gps, cond = hide_in_width },
    -- },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diff, lsp, filetype },
    lualine_y = { location },
    lualine_z = { progress },
  }

  lvim.builtin.lualine.inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  }
  lvim.builtin.lualine.tabline = {}
  lvim.builtin.lualine.extensions = {}
  lvim.builtin.lualine.options.globalstatus = true
  lvim.builtin.lualine.options.disabled_filetypes = { "dashboard", "alpha" }
  -- lvim.builtin.lualine.options = {
  --   globalstatus = true,
  --   icons_enabled = true,
  --   theme = "auto",
  --   component_separators = { left = "", right = "" },
  --   section_separators = { left = "", right = "" },
  --   -- disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha", "vista", "vista_kind", "TelescopePrompt" },
  --   disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
  --   always_divide_middle = true,
  -- }

  local custom_gruvbox = require "lualine.themes.fennec-gruvbox"
  custom_gruvbox.normal.a = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.normal.b = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.normal.c = { fg = c.line_fg, bg = c.line_bg }

  custom_gruvbox.insert.a = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.insert.b = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.insert.c = { fg = c.line_fg, bg = c.line_bg }

  custom_gruvbox.visual.a = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.visual.b = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.visual.c = { fg = c.line_fg, bg = c.line_bg }

  custom_gruvbox.replace.a = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.replace.b = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.replace.c = { fg = c.line_fg, bg = c.line_bg }

  custom_gruvbox.command.a = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.command.b = { fg = c.line_active_fg, bg = c.line_bg }
  custom_gruvbox.command.c = { fg = c.line_fg, bg = c.line_bg }

  custom_gruvbox.inactive.a = { fg = c.line_fg, bg = c.line_bg }
  custom_gruvbox.inactive.b = { fg = c.line_fg, bg = c.line_bg }
  custom_gruvbox.inactive.c = { fg = c.line_fg, bg = c.line_bg }

  lvim.builtin.lualine.options.theme = custom_gruvbox
end

return M
