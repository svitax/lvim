return {
  -- I need this to make winndow movement work with my prefered movement keys (jkl;)
  "numToStr/Navigator.nvim",
  event = "BufWinEnter",
  config = function()
    require("Navigator").setup()
    vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>lua require('Navigator').left()<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-h>", "<cmd>lua require('Navigator').right()<CR>", { silent = true })
  end,
}
