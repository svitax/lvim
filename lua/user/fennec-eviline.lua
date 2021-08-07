local M = {}

M.config = function(gl)
  -- local gl = require "galaxyline"
  -- TODO galaxyline themes
  -- local colors = require('galaxyline.theme').default
  local colors = {
    -- bg = "#32302f",
    -- bg = "#3c3836",

    bg2 = "#433E3A",
    -- bg2 = "#32302f", -- default

    bg = "#433E3A", -- default
    -- bg = "#504945",

    -- fg2 = "#a89984",
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

  local condition = require "galaxyline.condition"
  local gls = gl.section
  local bo = vim.bo
  -- local lsp = require("galaxyline.provider_lsp")
  local buffer = require "galaxyline.provider_buffer"

  gl.short_line_list = { "NvimTree", "vista", "dbui", "packer", "minimap", "Outline", "toggleterm", "LspTrouble" }

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

  local get_lsp_client = function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      -- return ""
      -- return " " .. (bo.filetype:gsub("^%l", string.upper))
      return (bo.filetype:gsub("^%l", string.upper))
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
      -- return ""
      -- return " " .. (bo.filetype:gsub("^%l", string.upper))
      return (bo.filetype:gsub("^%l", string.upper))
    else
      -- return " " .. lsps
      -- return " " .. lsps
      -- return "異" .. lsps
      -- return " " .. lsps
      return " " .. lsps
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
  gls.left[2] = {
    VirtualEnv = {
      provider = PythonEnv,
      event = "BufEnter",
      highlight = { colors.green, colors.bg },
    },
  }

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
      lir = {
        icon = "",
        color = "#6d8086",
        name = "Lir",
      },
    },
  }
  gls.left[3] = {
    FileIcon = {
      -- provider = "FileIcon",
      provider = function()
        local icon = require("galaxyline.provider_fileinfo").get_file_icon()
        if icon == " " then
          -- return " "
          return " "
        else
          return icon
        end
      end,
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
    },
  }
  gls.left[4] = {
    FileName = {
      -- provider = "FileName",
      provider = function()
        local file_name = require("galaxyline.provider_fileinfo").get_current_file_name()
        if file_name == ". " then
          return bo.filetype:gsub("^%l", string.upper)
        else
          return file_name
        end
      end,
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = { colors.fg, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.left[5] = {
    GitIcon = {
      provider = function()
        return ""
        -- return " "
      end,
      condition = condition.check_git_workspace,
      highlight = { colors.cyan, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.left[6] = {
    GitBranch = {
      provider = "GitBranch",
      condition = condition.check_git_workspace,
      highlight = { colors.cyan, colors.bg },
      separator = "  ",
      separator_highlight = { "NONE", colors.bg },
    },
  }
  gls.left[7] = {
    DiffSeparator = {
      provider = function()
        return ""
      end,
      condition = is_not_dashboard,
      highlight = { colors.bg, colors.bg },
    },
  }
  gls.left[8] = {
    DiffAdd = {
      provider = "DiffAdd",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = " ",
      -- icon = " ",
      separator = "",
      separator_highlight = { colors.br, colors.bg },
      highlight = { colors.green, colors.bg },
    },
  }
  gls.left[9] = {
    DiffModified = {
      provider = "DiffModified",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = "柳",
      -- icon = " ",
      separator = "",
      separator_highlight = { "NONE", colors.bg },
      highlight = { colors.orange, colors.bg },
    },
  }
  gls.left[10] = {
    DiffRemove = {
      provider = "DiffRemove",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = " ",
      -- icon = " ",
      separator = "",
      separator_highlight = { "NONE", colors.bg },
      highlight = { colors.red, colors.bg },
    },
  }

  -- LSP STATUS
  -- =====================================
  -- local lsp_status = require "lsp-status"
  -- lsp_status.config {
  --   indicator_errors = "E",
  --   indicator_warnings = "W",
  --   indicator_info = "i",
  --   indicator_hint = "?",
  --   indicator_ok = "Ok",
  --   diagnostics = false,
  --   status_symbol = "",
  -- }
  -- lsp_status.register_progress()
  -- gls.left[10] = {
  --   LspStatus = {
  --     provider = function()
  --       -- TODO get current function to show, and find a way to only show current function
  --       return lsp_status.status()
  --     end,
  --     -- event = "BufEnter",
  --     separator = " ",
  --     separator_highlight = { colors.bg, colors.bg },
  --     highlight = { colors.fg, colors.bg },
  --   },
  -- }

  -- File Format and File Encoding
  -- =====================================
  -- Right side
  -- gls.right[1] = {
  --   FileFormat = {
  --     provider = "FileFormat",
  --     condition = condition.hide_in_width and is_not_dashboard,
  --     highlight = { colors.fg, colors.bg },
  --     separator = " ",
  --     separator_highlight = { colors.bg, colors.bg },
  --   },
  -- }
  -- gls.right[2] = {
  --   FileEncode = {
  --     provider = "FileEncode",
  --     condition = condition.hide_in_width and is_not_dashboard,
  --     highlight = { colors.fg, colors.bg },
  --     separator = " ",
  --     separator_highlight = { colors.bg, colors.bg },
  --   },
  -- }

  -- Line Percent and Location
  -- =====================================
  -- is there a galaxyline provider for line percent?
  -- local file_name = require("galaxyline.provider_fileinfo").get_current_file_name()
  -- gls.left[6] = {
  --   LinePercent = {
  --     provider = "LinePercent",
  --     condition = is_not_dashboard,
  --     highlight = { colors.fg_alt, colors.bg },
  --     separator = " ",
  --     separator_highlight = { colors.bg, colors.bg },
  --   },
  -- }

  gls.right[1] = {
    ShowLspClientOrFileType = {
      provider = get_lsp_client,
      condition = function()
        local tbl = { ["dashboard"] = true, [""] = true }
        if tbl[bo.filetype] then
          return false
        end
        return true
      end,
      highlight = { colors.green, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.right[2] = {
    LineInfo = {
      provider = function()
        local line = vim.fn.line "."
        local column = vim.fn.col "."
        return string.format("%3d : %2d  ", line, column)
      end,
      condition = is_not_dashboard,
      highlight = { colors.fg, colors.bg },
      separator = "  ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  -- TODO rewrite this provider using builtin galaxyline providers
  gls.right[3] = {
    FileLocation = {
      icon = " ",
      separator = "",
      separator_highlight = { colors.bg, colors.bg },
      highlight = { colors.fg, colors.bg },
      condition = is_not_dashboard,
      provider = function()
        local current_line = vim.fn.line "."
        local total_lines = vim.fn.line "$"

        if current_line == 1 then
          return "Top"
        elseif current_line == total_lines then
          return "Bot"
        end

        local percent, _ = math.modf((current_line / total_lines) * 100)
        return "" .. percent .. "%"
      end,
    },
  }
  gls.right[4] = {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      condition = is_not_dashboard,
      icon = " ",
      highlight = { colors.blue, colors.bg },
      separator = "  ",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.right[5] = {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      condition = is_not_dashboard,
      icon = " ",
      highlight = { colors.orange, colors.bg },
      separator = "",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  gls.right[6] = {
    DiagnosticError = {
      provider = "DiagnosticError",
      condition = is_not_dashboard,
      icon = " ",
      highlight = { colors.red, colors.bg },
      separator = "",
      separator_highlight = { colors.bg, colors.bg },
    },
  }
  -- If the current buffer is the dashboard then show LunarVim version
  if is_dashboard then
    gls.right[7] = {
      DoomVersion = {
        provider = function()
          return " LunarVim "
          -- return 'DOOM v' .. utils.doom_version .. ' '
        end,
        condition = is_dashboard,
        highlight = { colors.blue, colors.bg, "bold" },
        separator = "  ",
        separator_highlight = { colors.bg, colors.bg },
      },
    }
  end

  -- Short status line
  gls.short_line_left[1] = {
    Short_RainbowLeft = {
      provider = function()
        return "▊ "
      end,
      highlight = { colors.bg2, colors.bg2 },
    },
  }
  gls.short_line_left[2] = {
    VirtualEnv = {
      provider = PythonEnv,
      event = "BufEnter",
      highlight = { colors.fg2, colors.bg2 },
    },
  }
  gls.short_line_left[3] = {
    Short_FileIcon = {
      -- provider = "FileIcon",
      provider = function()
        local icon = require("galaxyline.provider_fileinfo").get_file_icon()
        if icon == " " then
          -- return " "
          return "ﱮ "
        else
          return icon
        end
      end,
      condition = condition.buffer_not_empty and is_not_dashboard,
      -- highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
      highlight = { colors.fg2, colors.bg2 },
    },
  }
  gls.short_line_left[4] = {
    Short_FileName = {
      -- provider = "FileName",
      provider = function()
        local file_name = require("galaxyline.provider_fileinfo").get_current_file_name()
        if file_name == ". " then
          return bo.filetype:gsub("^%l", string.upper)
        else
          return file_name
        end
      end,
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = { colors.fg2, colors.bg2 },
      separator = " ",
      separator_highlight = { colors.bg2, colors.bg2 },
    },
  }

  gls.short_line_right[1] = {
    Short_ShowLspClientOrFileType = {
      provider = get_lsp_client,
      condition = function()
        local tbl = { ["dashboard"] = true, [""] = true }
        if tbl[bo.filetype] then
          return false
        end
        return true
      end,
      highlight = { colors.fg2, colors.bg2 },
      separator = "  ",
      separator_highlight = { colors.bg2, colors.bg2 },
    },
  }
end

return M
