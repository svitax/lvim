local M = {}

M.config = function()
  lvim.builtin.which_key.on_config_done = function()
    lvim.builtin.which_key.mappings[";"] = { "<cmd>Dashboard<cr>", "dashboard" }
  end
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

  lvim.builtin.dashboard.custom_section = {
    a = {
      description = { "  Recently used files" },
      command = "Telescope oldfiles",
    },
    b = {
      description = { "  Load project        " },
      command = "lua require'user.telescope.pickers.projects'()",
    },
    c = {
      description = { "  Find file          " },
      command = "Telescope find_files",
    },
    -- d = {
    --   description = { "  Load last session  " },
    --   command = "SessionLoad",
    -- },
    e = {
      description = { "  Grep                " },
      command = "Telescope live_grep",
    },
    f = {
      description = { "  Settings           " },
      command = ":e " .. USER_CONFIG_PATH,
    },
  }
end

return M
