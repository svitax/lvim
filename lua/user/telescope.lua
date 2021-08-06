local M = {}

local builtin = require "telescope.builtin"
local actions = require "telescope.actions"
local themes = require "telescope.themes"
local previewers = require "telescope.previewers"
-- local conf = require('telescope.config')

-- Defaults
-- =========================================
M.config = function()
  -- lvim.builtin.telescope.defaults.winblend = 10
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.n["q"] = actions.close
  lvim.builtin.telescope.defaults.mappings.n["<esc>"] = actions.close
  -- lvim.builtin.telescope.defaults.mappings.n["<esc>"] = function() end
  lvim.builtin.telescope.defaults.path_display.shorten = 4
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
end

-- Buffers picker
-- =========================================
M.buffers = function()
  local theme_opts = themes.get_dropdown { border = true, previewer = false }
  local opts = {
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.delete_buffer)
      map("n", "<c-d>", actions.delete_buffer)
      map("n", "d", actions.delete_buffer)
      return true
    end,
  }
  local buffers_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  builtin.buffers(buffers_conf)
end

-- Projects picker
-- =========================================
M.projects = function()
  local project_actions = require "telescope._extensions.project.actions"
  local project_utils = require "telescope._extensions.project.utils"
  -- Browse through files within the selected project using
  -- a lir float window
  local browse_project_files = function(prompt_bufnr)
    local project_path = project_actions.get_selected_path(prompt_bufnr)
    actions._close(prompt_bufnr, true)
    local cd_successful = project_utils.change_project_dir(project_path)
    if cd_successful then
      -- builtin.file_browser { cwd = project_path }
      -- vim.cmd(":edit " .. project_path)
      require("lir.float").toggle(project_path)
      vim.cmd "stopinsert"
    end
  end

  local load_project = function(prompt_bufnr)
    local project_path = project_actions.get_selected_path(prompt_bufnr)
    actions._close(prompt_bufnr, true)
    local cd_successful = project_utils.change_project_dir(project_path)
    if cd_successful then
      vim.cmd "RestoreSession"
      vim.cmd "stopinsert"
    end
  end

  local theme_opts = themes.get_dropdown { border = true, previewer = false }
  local opts = {
    display_type = "full",
    attach_mappings = function(_, map)
      map("n", "f", browse_project_files)
      map("i", "<cr>", load_project)
      map("n", "<cr>", load_project)
      return true
    end,
  }

  local projects_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  require("telescope").extensions.project.project(projects_conf)
end

-- Delta
-- =========================================

-- Implement delta as previewer for diffs

-- Requires git-delta, e.g. on macOS
-- brew install git-delta

-- TODO can't seem to scroll up or down with just <c-u>/<c-d> in the delta previewer
-- TODO need to <c-u>/<c-d> and scroll with mouse to see everything
local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == "??" or "A " then
      -- return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value }
      return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value }
    end
    -- note we can't use pipes
    -- this command is for git_commits and git_bcommits
    -- return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
    return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value .. "^!" }
  end,
}

-- TODO delta_git_commits is kinda buggy
M.delta_git_commits = function(opts)
  opts = opts or {}
  -- make the layout big so I can read everything with my large font and side-by-side preview
  opts.layout_config = {
    preview_width = 0.8,
    width = 0.96,
    height = 0.99,
  }
  opts.previewer = delta
  builtin.git_commits(opts)
end

-- TODO delta_git_bcommits is also kinda buggy
M.delta_git_bcommits = function(opts)
  opts = opts or {}
  -- make the layout big so I can read everything with my large font and side-by-side preview
  opts.layout_config = {
    preview_width = 0.8,
    width = 0.96,
    height = 0.99,
  }
  opts.previewer = delta
  builtin.git_bcommits(opts)
end

M.delta_git_status = function(opts)
  opts = opts or {}
  -- make the layout big so I can read everything with my large font and side-by-side preview
  opts.layout_config = {
    preview_width = 0.8,
    width = 0.96,
    height = 0.99,
  }
  opts.previewer = delta
  builtin.git_status(opts)
end

return M

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
--       -- TODO: add delete session
--       -- map("i", "<c-d>", SessionLensActions.delete_session)
--       return true
--     end,
--   }
-- end
