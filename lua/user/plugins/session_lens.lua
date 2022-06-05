local M = {}

M.config = function()
  local status_ok, session_lens = pcall(require, "session-lens")
  if not status_ok then
    return
  end

  -- local session_lens_actions = require "telescope._extensions.session-lens.session-lens-actions"
  session_lens.setup {
    prompt_title = "~ sessions ~",
  }
end

return M
