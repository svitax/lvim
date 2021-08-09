-- go to home dir
return function()
  vim.cmd("edit " .. vim.fn.expand "$HOME")
end
