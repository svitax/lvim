local M = {}

M.config = function()
  local status_ok, mkdnflow = pcall(require, "mkdnflow")
  if not status_ok then
    return
  end

  mkdnflow.setup {
    use_mappings_table = false,
  }

  local mkdn_group = vim.api.nvim_create_augroup("mkdn", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "markdown",
    group = mkdn_group,
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "<cmd>MkdnNextLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<S-Tab>", "<cmd>MkdnPrevLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<A-o>", "<cmd>MkdnGoBack<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<A-i>", "<cmd>MkdnGoForward<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>MkdnFollowLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "v", "<CR>", "<cmd>MkdnFollowLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<F2>", "<cmd>MkdnMoveSource<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<A-CR>", "<cmd>MkdnDestroyLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "v", "<A-CR>", "<cmd>MkdnDestroyLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "+", "<cmd>MkdnIncreaseHeading<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "-", "<cmd>MkdnDecreaseHeading<cr>", { noremap = true })
      vim.cmd "set nospell"
      --   mappings = {
      --   MkdnNextLink = { "n", "<Tab>" },
      --   MkdnPrevLink = { "n", "<S-Tab>" },
      --   MkdnNextHeading = { "n", "<leader>]" },
      --   MkdnPrevHeading = { "n", "<leader>[" },
      --   MkdnGoBack = { "n", "<A-o>" },
      --   MkdnGoForward = { "n", "<A-i>" },
      --   MkdnFollowLink = { { "n", "v" }, "<CR>" },
      --   MkdnDestroyLink = { "n", "<A-CR>" },
      --   MkdnMoveSource = { "n", "<F2>" },
      --   MkdnYankAnchorLink = { "n", "ya" },
      --   MkdnYankFileAnchorLink = { "n", "yfa" },
      --   MkdnIncreaseHeading = { "n", "+" },
      --   MkdnDecreaseHeading = { "n", "-" },
      --   MkdnToggleToDo = { "n", "<A-Space>" },
      --   MkdnNewListItem = false,
      --   MkdnExtendList = false,
      --   -- MkdnUpdateNumbering = { "n", "<leader>nn" },
      -- },
    end,
  })
end

return M
