return {
  "lukas-reineke/headlines.nvim",
  config = function()
    local status_ok, headlines = pcall(require, "headlines")
    if not status_ok then
      return
    end

    vim.cmd [[highlight Headline1 guibg=#210604 guifg=#ea6962]] -- red
    vim.cmd [[highlight Headline2 guibg=#301706 guifg=#e78a4e]] -- orange
    vim.cmd [[highlight Headline3 guibg=#2e1c02 guifg=#d8a657]] -- yellow
    vim.cmd [[highlight Headline4 guibg=#1e200f guifg=#a9b665]] -- green
    vim.cmd [[highlight Headline5 guibg=#172215 guifg=#89b482]] -- aqua
    vim.cmd [[highlight Headline6 guibg=#182724 guifg=#7daea3]] -- blue
    -- blue
    vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
    vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
    vim.fn.sign_define("Headline1", { linehl = "Headline1" })
    vim.fn.sign_define("Headline2", { linehl = "Headline2" })
    vim.fn.sign_define("Headline3", { linehl = "Headline3" })
    vim.fn.sign_define("Headline4", { linehl = "Headline4" })
    vim.fn.sign_define("Headline5", { linehl = "Headline5" })
    vim.fn.sign_define("Headline6", { linehl = "Headline6" })

    headlines.setup {
      markdown = {
        source_pattern_start = "^```",
        source_pattern_end = "^```$",
        dash_pattern = "^---+$",
        headline_pattern = "^#+",
        headline_signs = { "Headline" },
        codeblock_sign = "CodeBlock",
        dash_highlight = "Dash",
      },
      rmd = {
        source_pattern_start = "^```",
        source_pattern_end = "^```$",
        dash_pattern = "^---+$",
        headline_pattern = "^#+",
        headline_signs = { "Headline" },
        codeblock_sign = "CodeBlock",
        dash_highlight = "Dash",
      },
      vimwiki = {
        source_pattern_start = "^{{{%a+",
        source_pattern_end = "^}}}$",
        dash_pattern = "^---+$",
        headline_pattern = "^=+",
        headline_signs = { "Headline" },
        codeblock_sign = "CodeBlock",
        dash_highlight = "Dash",
      },
      org = {
        source_pattern_start = "#%+[bB][eE][gG][iI][nN]_[sS][rR][cC]",
        source_pattern_end = "#%+[eE][nN][dD]_[sS][rR][cC]",
        dash_pattern = "^-----+$",
        headline_pattern = "^%*+",
        -- headline_signs = { "Headline" },
        headline_signs = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
        codeblock_sign = "CodeBlock",
        dash_highlight = "Dash",
      },
    }
  end,
}
