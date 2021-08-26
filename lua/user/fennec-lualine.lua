-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require "lualine"
local gps = require "nvim-gps"

-- Color table for highlights
local colors = {
  bg2 = "#433E3A",
  bg = "#433E3A", -- default
  fg2 = "#7c6f64",
  fg = "#d4be98",
  fg_alt = "#ddc7a1",
  yellow = "#d8a657",
  cyan = "#89b482",
  green = "#a9b665",
  orange = "#e78a4e",
  magenta = "#d3869b",
  blue = "#7daea3",
  red = "#ea6962",
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  gps_available = gps.is_available,
}

local function harpoon()
  local status = require("harpoon.mark").status()
  if status == "" then
    return ""
  end
  return string.format("%s", status)
end

local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

local extensions = {
  -- my_extension = { sections = { lualine_c = { "mode" } }, filetypes = { "lua" } },
  nerdtree = {
    sections = {
      lualine_c = {
        function()
          return "  " .. get_short_cwd()
          -- פּ
        end,
      },
    },
    filetypes = { "NvimTree" },
  },
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme.
      -- So we are just setting default looks o statusline
      normal = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.fg2, bg = colors.bg },
        b = { fg = colors.fg2, bg = colors.bg },
        c = { fg = colors.fg2, bg = colors.bg },
        x = { fg = colors.fg2, bg = colors.bg },
        y = { fg = colors.fg2, bg = colors.bg },
        z = { fg = colors.fg2, bg = colors.bg },
      },
    },
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
  extensions = { extensions.nerdtree },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Inserts a component in lualine_c at left INACTIVE section
local function ins_inactive_left(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right INACTIVE section
local function ins_inactive_right(component)
  table.insert(config.inactive_sections.lualine_x, component)
end

-- ﱮ (maybe this should be the default if file_icon not found)
-- default color = "#6d8086",
-- some extra icons         
require("nvim-web-devicons").setup {
  override = {
    norg = {
      icon = "",
      color = "#558140",
      name = "Norg",
    },
    org = {
      icon = "",
      color = "#d3869b",
      name = "Org",
    },
    sh = {
      icon = "",
      color = "#a9b665",
      name = "Shell",
    },
  },
}

ins_left {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.green,
      i = colors.red,
      v = colors.yellow,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.magenta,
      Rv = colors.magenta,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
    -- \2644 return "" return ""
    return "▊"
  end,
  color = "LualineMode",
  left_padding = 0,
  right_padding = 0,
}

ins_left {
  "branch",
  icon = "",
  -- icon = "", icon = "", icon = "",
  condition = conditions.check_git_workspace,
  color = { fg = colors.cyan, gui = "bold" },
}

ins_left {
  "diff",
  -- Is it me or the symbol for modified is really weird
  symbols = { added = " ", modified = "柳", removed = " " },
  color_added = { fg = colors.green },
  color_modified = { fg = colors.orange },
  color_removed = { fg = colors.red },
  condition = conditions.hide_in_width,
}

-- ins_left {
--   function()
--     local filetype = vim.bo.filetype
--     if filetype == "" then
--       return ""
--     end
--     local filename, fileext = vim.fn.expand "%:t", vim.fn.expand "%:e"
--     local icon = require("nvim-web-devicons").get_icon(filename, fileext, { default = true })
--     return string.format("%s", icon)
--   end,
-- }

ins_left {
  "filetype",
  colored = true,
  disable_text = true,
}

ins_left {
  "filename",
  condition = conditions.buffer_not_empty,
  -- color = { fg = colors.magenta, gui = "bold" },
  color = { fg = colors.fg, gui = "bold" },
  path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
  left_padding = 0,
}

ins_left {
  gps.get_location,
  condition = conditions.gps_available,
  color = { fg = colors.blue },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left {
--   function()
--     return "%="
--   end,
-- }

-- Add components to right sections

ins_right {
  "diagnostics",
  sources = { "nvim_lsp" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  color_error = { fg = colors.red },
  color_warn = { fg = colors.yellow },
  color_info = { fg = colors.cyan },
  color_hint = { fg = colors.blue },
  condition = conditions.hide_in_width,
}

ins_right {
  -- Lsp server name .
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return ""
      -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
      -- return (vim.bo.filetype:gsub("^%l", string.upper))
    end
    local lsps = ""
    for _, client in ipairs(clients) do
      if client.name ~= "null-ls" then
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          if lsps == "" then
            lsps = client.name
          else
            if not string.find(lsps, client.name) then
              lsps = lsps .. ", " .. client.name
            end
          end
        end
      end
    end
    if lsps == "" then
      return ""
      -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
      -- return (vim.bo.filetype:gsub("^%l", string.upper))
    else
      return lsps
    end
  end,
  icon = " ",
  --    s
  color = { fg = colors.magenta, gui = "bold" },
}

ins_right {
  "location",
  icon = " ",
  color = { fg = colors.fg, gui = "bold" },
}

ins_right {
  "progress",
  color = { gui = "bold" },
  left_padding = 0,
}

ins_right {
  harpoon,
  --  ﯀ ﰳ    ﴱ \E943
  icon = " ",
  color = { fg = colors.blue },
}

ins_inactive_left {
  "branch",
  icon = "",
  -- icon = "", icon = "", icon = "",
  condition = conditions.check_git_workspace,
  color = { fg = colors.fg2, gui = "bold" },
}

ins_inactive_left {
  "filetype",
  colored = false,
  disable_text = true,
}

ins_inactive_left {
  "filename",
  condition = conditions.buffer_not_empty,
  color = { fg = colors.fg2, gui = "bold" },
  path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
  left_padding = 0,
}

ins_inactive_right {
  -- Lsp server name
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return ""
      -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
      -- return (vim.bo.filetype:gsub("^%l", string.upper))
    end
    local lsps = ""
    for _, client in ipairs(clients) do
      if client.name ~= "null-ls" then
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          if lsps == "" then
            lsps = client.name
          else
            if not string.find(lsps, client.name) then
              lsps = lsps .. ", " .. client.name
            end
          end
        end
      end
    end
    if lsps == "" then
      return ""
      -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
      -- return (vim.bo.filetype:gsub("^%l", string.upper))
    else
      return lsps
    end
  end,
  icon = " ",
  --    s
  color = { fg = colors.fg2, gui = "bold" },
}

ins_inactive_right {
  "location",
  icon = " ",
  color = { fg = colors.fg2, gui = "bold" },
}

ins_inactive_right {
  "progress",
  color = { fg = colors.fg2, gui = "bold" },
  left_padding = 0,
}

-- Now don't forget to initialize lualine
lualine.setup(config)
