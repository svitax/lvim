local M = {}

-- TODO: inactive lualine

-- TODO: pcall this
local gps = require "nvim-gps"
-- TODO: refactor fennec_utils
local fennec_utils = {
  get_short_cwd = function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  end,
  harpoon = function()
    local status = require("harpoon.mark").status()
    if status == "" then
      return ""
    end
    -- return just the terminal number, cause the status method returns M1, M2, etc.
    local number = (string.format("%s", status)):sub(-1)
    return number
  end,
}

-- local function clock()
--   return " " .. os.date "%H:%M"
-- end

local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd [[autocmd User LspProgressUpdate let &ro = &ro]]

-- local function diff_source()
--   local gitsigns = vim.b.gitsigns_status_dict
--   if gitsigns then
--     return {
--       added = gitsigns.added,
--       modified = gitsigns.changed,
--       removed = gitsigns.removed,
--     }
--   end
-- end

local mode = function()
  local mod = vim.fn.mode()
  if mod == "n" or mod == "no" or mod == "nov" then
    return ""
  elseif mod == "i" or mod == "ic" or mod == "ix" then
    -- return " "
    return ""
  elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
    return ""
  elseif mod == "c" or mod == "ce" then
    return "ﴣ "
  elseif mod == "r" or mod == "rm" or mod == "r?" then
    return ""
  elseif mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
    return ""
  end
  -- return "  "
  -- return " "
  return " "
end
local file_icons = {
  Brown = { "" },
  Aqua = { "" },
  LightBlue = { "", "" },
  Blue = { "", "", "", "", "", "", "", "", "", "", "", "", "" },
  Darkblue = { "", "" },
  Purple = { "", "", "", "", "" },
  Red = { "", "", "", "", "", "" },
  Beige = { "", "", "" },
  Yellow = { "", "", "λ", "", "" },
  Orange = { "", "" },
  Darkorange = { "", "", "", "", "" },
  Pink = { "", "" },
  Salmon = { "" },
  Green = { "", "", "", "", "", "" },
  Lightgreen = { "", "", "", "﵂" },
  White = { "", "", "", "", "", "" },
}

local file_icon_colors = {
  Brown = "#905532",
  Aqua = "#3AFFDB",
  Blue = "#689FB6",
  Darkblue = "#44788E",
  Purple = "#834F79",
  Red = "#AE403F",
  Beige = "#F5C06F",
  Yellow = "#F09F17",
  Orange = "#D4843E",
  Darkorange = "#F16529",
  Pink = "#CB6F6F",
  Salmon = "#EE6E73",
  Green = "#8FAA54",
  Lightgreen = "#31B53E",
  White = "#FFFFFF",
  LightBlue = "#5fd7ff",
}

local function get_file_info()
  return vim.fn.expand "%:t", vim.fn.expand "%:e"
end

local function get_file_icon()
  local icon
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    print "No icon plugin found. Please install 'kyazdani42/nvim-web-devicons'"
    return ""
  end
  local f_name, f_extension = get_file_info()
  icon = devicons.get_icon(f_name, f_extension)
  if icon == nil then
    icon = ""
  end
  return icon
end

local function get_file_icon_color()
  local f_name, f_ext = get_file_info()

  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if has_devicons then
    local icon, iconhl = devicons.get_icon(f_name, f_ext)
    if icon ~= nil then
      return vim.fn.synIDattr(vim.fn.hlID(iconhl), "fg")
    end
  end

  local icon = get_file_icon():match "%S+"
  for k, _ in pairs(file_icons) do
    if vim.fn.index(file_icons[k], icon) ~= -1 then
      return file_icon_colors[k]
    end
  end
end

local default_colors = {
  bg = "#202328",
  bg_alt = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  git = { change = "#ECBE7B", add = "#98be65", delete = "#ec5f67", conflict = "#bb7a61" },
}

