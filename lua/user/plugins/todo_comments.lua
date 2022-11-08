local M = {}

M.config = function()
  local status_ok, todo_comments = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  todo_comments.setup {
    highlight = {
      multiline = false,
    },
  }
end

return M
