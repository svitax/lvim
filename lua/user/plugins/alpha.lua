local M = {}

M.config = function()
  lvim.builtin.alpha.active = true
  lvim.builtin.alpha.mode = "dashboard"
  lvim.builtin.alpha.dashboard.section.buttons.entries = {
    { "n", "  New File", "<CMD>ene!<CR>" },
    { "<spc> s f", "  Find File", "<CMD>lua require('user.telescope.custom_pickers').find_files()<CR>" },
    { "<spc> s p", "  Recent Projects ", "<CMD>lua require('user.telescope.custom_pickers').projects()<CR>" },
    { "<spc> s r", "  Recently Used Files", "<CMD>Telescope oldfiles theme=ivy<CR>" },
    -- { "SPC s g", "  Find Word", "<CMD>Telescope live_grep theme=ivy<CR>" },
    {
      "c",
      "  Configuration",
      "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
    },
    -- { "q", "  Quit", "<cmd>lua require('user.usercmd').smart_quit()<CR>" },
    { "q", "  Quit", "<cmd>qa!<CR>" },
  }
end

return M
