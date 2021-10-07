local M = {}

local gps = require "nvim-gps"

M.conditions = {
  -- TODO: (lualine) condition where component won't show if statusline too short
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

  active_lsp = function()
    local clients = vim.lsp.buf_get_clients()
    if clients[1] then
      return true
    else
      return false
    end
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

return M
