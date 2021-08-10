-- open term
return function()
  local cwd = vim.fn.expand "%:p"
  vim.cmd("ToggleTerm dir=" .. cwd)
end
