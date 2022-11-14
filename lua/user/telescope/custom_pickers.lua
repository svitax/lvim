local M = {}

local themes = require "telescope.themes"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local previewers = require "telescope.previewers"

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local conf = require("telescope.config").values
local state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"

local history = require "project_nvim.utils.history"

-- local lib = require "opener.lib"

-- function M.projects(opts)
--   local open_project = function(prompt_bufnr)
--     local selection = state.get_selected_entry(prompt_bufnr)
--     if selection then -- TODO selection is sometimes NIL, why is that? It seems to be when the async job is running, or when you are searching in telescope
--       actions.close(prompt_bufnr)
--       -- local dir = selection[1]
--       local dir = selection.value
--       -- add a tiny delay before opening directory, since telescope has problems
--       -- when doing things before it is properly closed. For example:
--       -- https://github.com/nvim-telescope/telescope.nvim/issues/699
--       vim.defer_fn(function()
--         lib.open(dir)
--       end, 50)
--     end
--   end

--   local create_finder = function()
--     local results = history.get_recent_projects()

--     -- Reverse results
--     for i = 1, math.floor(#results / 2) do
--       results[i], results[#results - i + 1] = results[#results - i + 1], results[i]
--     end
--     local displayer = entry_display.create {
--       separator = " ",
--       items = {
--         {
--           width = 30,
--         },
--         {
--           remaining = true,
--         },
--       },
--     }

--     local function make_display(entry)
--       return displayer { entry.name, { entry.value, "Comment" } }
--     end

--     return finders.new_table {
--       results = results,
--       entry_maker = function(entry)
--         local name = vim.fn.fnamemodify(entry, ":t")
--         return {
--           display = make_display,
--           name = name,
--           value = entry,
--           ordinal = name .. " " .. entry,
--         }
--       end,
--     }
--   end

--   opts = opts or {}
--   local theme_opts = themes.get_ivy {
--     sort_lastused = true,
--     sort_mru = false,
--   }
--   opts = vim.tbl_deep_extend("force", theme_opts, opts)

--   pickers
--     .new(opts, {
--       prompt_title = "~ projects ~",
--       finder = create_finder(),
--       -- finder = finders.new_table {
--       --   results = recent_projects,
--       -- },
--       sorter = conf.generic_sorter(opts),
--       attach_mappings = function(prompt_bufnr, map)
--         map("n", "f", find_project_files)
--         map("n", "b", browse_project_files)
--         map("n", "d", delete_project)
--         map("n", "s", search_in_project_files)
--         map("n", "r", recent_project_files)
--         map("n", "w", change_working_directory)

--         map("i", "<c-f>", find_project_files)
--         map("i", "<c-b>", browse_project_files)
--         map("i", "<c-d>", delete_project)
--         map("i", "<c-s>", search_in_project_files)
--         map("i", "<c-r>", recent_project_files)
--         map("i", "<c-w>", change_working_directory)
--         actions.select_default:replace(open_project)
--         return true
--       end,
--     })
--     :find()
-- end

function M.marks(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    border = true,
    initial_mode = "normal",
    sort_lastused = false,
    sort_mru = true,
    -- ignore_current_buffer = true
    -- path_display = { shorten = 5 },
    path_display = function(_, path)
      -- would be cool if instead of the path we could show the project
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,
    attach_mappings = function(_, map)
      map("n", "q", actions.close)
      map("n", ";", actions.select_default)
      map("n", "s", function(prompt_bufnr)
        local hop_opts = {
          callback = actions.select_default,
          loop_callback = actions.send_selected_to_qflist,
        }
        require("telescope").extensions.hop._hop(prompt_bufnr, hop_opts)
      end)
      return true
    end,
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.marks(opts)
end

function M.switch_buffers(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    border = true,
    initial_mode = "normal",
    sort_lastused = false,
    sort_mru = true,
    -- ignore_current_buffer = true
    -- path_display = { shorten = 5 },
    path_display = function(_, path)
      -- would be cool if instead of the path we could show the project
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.delete_buffer)
      map("n", "<c-d>", actions.delete_buffer)
      map("n", "d", actions.delete_buffer)
      map("n", "q", actions.close)
      map("n", ";", actions.select_default)
      map("n", "s", function(prompt_bufnr)
        local hop_opts = {
          callback = actions.select_default,
          loop_callback = actions.send_selected_to_qflist,
        }
        require("telescope").extensions.hop._hop(prompt_bufnr, hop_opts)
      end)
      return true
    end,
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.buffers(opts)
end

-- Buffer switcher
function M.switch_buffers_dropdown(opts)
  opts = opts or {}
  local theme_opts = themes.get_dropdown {
    border = true,
    previewer = false,
    initial_mode = "normal",
    sort_lastused = true,
    sort_mru = true,
    -- ignore_current_buffer = true
    -- path_display = { shorten = 5 },
    path_display = function(_, path)
      -- would be cool if instead of the path we could show the project
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.delete_buffer)
      map("n", "<c-d>", actions.delete_buffer)
      map("n", "d", actions.delete_buffer)
      map("n", ";", actions.select_default)
      return true
    end,
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.buffers(opts)
end

function M.grep_current_buffer(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    winblend = lvim.winblend,
    border = true,
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.current_buffer_fuzzy_find(opts)
end

function M.dropdown_grep_current_buffer(opts)
  opts = opts or {}
  local theme_opts = themes.get_dropdown {
    winblend = lvim.winblend,
    border = true,
    previewer = false,
    -- border = false,
    layout_strategy = "vertical",
    layout_config = {
      vertical = { width = 0.9, height = 0.9, preview_height = 0.3 },
      -- prompt_position = "top",
      prompt_position = "bottom",
    },
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.current_buffer_fuzzy_find(opts)
end

function M.find_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    find_command = { "rg", "--hidden", "--files", "--follow", "--glob=!.git" },
    prompt_title = "~ files in project ~",
    layout_config = {
      bottom_pane = {
        prompt_position = "top",
        -- prompt_position = "bottom",
        -- height = 0.6,
      },
    },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)

  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

function M.fuzzy_grep_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    -- sort_only_text = true,
    only_sort_text = true,
    disable_coordinates = true,
    path_display = { "hidden" },
    search = "",

    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "git/*",
    },
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.grep_string(opts)
end

function M.grep_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    -- find_command = { "rg", "--hidden", "--files", "--follow", "--glob=!.git" },
    -- word_match = "-w",
    -- sort_only_text = true,
    only_sort_text = true,
    disable_coordinates = true,
    path_display = { "hidden" },
    -- search = "",

    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "git/*",
    },
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.live_grep(opts)
end

function M.find_dotfiles(opts)
  opts = opts or {}

  local dirs = {
    "~/.dotfiles",
    "~/.config",
  }
  local find_command = { "rg", "--hidden", "--files", "--follow", "--glob", "!.git/*", "" }
  for _, path in ipairs(dirs) do
    table.insert(find_command, vim.fn.expand(path))
  end
  local dotfiles_opts = { prompt_title = "~ dotfiles ~", find_command = find_command }
  opts = vim.tbl_deep_extend("force", opts, dotfiles_opts)

  -- M.find_files(opts)
  builtin.find_files(opts)
end

function M.find_lunarvim_config_files(opts)
  opts = opts or {}

  local config_files_opts = { cwd = "~/.config/lvim", prompt_title = "~ LunarVim config files ~" }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  M.find_files(opts)
end

function M.find_notes(opts)
  opts = opts or {}

  local config_files_opts = {
    cwd = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax",
    prompt_title = "~ search obsidian notes ~",
  }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  M.find_files(opts)
end

function M.grep_notes(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    -- find_command = { "rg", "--hidden", "--files", "--follow", "--glob=!.git" },
    -- word_match = "-w",
    -- sort_only_text = true,
    only_sort_text = true,
    disable_coordinates = true,
    path_display = { "hidden" },
    -- search = "",
    cwd = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax",
    prompt_title = "~ grep obsidian notes ~",

    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "git/*",
    },
  }

  opts = vim.tbl_deep_extend("force", opts, theme_opts)
  builtin.live_grep(opts)
end

function M.grep_config_files(opts)
  opts = opts or {}

  local config_files_opts = { cwd = "~/.config/lvim", prompt_title = "~ grep LunarVim config files ~" }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  builtin.live_grep(opts)
end

function M.grep_dotfiles(opts)
  opts = opts or {}

  local config_files_opts = { cwd = "~/.config", prompt_title = "~ grep dotfiles ~" }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  builtin.live_grep(opts)
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  builtin.grep_string(opts)
end

function M.find_lunarvim_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_title = "~ LunarVim files ~",
    cwd = get_runtime_dir(),
    search_dirs = { require("lvim.utils").join_paths(get_runtime_dir(), "lvim"), lvim.lsp.templates_dir },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  M.find_files(opts)
end

-- TODO: can't scroll down and up delta preview
local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
  end,
}

