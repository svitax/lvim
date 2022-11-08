lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if status_ok then
  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Macro"
    return b
  end
  lvim.builtin.alpha.dashboard.section.buttons.val = {
    button("n", lvim.icons.ui.NewFile .. "  New File", "<cmd>ene!<cr>"),
    button("f", lvim.icons.ui.FindFile .. "  Find File ", "<cmd>lua require('user.telescope.custom_pickers').find_files()<cr>"),
    button("p", lvim.icons.ui.Project .. "  Recent Projects ", "<cmd>lua require('user.telescope.projects').find_projects()<cr>"),
    button(
      "r",
      lvim.icons.ui.History .. "  Recent Files",
      "<cmd>lua require('telescope').extensions.recent_files.pick(require('telescope.themes').get_ivy{})<cr>"
    ),
    button("c", lvim.icons.ui.Gear .. "  Configuration", "<cmd>edit " .. require("lvim.config"):get_user_config_path() .. " <cr>"),
    button("q", lvim.icons.ui.BoldClose .. "  Quit", "<cmd>lua require('user.usercmd').smart_quit()<cr>"),
    -- { "n", "  New File", "<CMD>ene!<CR>" },
    -- { "<spc> s f", "  Find File", "<CMD>lua require('user.telescope.custom_pickers').find_files()<CR>" },
    -- { "<spc> s p", "  Recent Projects ", "<CMD>lua require('user.telescope.custom_pickers').projects()<CR>" },
    -- { "<spc> s r", "  Recently Used Files", "<CMD>Telescope oldfiles theme=ivy<CR>" },
    -- -- { "SPC s g", "  Find Word", "<CMD>Telescope live_grep theme=ivy<CR>" },

    -- button("t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>"),
    -- {
    --   "c",
    --   "  Configuration",
    --   "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
    -- },
    -- -- { "q", "  Quit", "<cmd>lua require('user.usercmd').smart_quit()<CR>" },
    -- { "q", "  Quit", "<cmd>qa!<CR>" },
  }
end
