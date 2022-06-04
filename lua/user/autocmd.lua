local M = {}

M.config = function()
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "alpha",
    command = "set laststatus=0 | autocmd BufLeave <buffer> set laststatus=" .. vim.opt.laststatus._value,
  })

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
        "",
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
