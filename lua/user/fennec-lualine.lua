-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require "lualine"
local gps = require "nvim-gps"

-- Color table for highlights
local colors = {
  bg = "#3c3836",
  bg1 = "#433E3A",
  bg2 = "#504945",

  fg1 = "#928374",
  fg2 = "#7c6f64", -- good with bg
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

-- TODO: condition where component won't show if statusline too short
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

-- local function harpoon()
--   local status = require("harpoon.mark").status()
--   if status == "" then
--     return ""
--   end
--   return string.format("%s", status)
-- end

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
      n = colors.yellow,
      i = colors.blue,
      v = colors.orange,
      [""] = colors.green,
      V = colors.green,
      c = colors.red,
      no = colors.orange,
      s = colors.red,
      S = colors.red,
      [""] = colors.red,
      ic = colors.blue,
      R = colors.orange,
      Rv = colors.orange,
      cv = colors.orange,
      ce = colors.orange,
      r = colors.blue,
      rm = colors.blue,
      ["r?"] = colors.blue,
      ["!"] = colors.orange,
      t = colors.orange,
    }
    vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg2)
    vim.api.nvim_command("hi! LualineModeBg guifg=" .. colors.bg2 .. " guibg=" .. mode_color[vim.fn.mode()])
    -- \2644 return "" return ""
    -- return "▊"
    -- return ""
    return " "
  end,
  color = "LualineModeBg",
  left_padding = 1,
  right_padding = 0,
}

ins_left {
  function()
    return " "
  end,
  color = "LualineMode",
  left_padding = 0,
  right_padding = 0,
}

-- ins_left {
--   harpoon,
--   --  ﯀ ﰳ    ﴱ \E943
--   -- icon = " ",
--   color = "LualineMode",
--   condition = conditions.buffer_not_empty and conditions.hide_in_width,
--   left_padding = 0,
--   -- right_padding = 0,
-- }

ins_left {
  function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. dir_name .. "/"
  end,
  color = { fg = colors.fg1, bg = colors.bg2 },
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
  left_padding = 0,
  right_padding = 0,
}

ins_left {
  -- "filename",
  function()
    local function count(base, pattern)
      return select(2, string.gsub(base, pattern, ""))
    end

    local function shorten_path(path, sep)
      -- ('([^/])[^/]+%/', '%1/', 1)
      return path:gsub(string.format("([^%s])[^%s]+%%%s", sep, sep, sep), "%1" .. sep, 1)
    end

    local data = vim.fn.expand "%:~:.:h"

    if data == "" then
      data = "[No Name]"
    elseif data == "." then
      data = ""
    else
      data = data .. "/"
    end

    local windwidth = vim.fn.winwidth(0)
    local estimated_space_available = 40
    local path_separator = package.config:sub(1, 1)
    for _ = 0, count(data, path_separator) do
      if windwidth <= 84 or #data > estimated_space_available then
        data = shorten_path(data, path_separator)
      end
    end

    return data
  end,
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
  color = { fg = colors.fg1, bg = colors.bg2 },
  left_padding = 0,
  right_padding = 0,
}

ins_left {
  function()
    return " "
  end,
  color = { fg = colors.bg2, bg = colors.bg1 },
  left_padding = 0,
  right_padding = 0,
}

ins_left {
  "filetype",
  colored = true,
  disable_text = true,
  color = { fg = colors.bg1, bg = colors.bg1 },
  condition = conditions.buffer_not_empty,
  left_padding = 0,
}

ins_left {
  function()
    local data = vim.fn.expand "%:t"

    if data == "" then
      data = "[No Name]"
    end

    if vim.bo.modified then
      data = data .. " "
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      data = data .. " "
    end
    return data
  end,
  condition = conditions.buffer_not_empty,
  color = { fg = colors.fg, bg = colors.bg1, gui = "bold" },
  left_padding = 0,
}

ins_left {
  function()
    return " "
  end,
  color = { fg = colors.bg1 },
  left_padding = 0,
  right_padding = 0,
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
  gps.get_location,
  -- condition = conditions.gps_available,
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
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
  function()
    return " "
  end,
  color = { fg = colors.fg2 },
  right_padding = 0,
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
  -- icon = " ",
  --    
  color = { fg = colors.fg2, gui = "bold" },
  right_padding = 0,
}

ins_right {
  function()
    return ""
  end,
  color = { fg = colors.bg2 },
  condition = conditions.check_git_workspace,
  left_padding = 0,
  right_padding = 0,
}

ins_right {
  function()
    return ""
  end,
  color = { fg = colors.cyan },
  condition = conditions.check_git_workspace,
  left_padding = 0,
  right_padding = 0,
}

ins_right {
  function()
    -- return ""
    return ""
    -- icon = "", icon = "",
  end,
  color = { fg = colors.bg, bg = colors.cyan },
  condition = conditions.check_git_workspace,
  left_padding = 0,
}

ins_right {
  "branch",
  icon = "",
  condition = conditions.check_git_workspace,
  -- color = { fg = colors.cyan, bg = colors.bg2, gui = "bold" },
  color = { fg = colors.cyan, bg = colors.bg2 },
  left_padding = 0,
  right_padding = 0,
}

