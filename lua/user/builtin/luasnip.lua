local ls = require "luasnip"
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamic = ls.dynamic_node

-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep

local date = function()
  return { os.date "%Y-%m-%d" }
end
-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

ls.add_snippets(nil, {
  markdown = {
    snip({
      trig = "beg",
      namr = "Begin Env",
    }, {
      text "\\begin{",
      insert(1),
      text { "}", "" },
      text { "\t" },
      insert(2),
      text { "", "" },
      text { "\\end{" },
      rep(1),
      text { "}" },
    }),
    snip({ trig = "ali", name = "align" }, { text { "\\begin{align*}", "", "\t" }, insert(1), text { "" }, text "\\end{align*}" }),
    snip({ trig = "hat", namr = "hat", descr = "hat" }, { text { "\\hat{" }, insert(1), text { "}" } }),
    snip({ trig = "ldo", namr = "ldots" }, { text "\\ldots" }),
    snip({ trig = "=>", namr = "implies" }, { text { "\\implies" } }),
    snip({ trig = "=<", namr = "implied by" }, { text { "\\impliedby" } }),
    snip({ trig = "iff", namr = "iff" }, { text "\\iff" }),
    snip({ trig = "frac", namr = "fraction" }, { text "\\frac{", insert(1), text "}{", insert(2), text "}" }),
    snip({ trig = "==", namr = "equals" }, { text "&= ", insert(1), text " \\\\" }),
    snip({ trig = "!=", namr = "not equal" }, { text "\\neq" }),
    snip({ trig = "ceil", namr = "ceil" }, { text "\\left\\ceil ", insert(1), text " \\right\\rceil", insert(2) }),
    snip({ trig = "floor", namr = "floor" }, { text "\\left\\floor ", insert(1), text " \\right\\rfloor", insert(2) }),
    snip({ trig = "pmat", namr = "p matrix" }, { text "\\begin{pmatrix} ", insert(1), text " \\end{pmatrix}", insert(2) }),
    snip({ trig = "bmat", namr = "b matrix" }, { text "\\begin{bmatrix} ", insert(1), text " \\end{bmatrix}", insert(2) }),
    snip({ trig = "bar", namr = "bar" }, { text "\\overline{", insert(1), text "}", insert(2) }),
    snip({ trig = "ep", namr = "epsilon" }, { text "\\epsilon", insert(1) }),
    -- snip({}, {}),
  },
  all = {
    -- ls.parser.parse_snippet("ier", "if err != nil { $0 }"),
    -- s("req", fmt("local {} = require('{}')", { insert(1, "default"), rep(1) })),
    snip({
      trig = "date",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      func(date, {}),
    }),
    snip({
      trig = "pwd",
      namr = "PWD",
      dscr = "Path to current working directory",
    }, {
      func(bash, {}, "pwd"),
    }),
    snip({
      trig = "signature",
      namr = "Signature",
      dscr = "Name and Surname",
    }, {
      text "Igor Santos",
      insert(0),
    }),
  },
  lua = {
    -- snip(
    --   "lreq",
    --   fmt([[local {} = require "{}"]], {
    --     func(function(import_name)
    --       local parts = vim.split(import_name[1][1], ".", true)
    --       return parts[#parts] or ""
    --     end, {
    --       1,
    --     }),
    --     insert(1),
    --   })
    -- ),
  },
  python = {
    snip({
      trig = "cpt",
      namr = "CompetiTest",
      dscr = "Python file template for CompetiTest",
    }, {
      text { "import sys", "", "" },
      text { "from competitest.lib.methods import input_array, input_int", "", "", "" },
      text { "def " },
      insert(1, ""),
      text "(",
      insert(2, "args"),
      text { "):", "" },
      text "\t",
      insert(3, "pass"),
      text { "", "", "" },
      text "sys.stdout.write(",
      insert(4, "output"),
      text ")",
      -- insert(2, "i < 10"),
      -- text ";",
      -- insert(3, "i++"),
      -- text { " {", "" },
      -- text "\t",
      -- insert(0),
      -- text { "", "}" },
    }),
  },
})
