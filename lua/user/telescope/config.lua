-- local builtin = require "telescope.builtin"
-- local themes = require "telescope.themes"
-- local previewers = require "telescope.previewers"
-- local conf = require('telescope.config')

-- Defaults
-- =========================================
return function()
  local actions = require "telescope.actions"

  lvim.builtin.telescope.defaults.winblend = lvim.winblend
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.n["q"] = actions.close
  lvim.builtin.telescope.defaults.mappings.n["<esc>"] = actions.close
  lvim.builtin.telescope.defaults.mappings.n[";"] = actions.select_default
  -- lvim.builtin.telescope.defaults.mappings.n["<esc>"] = function() end
  -- lvim.builtin.telescope.defaults.path_display.shorten = 10
  lvim.builtin.telescope.defaults.path_display = function(opts, path)
    -- would be cool if instead of the path we could show the project
    local tail = require("telescope.utils").path_tail(path)
    return string.format("%s (%s)", tail, path)
  end
  lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
  lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
  lvim.builtin.telescope.defaults.layout_config.horizontal = {
    width_padding = 0.04,
    height_padding = 0.1,
    preview_width = 0.6,
  }
  lvim.builtin.telescope.defaults.layout_config.vertical = {
    width_padding = 0.05,
    height_padding = 1,
    preview_height = 0.5,
  }

  lvim.builtin.telescope.extensions.fzy = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = false, -- override the generic sorter
    override_file_sorter = true, -- override the file sorter
    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  }
  lvim.builtin.telescope.on_config_done = function()
    require("telescope").load_extension "fzf"
  end
end

-- -- If I ever wanna make my own sessions telescope picker
-- M.sessions = function()
--   local actions = require "telescope.actions"
--   local action_state = require "telescope.actions.state"
--   local persistence = require "persistence"
--
--   local source_session = function(prompt_bufnr)
--     local selection = action_state.get_selected_entry()
--   end
--
--   require("telescope.builtin").find_files {
--     prompt_title = "Sessions",
--     -- entry_maker = Lib.make_entry.gen_from_file({cwd = cwd, path_display = path_display}),
--     cwd = "~/.config/nvim/sessions",
--     -- TOOD: support custom mappings?
--     attach_mappings = function(_, map)
--       actions.select_default:replace(source_session)
--       -- TODO add delete session
--       -- map("i", "<c-d>", SessionLensActions.delete_session)
--       return true
--     end,
--   }
-- end
