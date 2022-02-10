return {
  "AckslD/nvim-neoclip.lua",
  event = "WinEnter",
  requires = { "tami5/sqlite.lua", module = "sqlite" },
  config = function()
    local status_ok, neoclip = pcall(require, "neoclip")
    if not status_ok then
      return
    end

    neoclip.setup {
      -- TODO: when stable neovim gets RecordingLeave turn enable_macro_history back on
      enable_macro_history = false,

      default_register = "+",
      content_spec_column = true,
      enable_persistent_history = true,
      db_path = vim.fn.stdpath "data" .. "/neoclip.sqlite3",
      keys = {
        -- i = { select = "<a-p>", paste = "<CR>", paste_behind = "<c-P>" },
        -- n = { select = "p", paste = "<CR>", paste_behind = "P" },
        telescope = {
          i = { select = "<cr>", paste = "<a-p>", paste_behind = "<a-P>" },
          n = { select = "<cr>", paste = "p", paste_behind = "P" },
        },
      },
      -- NOTE: I basically don't want single empty lines to appear neoclips history
      filter = function(table)
        if table.event.visual == false and table.event.regcontents[1] == "" then
          return false
        end
        return true
      end,
    }

    require("telescope").load_extension "neoclip"
  end,
}
