local M = {}

M.config = function()
  local ok, reach = pcall(require, "reach")
  if not ok then
    return
  end

  reach.setup {}
end

M.buffers = function()
  local options = {
    handle = "auto", -- 'bufnr' or 'dynamic' or 'auto'
    show_icons = true,
    show_current = true, -- Include current buffer in the list
    show_modified = true, -- Show buffer modified indicator
    modified_icon = "", -- Character to use as modified indicator
    grayout_current = true, -- Wheter to gray out current buffer entry
    force_delete = {}, -- List of filetypes / buftypes to use
    -- 'bdelete!' on, e.g. { 'terminal' }
    filter = nil, -- Function taking bufnr as parameter,
    -- returning true or false
    sort = nil, -- Comparator function (bufnr, bufnr) -> bool
    terminal_char = "\\", -- Character to use for terminal buffer handles
    -- when options.handle is 'dynamic'
    grayout = true, -- Gray out non matching entries
    auto_exclude_handles = {
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "0",
      "q",
      "w",
      "e",
      "r",
      "t",
      "y",
      "u",
      "i",
      "o",
      "p",
      "z",
      "x",
      "c",
      "v",
      "/",
      "b",
      "n",
      "m",
      ",",
    }, -- A list of characters not to use as handles when
    -- options.handle == 'auto', e.g. { '8', '9', 'j', 'k' }
    previous = {
      enable = true, -- Mark last used buffers with specified chars and colors
      depth = 2, -- Maximum number of buffers to mark
      chars = { "•" }, -- Characters to use as markers,
      -- last one is used when depth > #chars
      groups = { -- Highlight groups for markers,
        "String", -- last one is used when depth > #groups
        "Comment",
      },
    },
  }

  require("reach").buffers(options)
end

M.marks = function()
  local options = {
    filter = function(mark)
      return mark:match "[a-zA-Z]"
    end,
  }

  require("reach").marks(options)
end

M.tabs = function()
  local options = {
    show_icons = true,
    show_current = true,
  }

  require("reach").tabpages(options)
end

M.colorschemes = function()
  -- default
  local options = {
    filter = (function()
      local default = {
        "blue",
        "darkblue",
        "default",
        "delek",
        "desert",
        "elflord",
        "evening",
        "industry",
        "koehler",
        "morning",
        "murphy",
        "pablo",
        "peachpuff",
        "ron",
        "shine",
        "slate",
        "torte",
        "zellner",
      }

      return function(name)
        return not vim.tbl_contains(default, name) -- return true to disable
      end
    end)(),
  }

  require("reach").colorschemes(options)
end

return M
