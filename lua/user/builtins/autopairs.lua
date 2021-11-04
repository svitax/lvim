local M = {}

M.config = function()
  -- lvim.builtin.autopairs.on_config_done = function(module)
  --   local Rule = require "nvim-autopairs.rule"

  --   module.add_rules(require "nvim-autopairs.rules.endwise-lua")
  --   -- endwise("then$", "end", "lua", nil)

  --   -- ruby rules
  --   -- local endwise = require("nvim-autopairs.ts-rule").endwise
  --   -- module.add_rules({
  --   -- 	endwise("def", "end", "ruby","method"),
  --   -- 	endwise("module", "end", "ruby", "module"),
  --   -- 	endwise("do", "end", "ruby", "do_block"),
  --   -- 	endwise("if", "end", "ruby", "if"),
  --   -- 	endwise("unless", "end", "ruby", "unless"),
  --   -- 	endwise("case", "end", "ruby", "case"),
  --   -- 	endwise("while", "end", "ruby", "while"),
  --   -- 	endwise("until", "end", "ruby", "until"),
  --   -- 	endwise("begin", "end", "ruby", "begin"),
  --   -- })

  --   module.add_rule(Rule("```", "```", "markdown"))
  --   module.add_rule(Rule("<%= ", "%>"))

  --   module.remove_rule "`"
  --   module.remove_rule "%"
  --   module.remove_rule "$"
  --   module.add_rule(
  --     Rule("`", "`", { "markdown", "lua", "ruby", "javascript", "javascriptreact", "typescript", "typescriptreact" })
  --   )

  --   -- Javascript rules
  --   module.add_rule(Rule("<label ", "htmlFor=''></label>", "javascript"))
  --   module.add_rule(Rule("<input ", "type='text' />", "javascript"))
  --   module.add_rule(
  --     Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
  --       :use_regex(true)
  --       :set_end_pair_length(2)
  --   )
  -- end
end

return M