M.delta_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_commits(opts)
end

M.delta_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_bcommits(opts)
end

-- M.conda = function(opts)
--   local pickers = require "telescope.pickers"
--   local finders = require "telescope.finders"
--   local action_state = require "telescope.actions.state"
--   local conf = require("telescope.config").values

--   local scan = require "plenary.scandir"
--   local home = os.getenv "HOME"
--   opts = opts or {}

--   -- local conda_path = home .. "/anaconda3"
--   -- local conda_env_path = home .. "/anaconda3/envs"
--   local conda_path = home .. "/.miniconda"
--   local conda_env_path = home .. "/.miniconda/envs"

--   local conda_finder = function()
--     local conda_envs = {}
--     scan.scan_dir(conda_env_path, {
--       hidden = opts.hidden or false,
--       add_dirs = true,
--       depth = 1,
--       on_insert = function(entry, typ)
--         table.insert(conda_envs, entry)
--       end,
--     })

--     local conda_maker = function(entry)
--       local path_remove = function(String, Path)
--         if String == conda_path then
--           return "base"
--         else
--           return string.gsub(String, Path .. "/", "")
--         end
--       end

--       local disp = path_remove(entry, conda_env_path)

--       return { value = entry, display = disp, ordinal = disp }
--     end

--     table.insert(conda_envs, conda_path)
--     return finders.new_table { results = conda_envs, entry_maker = conda_maker }
--   end

--   pickers.new(opts, {
--     prompt_title = "Select an Environment",
--     results_title = "Conda Environments",
--     finder = conda_finder(),
--     sorter = conf.generic_sorter(opts),

--     attach_mappings = function(prompt_bufnr, map)
--       actions.select_default:replace(function()
--         local env_to_bin = function(env)
--           if env == "base" then
--             return conda_path .. "/bin"
--           else
--             return conda_env_path .. "/" .. env .. "/bin"
--           end
--         end
--         actions.close(prompt_bufnr)
--         local selection = action_state.get_selected_entry()
--         local current_env = vim.env.CONDA_DEFAULT_ENV
--         local next_env = selection["display"]
--         vim.env.CONDA_DEFAULT_ENV = next_env
--         print("before vim env path", vim.env.PATH)
--         current_anaconda = env_to_bin(current_env)
--         next_anaconda = env_to_bin(next_env)
--         vim.env.PATH = string.gsub(vim.env.PATH, current_anaconda, next_anaconda)
--         print("after vim env path", vim.env.PATH)
--       end)
--       return true
--     end,
--   }):find()
-- end

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

return M
