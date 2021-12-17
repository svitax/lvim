return {
  "kosayoda/nvim-lightbulb",
  config = function()
    -- vim.fn.sign_define(
    --   "LightBulbSign",
    --   { text = require("user.builtins.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
    -- )
  end,
  event = "BufRead",
  ft = { "rust", "go", "typescript", "typescriptreact", "javascript", "javascriptreact" },
}

-- {
--   "kosayoda/nvim-lightbulb",
--   config = function()
--     -- vim.fn.sign_define(
--     --   "LightBulbSign",
--     --   { text = require("user.builtins.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
--     -- )
--   end,
--   event = "BufRead",
--   ft = { "rust", "go", "typescript", "typescriptreact", "javascript", "javascriptreact" },
-- },
