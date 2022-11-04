local M = {}

M.config = function()
  local status_ok, mkdnflow = pcall(require, "mkdnflow")
  if not status_ok then
    return
  end

  mkdnflow.setup {
    use_mappings_table = false,
    perspective = {
      priority = "root",
      root_tell = "index.md",
    },
    wrap = true,
    links = {
      transform_explicit = function(text)
        text = text:gsub(" ", "-")
        text = text:lower()
        return text
      end,
    },
  }

  -- local function mkdn_go_back()
  --   if require("mkdnflow").buffers.goBack() then
  --     return
  --   end
  --   require("bufjump").backward()
  -- end

  local mkdn_group = vim.api.nvim_create_augroup("mkdn", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "markdown",
    group = mkdn_group,
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "<cmd>MkdnNextLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<S-Tab>", "<cmd>MkdnPrevLink<cr>", { noremap = true })
      -- vim.api.nvim_buf_set_keymap(0, "n", "<A-o>", "<cmd>MkdnGoBack<cr>", { noremap = true })
      -- vim.api.nvim_buf_set_keymap(0, "n", "<A-i>", "<cmd>MkdnGoForward<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>MkdnFollowLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "v", "<CR>", "<cmd>MkdnFollowLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<F2>", "<cmd>MkdnMoveSource<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<A-CR>", "<cmd>MkdnDestroyLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "v", "<A-CR>", "<cmd>MkdnDestroyLink<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "+", "<cmd>MkdnIncreaseHeading<cr>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "-", "<cmd>MkdnDecreaseHeading<cr>", { noremap = true })
      vim.keymap.set("n", "<A-o>", "<cmd>MkdnGoBack<cr>", { buffer = 0 })
      -- vim.keymap.set("n", "<A-o>", function()
      --   print "hi"
      --   -- local ok = require("mkdnflow").buffers.goBack()
      --   -- print("ok is " .. ok)
      -- end, {
      --   buffer = 0,
      -- })
      vim.cmd "set nospell"
    end,
  })
end

return M
