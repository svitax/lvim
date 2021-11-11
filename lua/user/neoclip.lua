local M = {}

M.config = function()
  local status_ok, neoclip = pcall(require, "neoclip")
  if not status_ok then
    return
  end

  neoclip.setup {
    content_spec_column = true,
    enable_persistant_history = true,
    db_path = vim.fn.stdpath "data" .. "/neoclip.sqlite3",
    keys = {
      i = { select = "<a-p>", paste = "<CR>", paste_behind = "<c-P>" },
      n = { select = "p", paste = "<CR>", paste_behind = "P" },
    },
    -- NOTE: I basically don't want single empty lines to appear neoclips history
    filter = function(table)
      if table.event.visual == false and table.event.regcontents[1] == "" then
        return false
      end
      return true
    end,
  }
end

return M
