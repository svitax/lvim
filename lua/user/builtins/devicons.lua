local M = {}

M.config = function()
  -- custom folder icon
  require("nvim-web-devicons").set_icon {
    -- css = {
    --   icon = "",
    --   -- color = "#667FE3",
    --   color = "#D3869B",
    --   name = "CSS",
    -- },
    sol = {
      icon = "",
      -- color = "#458588",
      -- color = "#A661AB",
      color = "#3A87CB",
      name = "Solidity",
    },
    js = {
      icon = "",
      -- icon = "",
      color = "#FABD2F",
      name = "JavaScript",
    },
    ts = {
      icon = "",
      -- icon = "ﯤ",
      color = "#3A87CB",
      name = "TypeScript",
    },
    kt = {
      icon = "",
      color = "#E08C3D",
      name = "Kotlin",
    },
    py = {
      icon = "",
      color = "#4B78A6",
      name = "Python",
    },
    cs = {
      icon = "",
      color = "#3276B8",
      name = "CSharp",
    },
    cpp = {
      icon = "",
      color = "#3276B8",
      name = "Cpp",
    },
    css = {
      icon = "",
      color = "#3276B8",
      name = "Css",
    },
    html = {
      icon = "",
      color = "#E44D26",
      name = "Html",
    },
    [".eslintrc.json"] = {
      icon = "",
      color = "#7986CB",
      name = "Eslint",
    },
    [".eslintrc.js"] = {
      icon = "",
      color = "#7986CB",
      name = "Eslint",
    },
    [".eslintrc.yml"] = {
      icon = "",
      color = "#7986CB",
      name = "Eslint",
    },
    [".stylintrc.json"] = {
      icon = "",
      color = "#ebdbb2",
      name = "Stylelint",
    },
    [".stylintrc.js"] = {
      icon = "",
      color = "#ebdbb2",
      name = "Stylelint",
    },
    [".stylintrc.yml"] = {
      icon = "",
      color = "#ebdbb2",
      name = "Stylelint",
    },
    [".prettierrc.json"] = {
      icon = "",
      color = "#6EB1B3",
      name = "Prettier",
    },
    [".prettierrc.js"] = {
      icon = "",
      color = "#6EB1B3",
      name = "Prettier",
    },
    [".prettierrc.yml"] = {
      icon = "",
      color = "#6EB1B3",
      name = "Prettier",
    },
    ["package.json"] = {
      icon = "",
      color = "#7EAE44",
      name = "NodePackage",
    },
    ["package-lock.json"] = {
      icon = "",
      color = "#7EAE44",
      name = "NodePackageLock",
    },
    -- TODO: maybe someday devicon will have support for regexes in filename
    -- ["*.test.js"] = {
    --   icon = "ﭧ",
    --   color = "#cbcb41",
    --   name = "JavascriptTest",
    -- },
  }
end

return M
