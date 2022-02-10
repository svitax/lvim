-- local builtin = require "telescope.builtin"
-- local themes = require "telescope.themes"
-- local previewers = require "telescope.previewers"
-- local conf = require('telescope.config')

-- Defaults
-- =========================================
return function()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.prompt_prefix = " "
  lvim.builtin.telescope.defaults.selection_caret = " "

  lvim.builtin.telescope.defaults.dynamic_preview_title = true

  lvim.builtin.telescope.defaults.winblend = lvim.winblend

  -- hot reloaded function
  -- if pcall(require, "plenary") then
  --   RELOAD = require("plenary.reload").reload_module

  --   R = function(name)
  --     RELOAD(name)
  --     return require(name)
  --   end

  lvim.builtin.telescope.defaults.mappings = {
    i = {
      -- ["<esc>"] = actions.close,
      -- ["<C-s>"] = R("telescope").extensions.hop.hop,
      ["<C-y>"] = actions.which_key,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      -- ["<C-s>"] = R("telescope").extensions.hop.hop,
      -- ["<C-s>"] = function(prompt_bufnr)
      --   require("telescope").extensions.hop.hop(prompt_bufnr)
      -- end,
      -- ["<C-Space>"] = function(prompt_bufnr)
      -- local opts = {
      -- callback = actions.toggle_selection,
      -- loop_callback = actions.send_selected_to_qflist ,
      -- }
      -- require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
      -- end,
    },
    n = {
      -- ["s"] = R("telescope").extensions.hop.hop,
      -- ["s"] = function(prompt_bufnr)
      --   require("telescope").extensions.hop.hop(prompt_bufnr)
      -- end,
      ["q"] = actions.close,
      [";"] = actions.select_default,
      ["?"] = actions.which_key,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<esc>"] = actions.close,
      ["<Space>"] = actions.toggle_selection,
      -- ["<C-Space>"] = function(prompt_bufnr)
      -- local opts = {
      -- callback = actions.toggle_selection,
      -- loop_callback = actions.send_selected_to_qflist,
      -- }
      -- require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
      -- end,
    },
  }
  -- end

  lvim.builtin.telescope.defaults.layout_strategy = "bottom_pane"
  lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
  lvim.builtin.telescope.defaults.layout_config.horizontal = {
    width = 0.9,
    height = 0.9,
    width_padding = 0.04,
    height_padding = 0.1,
    preview_width = 0.6,
  }
  lvim.builtin.telescope.defaults.layout_config.vertical = {
    width = 0.9,
    height = 0.9,
    width_padding = 0.05,
    height_padding = 1,
    preview_height = 0.5,
  }
  lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
  lvim.builtin.telescope.defaults.sort_lastused = true
  lvim.builtin.telescope.defaults.sort_mru = true
  -- lvim.builtin.telescope.defaults.path_display.shorten = 10
  lvim.builtin.telescope.defaults.path_display = function(_, path)
    -- would be cool if instead of the path we could show the project
    local tail = require("telescope.utils").path_tail(path)
    return string.format("%s (%s)", tail, path)
  end

  -- lvim.builtin.telescope.extensions.hop = {
  -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
  -- keys = {
  -- "a",
  -- "s",
  -- "d",
  -- "f",
  -- "g",
  -- "h",
  -- "j",
  -- "k",
  -- "l",
  -- ";",
  -- "q",
  -- "w",
  -- "e",
  -- "r",
  -- "t",
  -- "y",
  -- "u",
  -- "i",
  -- "o",
  -- "p",
  -- "A",
  -- "S",
  -- "D",
  -- "F",
  -- "G",
  -- "H",
  -- "J",
  -- "K",
  -- "L",
  -- ":",
  -- "Q",
  -- "W",
  -- "E",
  -- "R",
  -- "T",
  -- "Y",
  -- "U",
  -- "I",
  -- "O",
  -- "P",
  -- },
  -- Highlight groups to link to signs and lines; the below configuration refers to demo
  -- sign_hl typically only defines foreground to possibly be combined with line_hl
  -- sign_hl = { "Title", "WarningMsg" },
  -- optional, typically a table of two highlight groups that are alternated between
  -- line_hl = { "Normal", "CursorLine" },
  -- options specific to `hop_loop`
  -- true temporarily disables Telescope selection highlighting
  -- clear_selection_hl = false,
  -- highlight hopped to entry with telescope selection highlight
  -- note: mutually exclusive with `clear_selection_hl`
  -- trace_entry = true,
  -- jump to entry where hoop loop was started from
  -- reset_selection = true,
  -- }

  lvim.builtin.telescope.on_config_done = function()
    -- require("telescope").load_extension "projects"
    -- require("telescope").load_extension "fzf"
    -- require("telescope").load_extension "neoclip"
    -- require("telescope").load_extension "npm"
  end

  -- lvim.builtin.telescope.extensions.fzf = {
  --   fuzzy = true, -- false will only do exact matching
  --   override_generic_sorter = false, -- override the generic sorter
  --   override_file_sorter = true, -- override the file sorter
  --   case_mode = "smart_case", -- or "ignore_case" or "respect_case"
  --   -- the default case_mode is "smart_case"
  -- }
end
