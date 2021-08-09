-- Buffers picker
return function()
  local themes = require "telescope.themes"
  local actions = require "telescope.actions"
  local builtin = require "telescope.builtin"

  -- previewer = false
  -- local theme_opts = themes.get_ivy { border = true }
  local theme_opts = themes.get_dropdown { border = true, previewer = false }
  local opts = {
    initial_mode = "insert",
    -- workaround to telescope bug #1018 until a fix gets merged so I can use initial_mode = "normal"
    on_complete = {
      function()
        vim.cmd "stopinsert"
      end,
    },
    -- path_display = { shorten = 5 },
    path_display = function(opts, path)
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
  local buffers_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  builtin.buffers(buffers_conf)
end
