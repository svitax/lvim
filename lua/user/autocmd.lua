local M = {}
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

M.config = function()
  lvim.autocommands.custom_groups = {
    {
      "FileType",
      "alpha",
      "set laststatus=0 | autocmd BufLeave <buffer> set laststatus=" .. vim.opt.laststatus._value,
    },
  }


  vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
    callback = function()
      local winbar_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
      }

      if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
      end

      local value = require("user.winbar").gps()

      if value == nil then
        value = require("user.winbar").filename()
      end

      vim.opt_local.winbar = value
    end,
  })
end

return M
