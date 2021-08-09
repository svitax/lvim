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
      actions.select_default:replace(load_project)
      -- map("i", "<cr>", load_project)
      -- map("n", "<cr>", load_project)
      return true
    end,
  }

  local projects_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  require("telescope").extensions.project.project(projects_conf)
end
