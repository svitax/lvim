return {
  "kristijanhusak/orgmode.nvim",
  -- keys = { "go", "gC" },
  -- ft = { "org" },
  config = function()
    -- require("user.orgmode").orgmode_setup()
    local status_ok, org_mode = pcall(require, "orgmode")
    if not status_ok then
      return
    end

    org_mode.setup {
      -- org_agenda_files = { "~/shared/orgs/**/*" },
      -- org_default_notes_file = "~/shared/orgs/refile.org",
      org_agenda_files = { "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax/orgs" },
      org_default_notes_file = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax/orgs/inbox.org",
      org_agenda_templates = {
        T = {
          description = "Todo",
          template = "* TODO %?\n  DEADLINE: %T",
          -- target = "~/shared/orgs/todos.org",
          target = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax/orgs/todos.org",
        },
        w = {
          description = "Work todo",
          template = "* TODO %?\n  DEADLINE: %T",
          -- target = "~/shared/orgs/work.org",
          target = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax/orgs/work.org",
        },
      },
      mappings = {
        global = {
          org_agenda = "go",
          org_capture = "gC",
        },
        org = {
          org_meta_return = "<Leader>oih",
          org_insert_heading_respect_content = "<Leader>o<cr>",
          org_timestamp_up = "+",
          org_timestamp_down = "-",
        },
      },
    }
  end,
}



-- return M
