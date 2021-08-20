-- TODO: better project+session handling
-- I can load a projects session, but I can't reliably save a project's session
-- If I do :SaveSession while in a window that has a file that's not part of the project,
-- it will save the session under that other file's project
-- Projects picker
return function()
  local actions = require "telescope.actions"
  local themes = require "telescope.themes"

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

    local cd_successful = project_utils.change_project_dir(project_path)
    if cd_successful then
      local AutoSession = require "auto-session"

      local session_file = project_path:gsub("/", "%%") .. ".vim"
      local session_file_path = vim.fn.stdpath "data" .. "/sessions/" .. session_file
      -- vim.fn.stdpath("data" .. "/sessions/") -- auto_session_root_dir
      actions._close(prompt_bufnr, true)
      AutoSession.AutoSaveSession() -- save the current session
      vim.cmd "%bd!" -- deletes all buffers
      AutoSession.RestoreSession(session_file_path)
      vim.cmd "stopinsert"
    end
  end

  local theme_opts = themes.get_dropdown { border = true, previewer = false }
  local opts = {
    display_type = "full",
    initial_mode = "normal",
    attach_mappings = function(_, map)
      map("n", "f", browse_project_files)
      actions.select_default:replace(load_project)
      -- map("i", "<cr>", load_project)
      -- map("n", "<cr>", load_project)
      return true
    end,
  }

  local projects_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  require("telescope").extensions.project.project(projects_conf)
end
