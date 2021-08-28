local gps = require "nvim-gps"

local M = {}

-- TODO: condition where component won't show if statusline too short
M.buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand "%:t") ~= 1
end

M.hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

M.check_git_workspace = function()
  local filepath = vim.fn.expand "%:p:h"
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

M.active_lsp = function()
  local clients = vim.lsp.buf_get_clients()
  if clients[1] then
    return true
  else
    return false
  end
end

M.gps_available = gps.is_available

return M
