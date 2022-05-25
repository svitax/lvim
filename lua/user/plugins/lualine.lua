local M = {}
M.config = function()
  local c = require("fennec-gruvbox.colors").config()

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local status_gps_ok, gps = pcall(require, "nvim-gps")
  if not status_gps_ok then
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
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
    cond = hide_in_width,
  }

  local mode = {
    "mode",
    fmt = function(str)
      return "-- " .. str .. " --"
    end,
    color = { fg = c.line_fg }
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
  }

  local location = {
    "location",
    padding = 0,
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

  local nvim_gps = function()
    local gps_location = gps.get_location()
    if gps_location == "error" then
      return ""
    else
      return gps.get_location()
    end
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

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local formatters = require "lvim.lsp.null-ls.formatters"
      local supported_formatters = formatters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lvim.lsp.null-ls.linters"
      local supported_linters = linters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      return "[" .. table.concat(buf_client_names, ", ") .. "]"
    end,
    color = { gui = "bold" },
    cond = hide_in_width,
  }

  lvim.builtin.lualine.sections = {
    -- lualine_a = { branch, diagnostics },
    lualine_a = { branch },
    lualine_b = { diagnostics },
    lualine_c = {
      {
        function()
          local fg = "#228b22" -- not modified
          if vim.bo.modified then
            fg = "#c70039" -- unsaved
          elseif not vim.bo.modifiable then
            fg = "#a70089"
          end -- readonly
          vim.cmd("hi! lualine_filename_status guifg=" .. fg)
          -- return "%t %m"
          return "%m"
        end,
        -- color = "lualine_filename_status",
      },
      mode
    },
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
  lvim.builtin.lualine.options.disabled_filetypes = { "dashboard", "alpha", "NvimTree" }
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
