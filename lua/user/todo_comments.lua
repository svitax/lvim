local M = {}

M.config = function()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  -- REFS:
  todo.setup {
    signs = false,
    -- keywords = {
    --   FIX = { icon = "律" },
    --   TODO = { icon = " " },
    --   HACK = { icon = " " },
    --   WARN = { icon = "裂" },
    --   PERF = { icon = "龍" },
    --   NOTE = { icon = " ", alt = { "INFO", "NB" } },
    --   LINK = { icon = " ", alt = { "LINKS", "REF", "REFS" } },
    --   SUCCESS = { icon = " ", alt = { "OK", "DONE" } },
    --   ERROR = { icon = " ", alt = { "ERR" } },
    --   REFS = { icon = "" },
    -- },
    highlight = { max_line_len = 120 },
    -- colors = {
    --   error = { "DiagnosticError" },
    --   warning = { "DiagnosticWarn" },
    --   warn = { "DiagnosticWarn" },
    --   info = { "DiagnosticInfo" },
    --   note = { "DiagnosticInfo" },
    --   hint = { "DiagnosticHint" },
    --   hack = { "Function" },
    --   ref = { "FloatBorder" },
    --   link = { "FloatBorder" },
    --   refs = { "FloatBorder" },
    --   success = { "healthSuccess" },
    --   default = { "Identifier" },
    -- },
  }
end

return M
