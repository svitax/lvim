local M = {}

M.config = function()
  local status_ok, fidget = pcall(require, "fidget")
  if not status_ok then
    return
  end

  fidget.setup {
    sources = { -- Sources to configure
      ["null-ls"] = { -- Name of source
        ignore = true, -- Ignore notifications from this source
      },
    },
  }
end

return M
