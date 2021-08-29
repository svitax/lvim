local M = {}

local config = require "user.lualine.init"

-- Inserts a component in lualine_c at left section
M.ins_left = function(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
M.ins_right = function(component)
  table.insert(config.sections.lualine_x, component)
end

-- Inserts a component in lualine_c at left INACTIVE section
M.ins_inactive_left = function(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right INACTIVE section
M.ins_inactive_right = function(component)
  table.insert(config.inactive_sections.lualine_x, component)
end

M.get_short_cwd = function()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

M.harpoon = function()
  local status = require("harpoon.mark").status()
  if status == "" then
    return ""
  end
  -- return just the terminal number, cause the status method returns M1, M2, etc.
  local number = (string.format("%s", status)):sub(-1)
  return number
end

return M
