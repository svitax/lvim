local M = {}

M.config = function()
  local status_ok, opener = pcall(require, "opener")
  if not status_ok then
    return
  end

  opener.setup {
    pre_open = {
      function()
        vim.cmd "SaveSession"
      end,
    },
    post_open = {
      -- "! source venv/bin/activate",
      function(dir)
        local Lib = require "auto-session-library"
        Lib.conf.last_loaded_session = nil
        vim.cmd "RestoreSession"
      end,
      "NvimTreeOpen",
    },
  }
  require("telescope").load_extension "opener"
end

return M
