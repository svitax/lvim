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

local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

local function fugitive_branch()
  local icon = " " --
  return icon .. " " .. vim.fn.FugitiveHead()
end

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
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
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- TODO custom icon for norg, lir, and maybe nvimtree
-- I can do this by overriding nvim-web-devicons or write some logic in here
-- the benefit of doing it in nvim-web-devicons is the easier way to define colors
-- ﱮ (maybe this should be the default if file_icon not found)
-- default color = "#6d8086",
-- some extra icons         
-- unforunately now I can't override in a different file
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
    lir = {
      icon = "",
      color = "#6d8086",
      name = "Lir",
    },
  },
}

-- ins_left {
--   function()
--     return "▊"
--   end,
--   -- color = { fg = colors.blue }, -- Sets highlighting of component
--   color = { fg = colors.bg, bg = colors.bg },
--   left_padding = 0, -- We don't need space before this
-- }

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
    -- return ""
    return "▊"
  end,
  color = "LualineMode",
  left_padding = 0,
  right_padding = 0,
}

ins_left {
  function()
    -- return ""
    return ""
  end,
  condition = conditions.check_git_workspace,
  color = { fg = colors.cyan, gui = "bold" },
  right_padding = 0,
}

ins_left {
  "branch",
  left_padding = 0,
  icon = "",
  -- icon = "",
  -- icon = "",
  -- icon = "",
  condition = conditions.check_git_workspace,
  -- color = { fg = colors.fg, gui = "bold" },
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
  left_padding = 0,
}

ins_left {
  gps.get_location,
  condition = conditions.gps_available,
  color = { fg = colors.magenta },
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
  symbols = { error = " ", warn = " ", info = " " },
  color_error = { fg = colors.red },
  color_warn = { fg = colors.yellow },
  color_info = { fg = colors.cyan },
  condition = conditions.hide_in_width,
}

-- ins_right {
--   function()
--     -- return ""
--     return " "
--   end,
--   color = { fg = colors.blue, gui = "bold" },
--   right_padding = 0,
-- }

ins_right {
  -- Lsp server name .
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      -- return ""
      -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
      return (vim.bo.filetype:gsub("^%l", string.upper))
    end
    local lsps = ""
    for _, client in ipairs(clients) do
      if client.name ~= "null-ls" then
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          -- print(client.name)
          if lsps == "" then
            -- print("first", lsps)
            lsps = client.name
          else
            if not string.find(lsps, client.name) then
              lsps = lsps .. ", " .. client.name
            end
            -- print("more", lsps)
          end
        end
      end
    end
    if lsps == "" then
      return ""
      -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
      -- return (vim.bo.filetype:gsub("^%l", string.upper))
    else
      -- return " " .. lsps
      -- return " " .. lsps
      -- return "異" .. lsps
      -- return " " .. lsps
      -- return "  " .. lsps
      return lsps
    end
  end,
  icon = " ",
  color = { fg = colors.blue, gui = "bold" },
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

-- ins_right {
--   function()
--     return "▊"
--   end,
--   -- color = { fg = colors.blue },
--   color = { fg = colors.bg, bg = colors.bg },
--   right_padding = 0,
-- }

-- Now don't forget to initialize lualine
lualine.setup(config)
