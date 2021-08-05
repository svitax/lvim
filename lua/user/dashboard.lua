local M = {}

M.config = function()
  -- TODO lunarvim's footer isn't exposed for user config, but here's how I want the footer to look
  -- this needs to be in init.lua
  -- vim.g.start_time = vim.fn.reltime()
  -- local packages = #(vim.fn.globpath("~/.local/share/lunarvim/site/pack/packer/start", "*", 0, 1))
  -- local loadtime = vim.fn.printf("%.3f", vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)))
  -- vim.g.dashboard_custom_footer = {
  --   "LunarVim loaded in " .. loadtime .. " seconds with " .. packages .. " plugins   ",
  --   -- 
  --   -- "LunarVim loaded " .. packages .. " plugins   in " .. loadtime .. "  seconds ",
  -- }
end
return M
