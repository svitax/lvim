local M = {}

M.config = function(gl)
  -- local gl = require "galaxyline"
  -- TODO: galaxyline themes
  -- local colors = require('galaxyline.theme').default
  local colors = {
    -- bg = "#32302f",
    bg = "#3c3836",
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

  local bo = vim.bo
  local condition = require "galaxyline.condition"
  local gls = gl.section
  -- local lsp = require("galaxyline.provider_lsp")
  local buffer = require "galaxyline.provider_buffer"
  gl.short_line_list = { "NvimTree", "vista", "dbui", "packer", "minimap", "Outline", "toggleterm" }

  local function is_dashboard()
    local buftype = buffer.get_buffer_filetype()
    if buftype == "DASHBOARD" then
      return true
    end
  end

  local function is_not_dashboard()
    local buftype = buffer.get_buffer_filetype()
    if buftype ~= "DASHBOARD" then
      return true
    end
  end

  -- need to wipe out the lunarvim builtin config for galaxyline
  gls.left = {}
  gls.right = {}
  gls.short_line_left = {}
  gls.short_line_right = {}

  gls.left[1] = {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
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
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
        return "▊ "
        -- return "  "
      end,
      highlight = { colors.red, colors.bg, "bold" },
    },
  }

  local function env_cleanup(venv)
    if string.find(venv, "/") then
      local final_venv = venv
      for w in venv:gmatch "([^/]+)" do
        final_venv = w
      end
      venv = final_venv
    end
    return venv
  end
  local PythonEnv = function()
    if bo.filetype == "python" then
      local venv = os.getenv "CONDA_DEFAULT_ENV"
      if venv ~= nil then
        -- return "  (" .. env_cleanup(venv) .. ")"
        return " (" .. env_cleanup(venv) .. ") "
      end
      venv = os.getenv "VIRTUAL_ENV"
      if venv ~= nil then
        -- return "  (" .. env_cleanup(venv) .. ")"
        return " (" .. env_cleanup(venv) .. ") "
      end
      return ""
    end
    return ""
  end

  gls.left[2] = {
    VirtualEnv = {
      provider = PythonEnv,
      event = "BufEnter",
      highlight = { colors.green, colors.bg },
    },
  }
  gls.left[3] = {
    FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
    },
  }
  gls.left[4] = {
    FileName = {
      provider = "FileName",
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = { colors.fg, colors.bg, "bold" },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.left[5] = {
    LineInfo = {
      provider = function()
        local line = vim.fn.line "."
        local column = vim.fn.col "."
        return string.format("%3d : %2d  ", line, column)
      end,
      condition = is_not_dashboard,
      highlight = { colors.fg_alt, colors.bg },
    },
  }
  gls.left[6] = {
    LinePercent = {
      provider = "LinePercent",
      condition = is_not_dashboard,
      highlight = { colors.fg_alt, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.left[7] = {
    DiagnosticError = {
      provider = "DiagnosticError",
      condition = is_not_dashboard,
      icon = "  ",
      highlight = { colors.red, colors.bg },
    },
  }
  gls.left[8] = {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      condition = is_not_dashboard,
      icon = "  ",
      highlight = { colors.red, colors.bg },
    },
  }
  gls.left[9] = {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      condition = is_not_dashboard,
      icon = "  ",
      highlight = { colors.blue, colors.bg },
    },
  }

  -- Right side
  gls.right[1] = {
    FileFormat = {
      provider = "FileFormat",
      condition = condition.hide_in_width and is_not_dashboard,
      highlight = { colors.fg, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.right[2] = {
    FileEncode = {
      provider = "FileEncode",
      condition = condition.hide_in_width and is_not_dashboard,
      highlight = { colors.fg, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }

  local get_lsp_client = function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return "︁ " .. (bo.filetype:gsub("^%l", string.upper))
      -- return " " .. (bo.filetype:gsub("^%l", string.upper))
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
      return "︁ " .. (bo.filetype:gsub("^%l", string.upper))
      -- return " " .. (bo.filetype:gsub("^%l", string.upper))
    else
      return " " .. lsps
      -- return " " .. lsps
      -- return "異" .. lsps
      -- return " " .. lsps
      -- return "  " .. lsps
    end
  end

  gls.right[3] = {
    ShowLspClientOrFileType = {
      provider = get_lsp_client,
      condition = function()
        local tbl = { ["dashboard"] = true, [""] = true }
        if tbl[bo.filetype] then
          return false
        end
        return true
      end,
      highlight = { colors.blue, colors.bg },
      separator = "  ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.right[4] = {
    GitIcon = {
      provider = function()
        -- return "  "
        return " "
      end,
      condition = condition.check_git_workspace,
      highlight = { colors.cyan, colors.bg },
      separator = "  ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.right[5] = {
    GitBranch = {
      provider = "GitBranch",
      condition = condition.check_git_workspace,
      highlight = { colors.cyan, colors.bg },
      separator = "",
      separator_highlight = { "NONE", colors.bg },
    },
  }
  gls.right[6] = {
    DiffAdd = {
      provider = "DiffAdd",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = " ",
      -- icon = " ",
      separator = "  ",
      separator_highlight = { "NONE", colors.bg },
      highlight = { colors.green, colors.bg },
    },
  }
  gls.right[7] = {
    DiffModified = {
      provider = "DiffModified",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = " 柳",
      -- icon = " ",
      separator = "",
      separator_highlight = { "NONE", colors.bg },
      highlight = { colors.orange, colors.bg },
    },
  }
  gls.right[8] = {
    DiffRemove = {
      provider = "DiffRemove",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = "  ",
      -- icon = " ",
      separator = "",
      separator_highlight = { "NONE", colors.bg },
      highlight = { colors.red, colors.bg },
    },
  }
  -- If the current buffer is the dashboard then show Doom Nvim version
  if is_dashboard then
    gls.right[9] = {
      DoomVersion = {
        provider = function()
          return "LunarVim "
          -- return 'DOOM v' .. utils.doom_version .. ' '
        end,
        condition = is_dashboard,
        highlight = { colors.blue, colors.bg, "bold" },
        -- highlight = { get_color('blue'), get_color('bg'), 'bold' },
        separator = "  ",
        separator_highlight = { colors.bg, colors.bg },
      },
    }
  end

  -- Short status line
  gls.short_line_left[1] = {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
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
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
        -- return "  "
        return "▊ "
      end,
      highlight = { colors.red, colors.bg, "bold" },
    },
  }

  gls.short_line_left[2] = {
    BufferType = {
      provider = "FileTypeName",
      condition = is_not_dashboard,
      highlight = { colors.fg, colors.bg },
      separator = " ",
      separator_highlight = { "NONE", colors.bg },
    },
  }

  gls.short_line_right[1] = {
    BufferIcon = {
      provider = "BufferIcon",
      condition = is_not_dashboard,
      highlight = { colors.yellow, colors.bg },
    },
  }
end

return M
