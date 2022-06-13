local M = {}

M.config = function()
  local spectre_group = vim.api.nvim_create_augroup("spectre", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "spectre_panel",
    group = spectre_group,
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<cr>", { noremap = true, silent = true })
    end,
  })

  local alpha_group = vim.api.nvim_create_augroup("alpha", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "alpha",
    group = alpha_group,
    command = "set laststatus=0 | autocmd BufLeave <buffer> set laststatus=" .. vim.opt.laststatus._value,
  })

  local gitcommit_group = vim.api.nvim_create_augroup("gitcommit", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "gitcommit",
    group = gitcommit_group,
    callback = function()
      vim.api.nvim_feedkeys("I", "n", false)
      vim.api.nvim_buf_set_keymap(0, "n", "q", ":wq<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "Q", ":q!<cr>", { noremap = true })
    end,
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
        "harpoon",
      }

      if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
      end

      local value = require("user.winbar").navic()

      if value == nil then
        value = require("user.winbar").filename()
      end

      vim.opt_local.winbar = value
    end,
  })
end

return M
