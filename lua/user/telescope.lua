local M = {}

M.config = function()
  local actions = require "telescope.actions"
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

-- Implement delta as previewer for diffs

-- Requires git-delta, e.g. on macOS
-- brew install git-delta

local previewers = require "telescope.previewers"
local builtin = require "telescope.builtin"
-- local conf = require('telescope.config')

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
