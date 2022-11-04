local M = {}

M.config = function()
  local status_ok, noice = pcall(require, "noice")
  if not status_ok then
    return
  end

  noice.setup {
    presets = {
      bottom_search = true,
      inc_rename = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    messages = {
      enabled = false,
    },
    -- show @ recording messages in notify
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
    cmdline = {
      format = {
        cmdline = {
          view = "cmdline",
        },
        filter = {
          view = "cmdline",
        },
        lua = {
          view = "cmdline",
        },
        help = {
          view = "cmdline",
        },
        input = {
          view = "cmdline",
        },
      },
    },
  }
end

return M
