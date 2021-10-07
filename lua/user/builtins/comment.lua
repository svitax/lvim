local M = {}

M.config = function()
  lvim.builtin.comment.on_config_done = function()
    require("nvim_comment").setup {
      hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
      end,
    }
  end
end

return M
