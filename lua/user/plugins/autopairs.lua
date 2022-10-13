local M = {}

M.config = function()
  lvim.builtin.autopairs.on_config_done = function()
    local autopairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"

    local ts_conds = require "nvim-autopairs.ts-conds"
    local cond = require "nvim-autopairs.conds"

    -- TODO: can these rules be safely added from "config.lua" ?
    -- press % => %% is only inside comment or string
    autopairs.add_rules {
      Rule("$", "$", { "markdown" }),
      Rule("_", "_", { "markdown" }),
      Rule("*", "*", { "markdown" }),
    }

    -- Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    -- Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  end
end

return M
