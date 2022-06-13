local M = {}

local themes = require "telescope.themes"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"

local history = require "project_nvim.utils.history"
local project = require "project_nvim.project"
local config = require "project_nvim.config"

local lib = require "opener.lib"

function M.change_working_directory(prompt_bufnr, prompt)
  local selected_entry = state.get_selected_entry(prompt_bufnr)
  if selected_entry == nil then
    actions.close(prompt_bufnr)
    return
  end
  local project_path = selected_entry.value
  if prompt == true then
    actions._close(prompt_bufnr, true)
  else
    actions.close(prompt_bufnr)
  end
  local cd_successful = project.set_pwd(project_path, "telescope")
  return project_path, cd_successful
end

function M.find_project_files(prompt_bufnr)
  local project_path, cd_successful = M.change_working_directory(prompt_bufnr, true)
  local opt = {
    cwd = project_path,
    hidden = config.options.show_hidden,
    mode = "insert",
  }
  if cd_successful then
    builtin.find_files(opt)
  end
end

function M.browse_project_files(prompt_bufnr)
  local project_path, cd_successful = M.change_working_directory(prompt_bufnr, true)
  local opt = {
    cwd = project_path,
    hidden = config.options.show_hidden,
  }
  if cd_successful then
    builtin.file_browser(opt)
  end
end

function M.search_in_project_files(prompt_bufnr)
  local project_path, cd_successful = M.change_working_directory(prompt_bufnr, true)
  local opt = {
    cwd = project_path,
    hidden = config.options.show_hidden,
    mode = "insert",
  }
  if cd_successful then
    builtin.live_grep(opt)
  end
end

function M.recent_project_files(prompt_bufnr)
  local _, cd_successful = M.change_working_directory(prompt_bufnr, true)
  local opt = {
    cwd_only = true,
    hidden = config.options.show_hidden,
  }
  if cd_successful then
    builtin.oldfiles(opt)
  end
end

function M.delete_project(prompt_bufnr)
  local selectedEntry = state.get_selected_entry(prompt_bufnr)
  if selectedEntry == nil then
    actions.close(prompt_bufnr)
    return
  end
  local choice = vim.fn.confirm("Delete '" .. selectedEntry.value .. "' from project list?", "&Yes\n&No", 2)

  if choice == 1 then
    history.delete_project(selectedEntry)

    local finder = M.create_finder()
    state.get_current_picker(prompt_bufnr):refresh(finder, {
      reset_prompt = true,
    })
  end
end

function M.open_project(prompt_bufnr)
  local selection = state.get_selected_entry(prompt_bufnr)
  if selection then -- TODO selection is sometimes NIL, why is that? It seems to be when the async job is running, or when you are searching in telescope
    actions.close(prompt_bufnr)
    -- local dir = selection[1]
    local dir = selection.value
    -- add a tiny delay before opening directory, since telescope has problems
    -- when doing things before it is properly closed. For example:
    -- https://github.com/nvim-telescope/telescope.nvim/issues/699
    vim.defer_fn(function()
      lib.open(dir)
    end, 50)
  end
end

function M.create_finder()
  local results = history.get_recent_projects()

  -- Reverse results
  for i = 1, math.floor(#results / 2) do
    results[i], results[#results - i + 1] = results[#results - i + 1], results[i]
  end
  local displayer = entry_display.create {
    separator = " ",
    items = {
      {
        width = 30,
      },
      {
        remaining = true,
      },
    },
  }

  local function make_display(entry)
    return displayer { entry.name, { entry.value, "Comment" } }
  end

  return finders.new_table {
    results = results,
    entry_maker = function(entry)
      local name = vim.fn.fnamemodify(entry, ":t")
      return {
        display = make_display,
        name = name,
        value = entry,
        ordinal = name .. " " .. entry,
      }
    end,
  }
end

function M.find_projects(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sort_lastused = true,
    sort_mru = false,
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)

  pickers.new(opts, {
    prompt_title = "~ projects ~",
    finder = M.create_finder(),
    -- finder = finders.new_table {
    --   results = recent_projects,
    -- },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      map("n", "f", M.find_project_files)
      map("n", "b", M.browse_project_files)
      map("n", "d", M.delete_project)
      map("n", "s", M.search_in_project_files)
      map("n", "r", M.recent_project_files)
      map("n", "w", M.change_working_directory)

      map("i", "<A-f>", M.find_project_files)
      map("i", "<A-b>", M.browse_project_files)
      map("i", "<A-d>", M.delete_project)
      map("i", "<A-s>", M.search_in_project_files)
      map("i", "<A-r>", M.recent_project_files)
      map("i", "<A-w>", M.change_working_directory)
      actions.select_default:replace(M.open_project)
      return true
    end,
  }):find()
end

return M
