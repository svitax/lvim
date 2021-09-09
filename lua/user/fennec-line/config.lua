local M = {}

local colors = require "user.lualine.colors"
local gps = require "nvim-gps"

M.config = function()
  -- populate the lvim lualine sections with an "empty" config so we start fresh and add what we want
  require("user.fennec-line.init").init()

  local utils = require("user.fennec-line.utils").utils
  local conditions = require("user.fennec-line.conditions").conditions

  -- Start adding the compoenents

  -- ====================================================
  -- Active statusline
  -- ====================================================
  utils.ins_left {
    -- mode component
    function()
      -- auto change color according to neovims mode
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
      vim.api.nvim_command(
        "hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg2 .. " gui=bold"
      )
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

  utils.ins_left {
    function()
      return " "
    end,
    color = "LualineMode",
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_left {
    utils.harpoon,
    -- utils.harpoon,
    --  ﯀ ﰳ    ﴱ \E943
    icon = " ",
    color = "LualineMode",
    condition = conditions.buffer_not_empty and conditions.hide_in_width,
    left_padding = 0,
    -- right_padding = 0,
  }

  utils.ins_left {
    function()
      local filename = vim.fn.expand "%:t"
      local term_number = filename:sub(-1)
      if term_number == "2" then
        term_number = "F"
      elseif term_number == "3" then
        term_number = "D"
      end

      return "  " .. term_number
    end,
    color = "LualineMode",
    condition = conditions.is_toggleterm,
    left_padding = 0,
  }

  utils.ins_left {
    function()
      return ""
    end,
    color = { fg = colors.bg2, bg = colors.bg1 },
    left_padding = 0,
    right_padding = 0,
  }

  -- lir filetype
  utils.ins_left {
    function()
      return " lir"
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    condition = conditions.is_lir,
    -- left_padding = 0,
  }

  -- root directory
  utils.ins_left {
    function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      -- return " " .. dir_name .. "/"
      return " " .. dir_name
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    condition = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    -- left_padding = 0,
    -- right_padding = 0,
  }

  utils.ins_left {
    function()
      return " "
    end,
    color = { fg = colors.bg1 },
    -- condition = conditions.is_not_blacklisted_filetype,
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_left {
    "filetype",
    colored = true,
    disable_text = true,
    color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
    condition = conditions.buffer_not_empty and conditions.is_not_blacklisted_filetype,
    left_padding = 0,
  }

  -- filename
  utils.ins_left {
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
    condition = conditions.buffer_not_empty and conditions.is_not_blacklisted_filetype,
    color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
    left_padding = 0,
  }

  -- lir current directory root
  utils.ins_left {
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
    condition = conditions.buffer_not_empty and conditions.is_lir,
    color = { fg = colors.fg2, bg = colors.bg, gui = "bold" },
    left_padding = 0,
    right_padding = 0,
  }

  -- lir current directory tail
  utils.ins_left {
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
    condition = conditions.buffer_not_empty and conditions.is_lir,
    color = { fg = colors.yellow, bg = colors.bg, gui = "bold" },
    left_padding = 0,
  }

  -- utils.ins_left {
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

  utils.ins_left {
    gps.get_location,
    -- condition = conditions.gps_available,
    condition = conditions.buffer_not_empty
      and conditions.hide_in_width
      and conditions.is_not_blacklisted_filetype
      and conditions.gps_available,
    -- color = { fg = colors.blue },
    color = { fg = colors.fg2 },
    icon = ">",
    left_padding = 0,
    right_padding = 0,
  }

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  -- utils.ins_left {
  --   function()
  --     return "%="
  --   end,
  -- }

  -- Add components to right sections
  utils.ins_right {
    "diagnostics",
    sources = { "nvim_lsp" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
    color_hint = { fg = colors.blue },
    condition = conditions.hide_in_width,
  }

  utils.ins_right {
    function()
      return " "
    end,
    -- color = { fg = colors.fg2 },
    color = { fg = colors.orange },
    right_padding = 0,
    condition = conditions.active_lsp,
  }

  utils.ins_right {
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
    condition = conditions.hide_in_width and conditions.active_lsp,
  }

  -- utils.ins_right {
  --   -- Lsp server name .
  --   function()
  --     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  --     local clients = vim.lsp.get_active_clients()
  --     if next(clients) == nil then
  --       return ""
  --       -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
  --       -- return (vim.bo.filetype:gsub("^%l", string.upper))
  --     end
  --     local lsps = ""
  --     for _, client in ipairs(clients) do
  --       if client.name ~= "null-ls" then
  --         local filetypes = client.config.filetypes
  --         if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
  --           if lsps == "" then
  --             lsps = client.name
  --           else
  --             if not string.find(lsps, client.name) then
  --               lsps = lsps .. ", " .. client.name
  --             end
  --           end
  --         end
  --       end
  --     end
  --     if lsps == "" then
  --       return ""
  --       -- return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
  --       -- return (vim.bo.filetype:gsub("^%l", string.upper))
  --     else
  --       return lsps
  --     end
  --   end,
  --   -- icon = " ",
  --   --    
  --   color = { fg = colors.fg2, gui = "bold" },
  --   right_padding = 0,
  --   condition = conditions.active_lsp,
  -- }

  utils.ins_right {
    function()
      return ""
    end,
    color = { fg = colors.bg1 },
    condition = conditions.check_git_workspace,
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_right {
    function()
      return ""
    end,
    color = { fg = colors.cyan, bg = colors.bg1 },
    condition = conditions.check_git_workspace,
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_right {
    function()
      -- return ""
      return ""
      -- icon = "", icon = "",
    end,
    color = { fg = colors.bg, bg = colors.cyan },
    condition = conditions.check_git_workspace,
    left_padding = 0,
  }

  utils.ins_right {
    "branch",
    icon = "",
    condition = conditions.check_git_workspace,
    -- color = { fg = colors.cyan, bg = colors.bg2, gui = "bold" },
    color = { fg = colors.cyan, bg = colors.bg1 },
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_right {
    function()
      return ""
    end,
    color = { fg = colors.bg2, bg = colors.bg1 },
    condition = conditions.buffer_not_empty and conditions.hide_in_width,
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_right {
    function()
      return ""
    end,
    color = { fg = colors.magenta, bg = colors.bg2 },
    condition = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_right {
    function()
      return ""
    end,
    color = { fg = colors.bg, bg = colors.magenta },
    condition = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
    left_padding = 0,
  }

  utils.ins_right {
    "location",
    -- icon = " ",
    -- color = { fg = colors.magenta, bg = colors.bg2, gui = "bold" },
    color = { fg = colors.magenta, bg = colors.bg2 },
    condition = conditions.buffer_not_empty and conditions.hide_in_width and conditions.is_not_blacklisted_filetype,
  }

  -- utils.ins_right {
  --   "progress",
  --   color = { fg = colors.magenta, bg = colors.bg2, gui = "bold" },
  --   condition = conditions.buffer_not_empty and conditions.hide_in_width,
  -- }

  -- ========================================================================================================================
  -- Inactive statusline
  -- ========================================================================================================================

  utils.ins_inactive_left {
    -- mode component
    function()
      return " "
    end,
    color = { fg = colors.bg, bg = colors.fg2 },
    left_padding = 1,
    right_padding = 0,
  }

  utils.ins_inactive_left {
    function()
      return " "
    end,
    color = { fg = colors.fg2, bg = colors.bg1 },
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_inactive_left {
    "filetype",
    colored = false,
    disable_text = true,
    color = { fg = colors.fg2, bg = colors.bg1 },
    condition = conditions.buffer_not_empty,
    left_padding = 0,
  }

  utils.ins_inactive_left {
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
    condition = conditions.buffer_not_empty,
    color = { fg = colors.fg2, bg = colors.bg1 },
    left_padding = 0,
  }

  utils.ins_inactive_left {
    function()
      return " "
    end,
    color = { fg = colors.bg1 },
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_inactive_right {
    function()
      return ""
    end,
    condition = conditions.check_git_workspace,
    color = { fg = colors.bg1 },
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_inactive_right {
    function()
      return ""
    end,
    condition = conditions.check_git_workspace,
    color = { fg = colors.fg2 },
    left_padding = 0,
    right_padding = 0,
  }

  utils.ins_inactive_right {
    function()
      -- return ""
      return ""
      -- icon = "", icon = "",
    end,
    condition = conditions.check_git_workspace,
    color = { fg = colors.bg, bg = colors.fg2 },
    left_padding = 0,
  }

  utils.ins_inactive_right {
    "branch",
    icon = "",
    condition = conditions.check_git_workspace,
    color = { fg = colors.fg2, bg = colors.bg1 },
    left_padding = 0,
    right_padding = 0,
  }

  -- utils.ins_left {
  --   "diff",
  --   -- Is it me or the symbol for modified is really weird
  --   symbols = { added = " ", modified = "柳", removed = " " },
  --   color_added = { fg = colors.green },
  --   color_modified = { fg = colors.orange },
  --   color_removed = { fg = colors.red },
  --   condition = conditions.hide_in_width,
  -- }
end

return M
