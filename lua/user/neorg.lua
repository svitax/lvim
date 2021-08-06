local M = {}

-- folding doesn't work on headers yet :(

M.config = function()
  require("neorg").setup {
    -- Tell Neorg what modules to load
    load = {
      ["core.defaults"] = {}, -- Load all the default modules
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
      ["core.norg.tangle"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = true, -- Generate the default keybinds
          neorg_leader = "<Leader>n", -- This is the default if unspecified
        },
      },
      ["core.norg.concealer"] = { -- Allows for use of icons
        config = {
          icons = {
            todo = {
              enabled = true, -- Conceal TODO items
              done = {
                enabled = true, -- Conceal whenever an item is marked as done
                icon = "",
              },
              pending = {
                enabled = true, -- Conceal whenever an item is marked as pending
                icon = "",
              },
              undone = {
                enabled = true, -- Conceal whenever an item is marked as undone
                icon = "×",
              },
            },
            quote = {
              enabled = true, -- Conceal quotes
              icon = "∣",
            },
            heading = {
              enabled = true, -- Enable beautified headings
              -- Define icons for all the different heading levels
              level_1 = {
                enabled = true,
                icon = "◉",
              },
              level_2 = {
                enabled = true,
                icon = "○",
              },
              level_3 = {
                enabled = true,
                icon = "✿",
              },
              level_4 = {
                enabled = true,
                icon = "•",
              },
            },
            marker = {
              enabled = true, -- Enable the beautification of markers
              icon = "",
            },
          },
        },
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
          config = {
            workspaces = {
              my_workspace = "~/Desktop/vimwiki/org",
            },
            index = "index.norg",
          },
        },
      },
    },
  }
  lvim.builtin.compe.source.neorg = true
end

return M
