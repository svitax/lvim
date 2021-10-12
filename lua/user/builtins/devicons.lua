local M = {}

M.config = function()
  -- custom folder icon
  require("nvim-web-devicons").set_icon {
    deb = {
      icon = "",
      color = "#9A1E33",
      name = "deb",
    },
    Dockerfile = {
      icon = "",
      color = "#0187C9",
      name = "Dockerfile",
    },
    ["Cargo.lock"] = {
      icon = "",
      color = "#FFD54F",
      name = "lock",
    },
    ["robots.txt"] = {
      icon = "ﮧ",
      color = "#FF5252",
      name = "Robots",
    },
    rb = {
      icon = "",
      color = "#F44336",
      name = "rb",
    },
    xz = {
      icon = "",
      color = "#AFB42B",
      name = "xz",
    },
    zip = {
      icon = "",
      color = "#AFB42B",
      name = "zip",
    },
    yml = {
      icon = "",
      color = "#FF5252",
      name = "Yaml1",
    },
    yaml = {
      icon = "",
      color = "#FF5252",
      name = "Yaml2",
    },
    toml = {
      icon = "",
      color = "#FF5252",
      name = "Toml",
    },
    zsh = {
      -- icon = "",
      icon = "",
      -- icon = "",
      color = "#FF7043",
      name = "Zsh",
    },
    [".zshrc"] = {
      -- icon = "",
      icon = "",
      -- icon = "",
      color = "#FF7043",
      name = "ZshConfig",
    },
    sol = {
      icon = "",
      -- color = "#458588",
      -- color = "#A661AB",
      color = "#0288D1",
      name = "Solidity",
    },
    json = {
      icon = "",
      color = "#E1AD2D",
      name = "Json",
    },
    js = {
      icon = "",
      -- icon = "",
      -- icon = "",
      color = "#FABD2F",
      name = "JavaScript",
    },
    ts = {
      icon = "",
      -- icon = "ﯤ",
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
      --   icon = "",
      color = "#42A5F5",
      --   color = "#D3869B",
      name = "Css",
    },
    html = {
      icon = "",
      color = "#E44D26",
      name = "Html",
    },
    vue = {
      icon = "﵂",
      -- icon = "",
      color = "#64B587",
      name = "Vue",
    },
    svelte = {
      icon = "",
      color = "#EC6237",
      name = "Svelte",
    },
    -- swift = {
    --   icon = "",
    --   color = "#FE5E2F",
    --   name = "Swift",
    -- },
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
    [".stylelintrc.json"] = {
      icon = "",
      color = "#ebdbb2",
      name = "Stylelint",
    },
    [".stylelintrc.js"] = {
      icon = "",
      color = "#ebdbb2",
      name = "Stylelint",
    },
    [".stylelintrc.yml"] = {
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
      -- icon = "",
      icon = "",
      color = "#7EAE44",
      name = "NodePackage",
    },
    ["package-lock.json"] = {
      -- icon = "",
      icon = "",
      color = "#7EAE44",
      name = "NodePackageLock",
    },
    ["yarn.lock"] = {
      icon = "",
      color = "#42A5F5",
      name = "YarnLock",
    },
    [".gitignore"] = {
      icon = "",
      color = "#E64A19",
      name = "GitIgnore",
    },
    ["go.mod"] = {
      icon = "",
      color = "#DA4F7A",
      name = "GoMod",
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
