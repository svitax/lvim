local M = {}

M.config = function()
  -- Additional Plugins
  lvim.plugins = {
    { "luisiacc/gruvbox-baby" },
    { "svitax/fennec-gruvbox.nvim", branch = "gruvbox-baby" },
    { "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter", config = require("nvim-gps").setup() },
    { "gfeiyou/command-center.nvim",
      config = function()
        require("user.plugins.command_center").config()
      end,
      requires = "nvim-telescope/telescope.nvim",
    },
    { 'mrjones2014/legendary.nvim',
      config = function()
        require("legendary").setup({})
        -- require('which-key').register(lvim.builtin.which_key.mappings, lvim.builtin.which_key.opts)
      end,
      -- after = "folke/which-key.nvim"
    },
    { 'stevearc/dressing.nvim',
      config = function()
        require("dressing").setup({
          -- select = { telescope = require('telescope.themes').get_ivy({}) }
        })
      end },
    { "ggandor/lightspeed.nvim",
      config = function()
        require("user.plugins.lightspeed").config()
      end,
      -- disable = lvim.builtin.motion_provider ~= "lightspeed",
    },
    { "norcalli/nvim-colorizer.lua",
      config = function()
        require("user.plugins.colorizer").config()
      end,
      -- event = "BufRead",
    },
    { "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
    { 'numToStr/Navigator.nvim',
      config = function()
        require('Navigator').setup()
      end
    },
    { "kwkarlwang/bufjump.nvim",
      config = function()
        require("bufjump").setup()
      end
    },
    { "ghillb/cybu.nvim",
      requires = { "kyazdani42/nvim-web-devicons" }, --optional
      config = function()
        local ok, cybu = pcall(require, "cybu")
        if not ok then
          return
        end
        cybu.setup({
          style = {
            hide_buffer_id = true
          },
          display_time = 1500
        })
      end,
    },
    { "kazhala/close-buffers.nvim",
      event = "BufRead",
      -- cmd = { "BDelete", "BDelete!", "BWipeout", "BWipeout!" },
      config = function()
        require("close_buffers").setup {
          filetype_ignore = {}, -- Filetype to ignore when running deletions
          file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
          file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
          preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
          next_buffer_cmd = nil, -- Custom function to retrieve the next buffer when preserving window layout
        }
      end
    },
    { -- TODO: must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
      "is0n/fm-nvim",
      cmd = { "Lf", "Nnn", "Ranger" },
      config = function()
        require("fm-nvim").setup {
          border = "rounded",
          edit_cmd = "edit",
          height = 0.90,
          width = 0.90,
          -- mappings = {
          --   vert_split = "<C-v>",
          --   horz_split = "<C-s>",
          --   tabedit = "<C-t>",
          --   edit = "<C-e>",
          -- },
        }
      end,
    },
  }
end

return M
