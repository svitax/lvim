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
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    messages = {
      enabled = true,
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
      view_history = "messages",
      view_search = "cmdline",
    },
    -- show @ recording messages in notify
    routes = {
      {
        view = "mini",
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

  -- TODO: figure out how to make these work with smooth scrolling
  -- vim.keymap.set("n", "<c-d>", function()
  --   if not require("noice.lsp").scroll(4) then
  --     return "<c-d>"
  --   end
  -- end, { silent = true, expr = true })
  -- vim.keymap.set("n", "<c-u>", function()
  --   if not require("noice.lsp").scroll(-4) then
  --     return "<c-u>"
  --   end
  -- end, { silent = true, expr = true })

  require("telescope").load_extension "noice"
end

return M
