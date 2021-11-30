local M = {}

M.config = function()
  local icon_styles = {
    default = {
      left = "",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
    },
    arrow = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
    },

    block = {
      left = " ",
      right = " ",
      main_icon = "   ",
      vi_mode_icon = "  ",
      position_icon = "  ",
    },

    round = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
    },

    slant = {
      left = " ",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
    },
  }

  -- local gruvbox_colors = {
  --   white = "#ebdbb2",
  --   darker_black = "#232323",
  --   black = "#282828", --  nvim bg
  --   black2 = "#2e2e2e",
  --   one_bg = "#353535",
  --   one_bg2 = "#3f3f3f",
  --   one_bg3 = "#444444",
  --   grey = "#464646",
  --   grey_fg = "#4e4e4e",
  --   grey_fg2 = "#505050",
  --   light_grey = "#565656",
  --   red = "#fb4934",
  --   baby_pink = "#cc241d",
  --   pink = "#ff75a0",
  --   line = "#2c2f30", -- for lines like vertsplit
  --   green = "#b8bb26",
  --   vibrant_green = "#a9b665",
  --   nord_blue = "#83a598",
  --   blue = "#458588",
  --   yellow = "#d79921",
  --   sun = "#fabd2f",
  --   purple = "#b4bbc8",
  --   dark_purple = "#d3869b",
  --   teal = "#749689",
  --   orange = "#e78a4e",
  --   cyan = "#82b3a8",
  --   statusline_bg = "#2c2c2c",
  --   lightbg = "#353535",
  --   lightbg2 = "#303030",
  --   pmenu_bg = "#83a598",
  --   folder_bg = "#83a598",
  -- }

  local gruvchad_colors = {
    white = "#c7b89d",
    darker_black = "#232323",
    black = "#282828", --  nvim bg
    black2 = "#2e2e2e",
    one_bg = "#353535",
    one_bg2 = "#3f3f3f",
    one_bg3 = "#444444",
    grey = "#46494a",
    grey_fg = "#5d6061",
    grey_fg2 = "#5b5e5f",
    light_grey = "#585b5c",
    red = "#ec6b64",
    baby_pink = "#ce8196",
    pink = "#ff75a0",
    line = "#2c2f30", -- for lines like vertsplit
    green = "#89b482",
    vibrant_green = "#a9b665",
    nord_blue = "#6f8faf",
    blue = "#6d8dad",
    yellow = "#d6b676",
    sun = "#d1b171",
    purple = "#b4bbc8",
    dark_purple = "#cc7f94",
    teal = "#749689",
    orange = "#e78a4e",
    cyan = "#82b3a8",
    statusline_bg = "#2c2c2c",
    lightbg = "#353535",
    lightbg2 = "#303030",
    pmenu_bg = "#89b482",
    folder_bg = "#6d8dad",
  }

  local config = {
    options = {
      icons_enabled = true,
      -- Disable sections and component separators
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = gruvchad_colors.white, bg = gruvchad_colors.statusline_bg } },
        inactive = { c = { fg = gruvchad_colors.white, bg = gruvchad_colors.statusline_bg } },
      },
      disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},

      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_v = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  -- Main Icon
  ins_left {
    function()
      return icon_styles.default.main_icon
    end,
    color = { fg = gruvchad_colors.statusline_bg, bg = gruvchad_colors.nord_blue },
    padding = { left = 0, right = 0 },
  }

  -- Main Icon separator
  ins_left {
    function()
      return icon_styles.default.right
    end,
    color = { fg = gruvchad_colors.nord_blue, bg = gruvchad_colors.lightbg },
    padding = { left = 0, right = 0 },
  }

  ins_left {
    "filetype",
    colored = true,
    -- disable_text = true,
    icon_only = true,
    color = { fg = gruvchad_colors.white, bg = gruvchad_colors.lightbg, gui = "bold" },
    padding = { left = 1 },
  }

  -- filename
  ins_left {
    function()
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
        icon = " "
        return icon
      end
      if vim.bo.modified then
        filename = filename .. " "
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        filename = filename .. " "
      end
      return " " .. filename .. " "
    end,
    color = { fg = gruvchad_colors.white, bg = gruvchad_colors.lightbg, gui = "bold" },
    padding = { left = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
  }

  -- filename separator
  ins_left {
    function()
      return icon_styles.default.right
    end,
    color = { fg = gruvchad_colors.lightbg, bg = gruvchad_colors.lightbg2 },
    padding = { left = 0, right = 0 },
  }

  -- dir name
  ins_left {
    function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,
    color = { fg = gruvchad_colors.grey_fg2, bg = gruvchad_colors.lightbg2 },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 80
    end,
  }

  -- dir name separator
  ins_left {
    function()
      return icon_styles.default.right
    end,
    color = { fg = gruvchad_colors.lightbg2, bg = gruvchad_colors.statusline_bg },
    padding = { left = 0, right = 0 },
  }

  ins_left {
    function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]
      if Lsp then
        local msg = Lsp.message or ""
        local percentage = Lsp.percentage or 0
        local title = Lsp.title or ""
        local spinners = {
          "",
          "",
          "",
        }
        local success_icon = {
          "",
          "",
          "",
        }

        local ms = vim.loop.hrtime() / 1000000
        local frame = math.floor(ms / 120) % #spinners

        if percentage >= 70 then
          return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
        else
          return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
        end
      end
      return ""
    end,
    color = { fg = gruvchad_colors.green },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 80
    end,
  }

  ------------------------------------------------------------------------------
  -- Right
  ------------------------------------------------------------------------------

  ins_right {
    function(msg)
      msg = msg or "轢 LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return "轢 LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local trim = vim.fn.winwidth(0) < 120

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          local _added_client = client.name
          if trim then
            _added_client = string.sub(client.name, 1, 4)
          end
          table.insert(buf_client_names, _added_client)
        end
      end

      -- add formatter
      local formatters = require "lvim.lsp.null-ls.formatters"
      local supported_formatters = {}
      for _, fmt in pairs(formatters.list_registered_providers(buf_ft)) do
        local _added_formatter = fmt
        if trim then
          _added_formatter = string.sub(fmt, 1, 4)
        end
        table.insert(supported_formatters, _added_formatter)
      end
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linters
      local linters = require "lvim.lsp.null-ls.linters"
      local supported_linters = {}
      for _, lnt in pairs(linters.list_registered_providers(buf_ft)) do
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

      return "歷" .. table.concat(unique_buf_client_names, ", ")
    end,
    color = { fg = gruvchad_colors.grey_fg2, bg = gruvchad_colors.statusline_bg },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
  }

  -- ins_right {
  --   function()
  --     return ""
  --   end,
  --   color = { fg = gruvchad_colors.cyan, bg = gruvchad_colors.statusline_bg },
  --   cond = function()
  --     return vim.api.nvim_win_get_width(0) > 70
  --   end,
  --   padding = { left = 1, right = 1 },
  -- }

  ins_right {
    "b:gitsigns_head",
    color = { fg = gruvchad_colors.grey_fg2, bg = gruvchad_colors.statusline_bg },
    icon = "",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
    padding = { left = 0, right = 1 },
  }

  -- Color table for highlights
  local mode_colors = {
    ["n"] = { "NORMAL", gruvchad_colors.red },
    ["no"] = { "N-PENDING", gruvchad_colors.red },
    ["i"] = { "INSERT", gruvchad_colors.dark_purple },
    ["ic"] = { "INSERT", gruvchad_colors.dark_purple },
    ["t"] = { "TERMINAL", gruvchad_colors.green },
    ["v"] = { "VISUAL", gruvchad_colors.cyan },
    ["V"] = { "V-LINE", gruvchad_colors.cyan },
    [""] = { "V-BLOCK", gruvchad_colors.cyan },
    ["R"] = { "REPLACE", gruvchad_colors.orange },
    ["Rv"] = { "V-REPLACE", gruvchad_colors.orange },
    ["s"] = { "SELECT", gruvchad_colors.nord_blue },
    ["S"] = { "S-LINE", gruvchad_colors.nord_blue },
    [""] = { "S-BLOCK", gruvchad_colors.nord_blue },
    ["c"] = { "COMMAND", gruvchad_colors.pink },
    ["cv"] = { "COMMAND", gruvchad_colors.pink },
    ["ce"] = { "COMMAND", gruvchad_colors.pink },
    ["r"] = { "PROMPT", gruvchad_colors.teal },
    ["rm"] = { "MORE", gruvchad_colors.teal },
    ["r?"] = { "CONFIRM", gruvchad_colors.teal },
    ["!"] = { "SHELL", gruvchad_colors.green },
  }

  ins_right {
    function()
      return icon_styles.default.left
    end,
    color = { fg = gruvchad_colors.one_bg2, bg = gruvchad_colors.statusline_bg },
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      vim.api.nvim_command(
        "hi! ViModeSep guifg=" .. mode_colors[vim.fn.mode()][2] .. " guibg=" .. gruvchad_colors.one_bg2 .. " gui=bold"
      )
      return icon_styles.default.left
    end,
    color = "ViModeSep",
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      vim.api.nvim_command(
        "hi! ViModeIcon guifg=" .. gruvchad_colors.statusline_bg .. " guibg=" .. mode_colors[vim.fn.mode()][2]
      )
      return icon_styles.default.vi_mode_icon
    end,
    color = "ViModeIcon",
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      vim.api.nvim_command(
        "hi! ViModeText guifg="
          .. mode_colors[vim.fn.mode()][2]
          .. " guibg="
          .. gruvchad_colors.statusline_bg
          .. " gui=bold"
      )
      return " " .. mode_colors[vim.fn.mode()][1] .. " "
    end,
    color = "ViModeText",
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      return icon_styles.default.left
    end,
    color = { fg = gruvchad_colors.grey, bg = gruvchad_colors.one_bg },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_right {
    function()
      return icon_styles.default.left
    end,
    color = { fg = gruvchad_colors.green, bg = gruvchad_colors.grey },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_right {
    function()
      return icon_styles.default.position_icon
    end,
    color = { fg = gruvchad_colors.black, bg = gruvchad_colors.green },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_right {
    function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
        return " Top "
      elseif current_line == vim.fn.line "$" then
        return " Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% "
    end,
    color = { fg = gruvchad_colors.green, bg = gruvchad_colors.one_bg },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  -- Now don't forget to initialize lualine
  lvim.builtin.lualine.options = config.options
  lvim.builtin.lualine.sections = config.sections
  lvim.builtin.lualine.inactive_sections = config.inactive_sections
end

return M
