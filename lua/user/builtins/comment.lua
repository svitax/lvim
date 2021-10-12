local M = {}

M.config = function()
  -- lvim.builtin.comment.pre_hook = function(ctx)
  --   return require("ts_context_commentstring.internal").calculate_commentstring()
  -- end

  lvim.builtin.comment.pre_hook = function(ctx)
    local u = require "Comment.utils"
    if ctx.ctype == u.ctype.line and ctx.cmotion == u.cmotion.line then
      -- Only comment when we are doing linewise comment and up-down motion
      return require("ts_context_commentstring.internal").calculate_commentstring()
    end
  end

  -- lvim.builtin.comment.pre_hook = function(ctx)
  --   -- Only update commentstring for tsx filetypes
  --   if vim.bo.filetype == "typescriptreact" then
  --     require("ts_context_commentstring.internal").update_commentstring()
  --   end
  -- end

  -- OLD nvim_comment with ts_context_commentstring
  -- lvim.builtin.comment.on_config_done = function()
  --   require("nvim_comment").setup {
  --     hook = function()
  --       require("ts_context_commentstring.internal").update_commentstring()
  --     end,
  --   }
  -- end
end

return M
