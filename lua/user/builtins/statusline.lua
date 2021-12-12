local M = {}

M.config = function()
  local icons = require("user.theme").icon_styles
  local c = require("user.theme").colors.gruvchad

  local config = {
    options = {
      icons_enabled = true,
      -- Disable sections and component separators
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      -- theme = "catppuccin",
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = c.white, bg = c.statusline_bg } },
        inactive = { c = { fg = c.white, bg = c.statusline_bg } },
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

  local function ins_inactive_left(component)
    table.insert(config.inactive_sections.lualine_c, component)
  end
  local function ins_inactive_right(component)
    table.insert(config.inactive_sections.lualine_x, component)
  end

  ------------------------------------------------------------------------------
  -- Active Left
  ------------------------------------------------------------------------------

  -- Main Icon
  ins_left {
    function()
      return icons.default.main_icon
    end,
    color = { fg = c.statusline_bg, bg = c.nord_blue },
    padding = { left = 0, right = 0 },
  }

  -- -- Main Icon separator
  -- ins_left {
  --   function()
  --     return icons.default.right
  --   end,
  --   color = { fg = c.nord_blue, bg = c.lightbg },
  --   padding = { left = 0, right = 0 },
  -- }

  -- Main Icon separator
  ins_left {
    function()
      return icons.default.right
    end,
    color = { fg = c.nord_blue, bg = c.lightbg },
    padding = { left = 0, right = 0 },
  }

  -- harpoon mark number
  ins_left {
    function()
      local status = require("harpoon.mark").status()
      if status == "" then
        return ""
      end
      -- return just the terminal number, cause the status method returns M1, M2, etc.
      local number = (string.format("%s", status)):sub(-1)
      return " " .. number
    end,
    color = { fg = c.yellow, bg = c.lightbg, gui = "bold" },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 80
    end,
  }

  -- Harpoon separator
  -- ins_left {
  --   function()
  --     local status = require("harpoon.mark").status()
  --     if status == "" then
  --       return ""
  --     end
  --     return icons.default.right
  --   end,
  --   color = { fg = c.yellow, bg = c.lightbg },
  --   padding = { left = 0, right = 0 },
  --   cond = function()
  --     return vim.api.nvim_win_get_width(0) > 80
  --   end,
  -- }

  ins_left {
    "filetype",
    colored = true,
    -- disable_text = true,
    icon_only = true,
    color = { fg = c.white, bg = c.lightbg, gui = "bold" },
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
    color = { fg = c.white, bg = c.lightbg, gui = "bold" },
    padding = { left = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
  }

  -- filename separator
  ins_left {
    function()
      return icons.default.right
    end,
    color = { fg = c.lightbg, bg = c.lightbg2 },
    padding = { left = 0, right = 0 },
  }

  -- dir name
  ins_left {
    function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,
    color = { fg = c.grey_fg2, bg = c.lightbg2 },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 80
    end,
  }

  -- dir name separator
  ins_left {
    function()
      return icons.default.right
    end,
    color = { fg = c.lightbg2, bg = c.statusline_bg },
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
    color = { fg = c.green },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 80
    end,
  }

  ------------------------------------------------------------------------------
  -- Active Right
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
    color = { fg = c.grey_fg2, bg = c.statusline_bg },
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
    icon = "",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
    color = { fg = c.grey_fg2, bg = c.statusline_bg },
    padding = { left = 0, right = 1 },
  }

  -- Color table for highlights
  local mode_colors = {
    ["n"] = { "NORMAL", c.red, " " },
    ["no"] = { "N-PENDING", c.red, " " },
    ["i"] = { "INSERT", c.dark_purple, " " },
    ["ic"] = { "INSERT", c.dark_purple, " " },
    ["t"] = { "TERMINAL", c.green, " " },
    ["v"] = { "VISUAL", c.cyan, " " },
    ["V"] = { "V-LINE", c.cyan, " " },
    [""] = { "V-BLOCK", c.cyan, " " },
    ["R"] = { "REPLACE", c.orange, " " },
    ["Rv"] = { "V-REPLACE", c.orange, " " },
    ["s"] = { "SELECT", c.nord_blue, " " },
    ["S"] = { "S-LINE", c.nord_blue, " " },
    [""] = { "S-BLOCK", c.nord_blue, " " },
    ["c"] = { "COMMAND", c.pink, " " },
    ["cv"] = { "COMMAND", c.pink, " " },
    ["ce"] = { "COMMAND", c.pink, " " },
    ["r"] = { "PROMPT", c.teal, " " },
    ["rm"] = { "MORE", c.teal, " " },
    ["r?"] = { "CONFIRM", c.teal, " " },
    ["!"] = { "SHELL", c.green, " " },
  }

  ins_right {
    function()
      return icons.default.left
    end,
    color = { fg = c.one_bg2, bg = c.statusline_bg },
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      vim.api.nvim_command(
        "hi! ViModeSep guifg=" .. mode_colors[vim.fn.mode()][2] .. " guibg=" .. c.one_bg2 .. " gui=bold"
      )
      return icons.default.left
    end,
    color = "ViModeSep",
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      vim.api.nvim_command("hi! ViModeIcon guifg=" .. c.statusline_bg .. " guibg=" .. mode_colors[vim.fn.mode()][2])
      -- return icons.default.vi_mode_icon
      return mode_colors[vim.fn.mode()][3]
    end,
    color = "ViModeIcon",
    padding = { left = 0, right = 0 },
  }
  ins_right {
    function()
      vim.api.nvim_command("hi! ViModeSpace guibg=" .. c.statusline_bg .. " guifg=" .. mode_colors[vim.fn.mode()][2])
      return "▍"
    end,
    color = "ViModeSpace",
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      vim.api.nvim_command(
        "hi! ViModeText guifg=" .. mode_colors[vim.fn.mode()][2] .. " guibg=" .. c.statusline_bg .. " gui=bold"
      )
      return mode_colors[vim.fn.mode()][1] .. " "
    end,
    color = "ViModeText",
    padding = { left = 1, right = 1 },
  }

  ins_right {
    function()
      return icons.default.left
    end,
    color = { fg = c.grey, bg = c.one_bg },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_right {
    function()
      return icons.default.left
    end,
    color = { fg = c.green, bg = c.grey },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_right {
    function()
      return icons.default.position_icon
    end,
    color = { fg = c.black, bg = c.green },
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
    color = { fg = c.green, bg = c.one_bg },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ------------------------------------------------------------------------------
  -- Inactive Left
  ------------------------------------------------------------------------------

  -- Main Icon
  ins_inactive_left {
    function()
      return icons.default.main_icon
    end,
    color = { fg = c.statusline_bg, bg = c.grey_fg2 },
    padding = { left = 0, right = 0 },
  }

  -- Main Icon separator
  ins_inactive_left {
    function()
      return icons.default.right
    end,
    color = { fg = c.grey_fg2, bg = c.lightbg },
    padding = { left = 0, right = 0 },
  }

  ins_inactive_left {
    "filetype",
    colored = false,
    -- disable_text = true,
    icon_only = true,
    color = { fg = c.grey_fg, bg = c.lightbg, gui = "bold" },
    padding = { left = 1 },
  }

  -- filename
  ins_inactive_left {
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
    color = { fg = c.grey_fg, bg = c.lightbg },
    padding = { left = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
  }

  -- filename separator
  ins_inactive_left {
    function()
      return icons.default.right
    end,
    color = { fg = c.lightbg, bg = c.lightbg2 },
    padding = { left = 0, right = 0 },
  }

  -- dir name
  -- ins_inactive_left {
  --   function()
  --     local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  --     return "  " .. dir_name .. " "
  --   end,
  --   color = { fg = c.grey_fg2, bg = c.lightbg2 },
  --   padding = { left = 0, right = 0 },
  --   cond = function()
  --     return vim.api.nvim_win_get_width(0) > 80
  --   end,
  -- }

  -- dir name separator
  ins_inactive_left {
    function()
      return icons.default.right
    end,
    color = { fg = c.lightbg2, bg = c.statusline_bg },
    padding = { left = 0, right = 0 },
  }

  ------------------------------------------------------------------------------
  -- Inactive Right
  ------------------------------------------------------------------------------

  ins_inactive_right {
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
    color = { fg = c.grey_fg2, bg = c.statusline_bg },
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

  ins_inactive_right {
    "b:gitsigns_head",
    icon = "",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 70
    end,
    color = { fg = c.grey_fg2, bg = c.statusline_bg },
    padding = { left = 0, right = 1 },
  }

  ins_inactive_right {
    function()
      return icons.default.left
    end,
    color = { fg = c.grey, bg = c.one_bg },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_inactive_right {
    function()
      return icons.default.left
    end,
    color = { fg = c.grey_fg2, bg = c.grey },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_inactive_right {
    function()
      return icons.default.position_icon
    end,
    color = { fg = c.black, bg = c.grey_fg2 },
    padding = { left = 0, right = 0 },
    cond = function()
      return vim.api.nvim_win_get_width(0) > 90
    end,
  }

  ins_inactive_right {
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
    color = { fg = c.grey_fg2, bg = c.one_bg },
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