ins_right {
  function()
    return ""
  end,
  color = { fg = colors.bg2, bg = colors.bg1 },
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
  left_padding = 0,
  right_padding = 0,
}

ins_right {
  function()
    return ""
  end,
  color = { fg = colors.magenta, bg = colors.bg2 },
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
  left_padding = 0,
  right_padding = 0,
}

ins_right {
  function()
    return ""
  end,
  color = { fg = colors.bg, bg = colors.magenta },
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
  left_padding = 0,
}

ins_right {
  "location",
  -- icon = " ",
  -- color = { fg = colors.magenta, bg = colors.bg2, gui = "bold" },
  color = { fg = colors.magenta, bg = colors.bg2 },
  condition = conditions.buffer_not_empty and conditions.hide_in_width,
}

-- TODO: add a scrollbar plugin
-- ins_right {
--   "progress",
--   color = { fg = colors.magenta, bg = colors.bg2, gui = "bold" },
--   condition = conditions.buffer_not_empty and conditions.hide_in_width,
-- }

-- Inactive statusline
-- ========================================================================================================================
-- ========================================================================================================================

ins_inactive_left {
  -- mode component
  function()
    return " "
  end,
  color = { fg = colors.bg, bg = colors.fg2 },
  left_padding = 1,
  right_padding = 0,
}

ins_inactive_left {
  function()
    return " "
  end,
  color = { fg = colors.fg2, bg = colors.bg1 },
  left_padding = 0,
  right_padding = 0,
}
--
-- ins_inactive_left {
--   function()
--     local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--     return " " .. dir_name .. "/"
--   end,
--   color = { fg = colors.fg2, bg = colors.bg2 },
--   condition = conditions.buffer_not_empty and conditions.hide_in_width,
--   -- left_padding = 0,
--   right_padding = 0,
-- }
--
-- ins_inactive_left {
--   -- "filename",
--   function()
--     local function count(base, pattern)
--       return select(2, string.gsub(base, pattern, ""))
--     end
--
--     local function shorten_path(path, sep)
--       -- ('([^/])[^/]+%/', '%1/', 1)
--       return path:gsub(string.format("([^%s])[^%s]+%%%s", sep, sep, sep), "%1" .. sep, 1)
--     end
--
--     local data = vim.fn.expand "%:~:.:h"
--
--     if data == "" then
--       data = "[No Name]"
--     elseif data == "." then
--       data = ""
--     else
--       data = data .. "/"
--     end
--
--     local windwidth = vim.fn.winwidth(0)
--     local estimated_space_available = 40
--     local path_separator = package.config:sub(1, 1)
--     for _ = 0, count(data, path_separator) do
--       if windwidth <= 84 or #data > estimated_space_available then
--         data = shorten_path(data, path_separator)
--       end
--     end
--
--     return data
--   end,
--   condition = conditions.buffer_not_empty and conditions.hide_in_width,
--   color = { fg = colors.fg2, bg = colors.bg2 },
--   left_padding = 0,
--   right_padding = 0,
-- }
--
-- ins_inactive_left {
--   function()
--     return " "
--   end,
--   color = { fg = colors.bg2, bg = colors.bg1 },
--   left_padding = 0,
--   right_padding = 0,
-- }

ins_inactive_left {
  "filetype",
  colored = false,
  disable_text = true,
  color = { fg = colors.fg2, bg = colors.bg1 },
  condition = conditions.buffer_not_empty,
  left_padding = 0,
}

ins_inactive_left {
  function()
    local data = vim.fn.expand "%:t"

    if data == "" then
      data = "[No Name]"
    end

    if vim.bo.modified then
      data = data .. " "
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      data = data .. " "
    end
    return data
  end,
  condition = conditions.buffer_not_empty,
  color = { fg = colors.fg2, bg = colors.bg1 },
  left_padding = 0,
}

ins_inactive_left {
  function()
    return " "
  end,
  color = { fg = colors.bg1 },
  left_padding = 0,
  right_padding = 0,
}

ins_inactive_right {
  function()
    return ""
  end,
  condition = conditions.check_git_workspace,
  color = { fg = colors.bg1 },
  left_padding = 0,
  right_padding = 0,
}

ins_inactive_right {
  function()
    return ""
  end,
  condition = conditions.check_git_workspace,
  color = { fg = colors.fg2 },
  left_padding = 0,
  right_padding = 0,
}

ins_inactive_right {
  function()
    -- return ""
    return ""
    -- icon = "", icon = "",
  end,
  condition = conditions.check_git_workspace,
  color = { fg = colors.bg, bg = colors.fg2 },
  left_padding = 0,
}

ins_inactive_right {
  "branch",
  icon = "",
  condition = conditions.check_git_workspace,
  color = { fg = colors.fg2, bg = colors.bg1 },
  left_padding = 0,
  right_padding = 0,
}

-- Now don't forget to initialize lualine
lualine.setup(config)

-- ins_left {
--   "diff",
--   -- Is it me or the symbol for modified is really weird
--   symbols = { added = " ", modified = "柳", removed = " " },
--   color_added = { fg = colors.green },
--   color_modified = { fg = colors.orange },
--   color_removed = { fg = colors.red },
--   condition = conditions.hide_in_width,
-- }
