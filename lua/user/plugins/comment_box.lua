local M = {}

M.config = function()
  local status_ok, commentbox = pcall(require, "comment-box")
  if not status_ok then
    return
  end

  commentbox.setup {}
  require("user.keymaps").set_comment_box_keymaps()
end

return M