M.config = function()
  local theme = require "user.theme"

  local colors = theme.colors.fennecgruvbox_colors

  -- local _time = os.date "*t"
  -- if (_time.hour >= 0 and _time.hour < 7) or (_time.hour >= 11 and _time.hour < 17) then
  --   colors = theme.colors.tokyonight_colors
  -- elseif _time.hour >= 7 and _time.hour < 11 then
  --   colors = theme.colors.catppuccino_colors
  -- elseif _time.hour >= 21 and _time.hour <= 24 then
  --   colors = theme.colors.onedarker_colors
  -- elseif _time.hour >= 17 and _time.hour < 21 then
  --   colors = theme.colors.doom_one_colors
  -- else
  --   colors = default_colors
  -- end

  -- Color table for highlights
  local mode_color = {
    n = colors.yellow,
    i = colors.blue,
    v = colors.orange,
    [""] = colors.green,
    V = colors.green,
    c = colors.magenta,
    no = colors.orange,
    s = colors.magenta,
    S = colors.magenta,
    [""] = colors.magenta,
    ic = colors.blue,
    R = colors.orange,
    Rv = colors.orange,
    cv = colors.orange,
    ce = colors.orange,
    r = colors.blue,
    rm = colors.blue,
    ["r?"] = colors.blue,
    ["!"] = colors.orange,
    t = colors.yellow,
  }

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    hide_small = function()
      return vim.fn.winwidth(0) > 150
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    gps_available = gps.is_available,
    is_not_blacklisted_filetype = function()
      local blacklisted_ft = { "toggleterm", "lir" }
      local filetype = vim.bo.filetype
      if vim.tbl_contains(blacklisted_ft, filetype) then
        return false
      end
      return true
    end,

    is_toggleterm = function()
      local filetype = vim.bo.filetype
      if filetype == "toggleterm" then
        return true
      end
    end,

    is_lir = function()
      local filetype = vim.bo.filetype
      if filetype == "lir" then
        return true
      end
    end,
  }

  -- Config
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
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
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
      lualine_c = {
        -- {
        --   function()
        --     vim.api.nvim_command(
        --       "hi! LualineModeInactive guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg_alt
        --     )
        --     return ""
        --     -- return mode()
        --   end,
        --   color = "LualineModeInactive",
        --   padding = { left = 1, right = 0 },
        --   -- left_padding = 1,
        -- },
        -- {
        --   "filename",
        --   cond = conditions.buffer_not_empty,
        --   color = { fg = colors.blue, gui = "bold" },
        -- },
      },
      lualine_x = {},
    },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_inactive_left(component)
    table.insert(config.inactive_sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_inactive_right(component)
    table.insert(config.inactive_sections.lualine_x, component)
  end

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ins_left {
    function()
      vim.api.nvim_command(
        "hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg2 .. " gui=bold"
      )
      vim.api.nvim_command("hi! LualineModeBg guifg=" .. colors.bg2 .. " guibg=" .. mode_color[vim.fn.mode()])
      -- return mode()
      return " "
    end,
    color = "LualineModeBg",
    padding = { left = 1, right = 0 },
  }

  ins_left {
    function()
      return " "
    end,
    color = "LualineMode",
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_left {
    -- TODO: add terminals for A and s
    fennec_utils.harpoon,
    --  ﯀ ﰳ    ﴱ \E943
    icon = " ",
    color = "LualineMode",
    cond = conditions.buffer_not_empty and conditions.hide_in_width,
    padding = { left = 0 },
  }

  ins_left {
    function()
      local utils = require "core.lualine.utils"
      local filename = vim.fn.expand "%"
      local kube_env = os.getenv "KUBECONFIG"
      local kube_filename = "kubectl-edit"
      if (vim.bo.filetype == "yaml") and (string.sub(filename, 1, kube_filename:len()) == kube_filename) then
        return string.format("⎈  (%s)", utils.env_cleanup(kube_env))
      end
      return ""
    end,
    -- color = { fg = colors.cyan },
    color = "LualineMode",
    cond = conditions.hide_in_width,
  }

  ins_left {
    function()
      local filename = vim.fn.expand "%:t"
      local term_number = filename:sub(-1)
      if term_number == "2" then
        term_number = "F"
      elseif term_number == "3" then
        term_number = "D"
      elseif term_number == "4" then
        term_number = "S"
      elseif term_number == "5" then
        term_number = "A"
      end

      return "  " .. term_number
    end,
    color = "LualineMode",
    cond = conditions.is_toggleterm,
    padding = { left = 0 },
    -- left_padding = 0,
  }

  ins_left {
    function()
      return ""
    end,
    color = { fg = colors.bg2, bg = colors.bg1 },
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  -- lir filetype
  ins_left {
    function()
      return " lir"
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    cond = conditions.is_lir,
    -- left_padding = 0,
  }

  ins_left {
    function()
      local utils = require "core.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV"
        print("lol this is the ", venv)
        if venv ~= nil then
          return string.format(" (%s)", utils.env_cleanup(venv))
        end
        venv = os.getenv "VIRTUAL_ENV"
        if venv ~= nil then
          return string.format(" (%s)", utils.env_cleanup(venv))
        end
        return ""
      end
      return ""
    end,
    -- color = { fg = colors.green },
    color = { fg = colors.fg2, bg = colors.bg1 },
    -- cond = conditions.hide_in_width,
    cond = conditions.hide_small,
  }

  -- root directory
  ins_left {
    function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      -- return " " .. dir_name .. "/"
      return " " .. dir_name
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_left {
    function()
      return " "
    end,
    color = { fg = colors.bg1 },
    -- cond = conditions.is_not_blacklisted_filetype,
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_left {
    "filetype",
    colored = true,
    -- disable_text = true,
    icon_only = true,
    color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
    cond = conditions.buffer_not_empty and conditions.is_not_blacklisted_filetype,
    padding = { left = 0 },
    -- left_padding = 0,
  }

  -- filename
  ins_left {
    function()
      local data = vim.fn.expand "%:t"

      -- if data == "" then
      --   data = "[No Name]"
      -- end

      if vim.bo.modified then
        data = data .. " "
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        data = data .. " "
      end
      return data
    end,
    cond = conditions.buffer_not_empty and conditions.is_not_blacklisted_filetype,
    color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
    padding = { left = 1 },
    -- left_padding = 0,
  }

  -- lir current directory root
  ins_left {
    function()
      local data = vim.fn.expand "%:~:h"
      --
      if data == "" then
        -- data = "[No Name]"
        data = ""
      elseif data == "." then
        data = ""
      else
        data = data .. "/"
      end

      return data
    end,
    cond = conditions.buffer_not_empty and conditions.is_lir,
    color = { fg = colors.fg2, bg = colors.bg, gui = "bold" },
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  -- lir current directory tail
  ins_left {
    function()
      local tail = vim.fn.expand "%:~:t"
      --
      if tail == "" then
        -- data = "[No Name]"
        tail = ""
      elseif tail == "." then
        tail = ""
      else
        tail = tail .. "/"
      end

      return tail
    end,
    cond = conditions.buffer_not_empty and conditions.is_lir,
    color = { fg = colors.yellow, bg = colors.bg, gui = "bold" },
    padding = { left = 0 },
  }

  -- ins_left {
  --   function()
  --     return get_file_icon()
  --   end,
  --   padding = { left = 2, right = 0 },
  --   cond = conditions.buffer_not_empty,
  --   color = { fg = get_file_icon_color(), gui = "bold" },
  -- }

  -- ins_left {
  --   "filename",
  --   cond = conditions.buffer_not_empty,
  --   padding = { left = 1, right = 1 },
  --   color = { fg = colors.fg, gui = "bold" },
  -- }

  -- ins_left {
  --   "diff",
  --   source = diff_source,
  --   symbols = { added = "  ", modified = "柳", removed = " " },
  --   diff_color = {
  --     added = { fg = colors.git.add },
  --     modified = { fg = colors.git.change },
  --     removed = { fg = colors.git.delete },
  --   },
  --   color = {},
  --   cond = nil,
  -- }

  -- ins_left {
  --   gps.get_location,
  --   -- cond = conditions.gps_available,
  --   cond = conditions.buffer_not_empty
  --     and conditions.hide_in_width
  --     and conditions.is_not_blacklisted_filetype
  --     and conditions.gps_available,
  --   -- color = { fg = colors.blue },
  --   color = { fg = colors.fg2 },
  --   icon = "",
  --   padding = { left = 0, right = 0 },
  -- }

  ins_left {
    lsp_progress,
    cond = conditions.hide_small,
  }

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  ins_left {
    function()
      return "%="
    end,
  }

  ins_right {
    "diagnostics",
    sources = { "nvim_lsp" },
    -- symbols = { error = " ", warn = " ", info = " ", hint = " " },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    diagnostics = {
      error = { fg = colors.red },
      warning = { fg = colors.yellow },
      info = { fg = colors.cyan },
      hint = { fg = colors.blue },
    },
    cond = conditions.hide_in_width,
  }
  -- ins_right {
  --   function()
  --     if next(vim.treesitter.highlighter.active) then
  --       return "  "
  --     end
  --     return ""
  --   end,
  --   padding = 0,
  --   -- left_padding = 0,
  --   -- right_padding = 0,
  --   color = { fg = colors.green },
  --   cond = conditions.hide_in_width,
  -- }

  ins_right {
    function()
      return " "
    end,
    -- color = { fg = colors.fg2 },
    color = { fg = colors.orange },
    cond = conditions.hide_in_width and conditions.active_lsp,
    padding = { right = 0 },
    -- right_padding = 0,
  }

  ins_right {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local trim = vim.fn.winwidth(0) < 120

      -- add client
      -- local utils = require "lsp.utils"
      -- local active_client = utils.get_active_client_by_ft(buf_ft)
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          local _added_client = client.name
          if trim then
            _added_client = string.sub(client.name, 1, 4)
          end
          table.insert(buf_client_names, _added_client)
        end
      end
      -- vim.list_extend(buf_client_names, active_client or {})

      -- add formatter
      local formatters = require "lsp.null-ls.formatters"
      local supported_formatters = {}
      for _, fmt in pairs(formatters.list_supported_names(buf_ft)) do
        local _added_formatter = fmt
        if trim then
          _added_formatter = string.sub(fmt, 1, 4)
        end
        table.insert(supported_formatters, _added_formatter)
      end
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lsp.null-ls.linters"
      local supported_linters = {}
      for _, lnt in pairs(linters.list_supported_names(buf_ft)) do
        local _added_linter = lnt
        if trim then
          _added_linter = string.sub(lnt, 1, 4)
        end
        table.insert(supported_linters, _added_linter)
      end
      vim.list_extend(buf_client_names, supported_linters)

      return table.concat(buf_client_names, ", ")
    end,
    -- icon = " ",
    color = { fg = colors.fg2 },
    cond = conditions.hide_in_width and conditions.active_lsp,
  }

  ins_right {
    function()
      return ""
    end,
    color = { fg = colors.bg1 },
    cond = conditions.check_git_workspace,
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      return ""
    end,
    color = { fg = colors.cyan, bg = colors.bg1 },
    cond = conditions.check_git_workspace,
    padding = { left = 0, right = 0 },
  }

  ins_right {
    function()
      -- return ""
      return ""
      -- icon = "", icon = "",
    end,
    color = { fg = colors.bg, bg = colors.cyan },
    cond = conditions.check_git_workspace,
    padding = { left = 0, right = 1 },
    -- left_padding = 0,
  }

  ins_right {
    "b:gitsigns_head",
    icon = "",
    cond = conditions.check_git_workspace,
    color = { fg = colors.cyan, bg = colors.bg1 },
    padding = { left = 0, right = 1 },
  }

  ins_right {
    function()
      return ""
    end,
    color = { fg = colors.bg2, bg = colors.bg1 },
    cond = conditions.buffer_not_empty and conditions.hide_in_width,
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_right {
    function()
      return ""
    end,
    color = { fg = colors.magenta, bg = colors.bg2 },
    cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_right {
    function()
      return ""
    end,
    color = { fg = colors.bg, bg = colors.magenta },
    cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    padding = { left = 0, right = 1 },
    -- left_padding = 0,
  }

  ins_right {
    "location",
    -- icon = " ",
    -- color = { fg = colors.magenta, bg = colors.bg2, gui = "bold" },
    color = { fg = colors.magenta, bg = colors.bg2 },
    cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
  }

  -- Add components to right sections
  -- ins_right {
  --   -- filesize component
  --   function()
  --     local function format_file_size(file)
  --       local size = vim.fn.getfsize(file)
  --       if size <= 0 then
  --         return ""
  --       end
  --       local sufixes = { "b", "k", "m", "g" }
  --       local i = 1
  --       while size > 1024 do
  --         size = size / 1024
  --         i = i + 1
  --       end
  --       return string.format("%.1f%s", size, sufixes[i])
  --     end
  --     local file = vim.fn.expand "%:p"
  --     if string.len(file) == 0 then
  --       return ""
  --     end
  --     return format_file_size(file)
  --   end,
  --   cond = conditions.buffer_not_empty,
  -- }

  -- ins_right {
  --   "fileformat",
  --   -- upper = true,
  --   fmt = string.upper,
  --   icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  --   color = { fg = colors.green, gui = "bold" },
  --   cond = conditions.hide_in_width,
  -- }

  -- ins_right {
  --   clock,
  --   cond = conditions.hide_in_width,
  --   color = { fg = colors.blue, bg = colors.bg },
  -- }

  -- ins_right {
  --   function()
  --     local current_line = vim.fn.line "."
  --     local total_lines = vim.fn.line "$"
  --     local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  --     local line_ratio = current_line / total_lines
  --     local index = math.ceil(line_ratio * #chars)
  --     return chars[index]
  --   end,
  --   padding = 0,
  --   -- left_padding = 0,
  --   -- right_padding = 0,
  --   color = { fg = colors.yellow, bg = colors.bg },
  --   cond = nil,
  -- }

  -- ========================================================================================================================
  -- Inactive statusline
  -- ========================================================================================================================

  ins_inactive_left {
    -- mode component
    function()
      return " "
    end,
    color = { fg = colors.bg, bg = colors.fg2 },
    padding = { left = 1, right = 0 },
  }

  ins_inactive_left {
    function()
      return " "
    end,
    color = { fg = colors.fg2, bg = colors.bg2 },
    padding = { left = 0, right = 0 },
  }

  -- ins_inactive_left {
  --   fennec_utils.harpoon,
  --   icon = " ",
  --   color = "LualineMode",
  --   cond = conditions.buffer_not_empty and conditions.hide_in_width,
  --   padding = { left = 0 },
  -- }

  ins_inactive_left {
    function()
      return ""
    end,
    color = { fg = colors.bg2, bg = colors.bg1 },
    padding = { left = 0, right = 0 },
  }

  -- root directory
  ins_inactive_left {
    function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      -- return " " .. dir_name .. "/"
      return " " .. dir_name
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_inactive_left {
    function()
      return " "
    end,
    color = { fg = colors.bg1 },
    -- cond = conditions.is_not_blacklisted_filetype,
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  ins_inactive_left {
    "filetype",
    colored = false,
    -- disable_text = true,
    icon_only = true,
    color = { fg = colors.fg2, bg = colors.bg },
    cond = conditions.buffer_not_empty and conditions.is_not_blacklisted_filetype,
    padding = { left = 0 },
    -- left_padding = 0,
  }

  -- filename
  ins_inactive_left {
    function()
      local data = vim.fn.expand "%:t"

      -- if data == "" then
      --   data = "[No Name]"
      -- end

      if vim.bo.modified then
        data = data .. " "
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        data = data .. " "
      end
      return data
    end,
    cond = conditions.buffer_not_empty and conditions.is_not_blacklisted_filetype,
    color = { fg = colors.fg2, bg = colors.bg, gui = "bold" },
    padding = { left = 1 },
    -- left_padding = 0,
  }

  ins_inactive_left {
    function()
      return " "
    end,
    color = { fg = colors.bg1 },
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  -- lir current directory root
  ins_inactive_left {
    function()
      local data = vim.fn.expand "%:~:h"
      --
      if data == "" then
        -- data = "[No Name]"
        data = ""
      elseif data == "." then
        data = ""
      else
        data = data .. "/"
      end

      return data
    end,
    cond = conditions.buffer_not_empty and conditions.is_lir,
    color = { fg = colors.fg2, bg = colors.bg, gui = "bold" },
    padding = { left = 0, right = 0 },
    -- left_padding = 0,
    -- right_padding = 0,
  }

  -- lir current directory tail
  ins_inactive_left {
    function()
      local tail = vim.fn.expand "%:~:t"
      --
      if tail == "" then
        -- data = "[No Name]"
        tail = ""
      elseif tail == "." then
        tail = ""
      else
        tail = tail .. "/"
      end

      return tail
    end,
    cond = conditions.buffer_not_empty and conditions.is_lir,
    color = { fg = colors.yellow, bg = colors.bg, gui = "bold" },
    padding = { left = 0 },
    -- left_padding = 0,
  }

  --   ins_inactive_right {
  --     "diagnostics",
  --     sources = { "nvim_lsp" },
  --     -- symbols = { error = " ", warn = " ", info = " ", hint = " " },
  --     symbols = { error = " ", warn = " ", info = " ", hint = " " },
  --     diagnostics = {
  --       error = { fg = colors.fg2, bg = colors.fg2 },
  --       warning = { fg = colors.fg2, bg = colors.fg2 },
  --       info = { fg = colors.fg2, bg = colors.fg2 },
  --       hint = { fg = colors.fg2, bg = colors.fg2 },
  --     },
  --     cond = conditions.hide_in_width,
  --   }

  ins_inactive_right {
    function()
      return " "
    end,
    -- color = { fg = colors.fg2 },
    color = { fg = colors.fg1 },
    cond = conditions.active_lsp,
    padding = { right = 0 },
    -- right_padding = 0,
  }

  ins_inactive_right {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        if #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local trim = vim.fn.winwidth(0) < 120

      -- add client
      local lsp_utils = require "lsp.utils"
      local active_client = lsp_utils.get_active_client_by_ft(buf_ft)
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          local _added_client = client.name
          if trim then
            _added_client = string.sub(client.name, 1, 4)
          end
          table.insert(buf_client_names, _added_client)
        end
      end
      vim.list_extend(buf_client_names, active_client or {})

      -- add formatter
      local formatters = require "lsp.null-ls.formatters"
      local supported_formatters = {}
      for _, fmt in pairs(formatters.list_supported_names(buf_ft)) do
        local _added_formatter = fmt
        if trim then
          _added_formatter = string.sub(fmt, 1, 4)
        end
        table.insert(supported_formatters, _added_formatter)
      end
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lsp.null-ls.linters"
      local supported_linters = {}
      for _, lnt in pairs(linters.list_supported_names(buf_ft)) do
        local _added_linter = lnt
        if trim then
          _added_linter = string.sub(lnt, 1, 4)
        end
        table.insert(supported_linters, _added_linter)
      end
      vim.list_extend(buf_client_names, supported_linters)

      return table.concat(buf_client_names, ", ")
    end,
    -- icon = " ",
    color = { fg = colors.fg2 },
    cond = conditions.hide_in_width and conditions.active_lsp,
  }

  ins_inactive_right {
    function()
      return ""
    end,
    color = { fg = colors.bg1 },
    cond = conditions.check_git_workspace,
    padding = { left = 0, right = 0 },
  }

  ins_inactive_right {
    function()
      return ""
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    cond = conditions.check_git_workspace,
    padding = { left = 0, right = 0 },
  }

  ins_inactive_right {
    function()
      -- return ""
      return ""
      -- icon = "", icon = "",
    end,
    color = { fg = colors.bg, bg = colors.fg2 },
    cond = conditions.check_git_workspace,
    padding = { left = 0, right = 1 },
    -- left_padding = 0,
  }

  ins_inactive_right {
    "b:gitsigns_head",
    icon = "",
    cond = conditions.check_git_workspace,
    color = { fg = colors.fg2, bg = colors.bg1 },
    padding = { left = 0, right = 1 },
  }

  -- ins_inactive_right {
  --   function()
  --     return ""
  --   end,
  --   color = { fg = colors.bg2, bg = colors.bg1 },
  --   cond = conditions.buffer_not_empty and conditions.hide_in_width,
  --   padding = { left = 0, right = 0 },
  --   -- left_padding = 0,
  --   -- right_padding = 0,
  -- }

  --   ins_inactive_right {
  --     function()
  --       return ""
  --     end,
  --     color = { fg = colors.fg2, bg = colors.bg2 },
  --     cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
  --     padding = { left = 0, right = 0 },
  --     -- left_padding = 0,
  --     -- right_padding = 0,
  --   }

  --   ins_inactive_right {
  --     function()
  --       return ""
  --     end,
  --     color = { fg = colors.bg, bg = colors.fg2 },
  --     cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
  --     padding = { left = 0, right = 1 },
  --     -- left_padding = 0,
  --   }

  --   ins_inactive_right {
  --     "location",
  --     -- icon = " ",
  --     -- color = { fg = colors.magenta, bg = colors.bg2, gui = "bold" },
  --     color = { fg = colors.fg2, bg = colors.bg2 },
  --     cond = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
  --   }

  -- Now don't forget to initialize lualine
  lvim.builtin.lualine.options = config.options
  lvim.builtin.lualine.sections = config.sections
  lvim.builtin.lualine.inactive_sections = config.inactive_sections
end

return M