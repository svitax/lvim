local M = {}

M.config = function()
  -- custom folder icon
  require("nvim-web-devicons").set_icon {
    ["tailwind.config.js"] = {
      icon = "",
      color = "#6AB4AC",
      name = "Tailwindcss",
    },
    [".luacheckrc"] = {
      icon = "",
      color = "#51a0cf",
      name = "Lua",
    },
    svg = {
      icon = "",
      color = "#F4B53F",
      name = "Svg",
    },
    -- svgz = {
    --   icon = "",
    --   color = "#F4B53F",
    --   name = "Svg",
    -- },
    gql = {
      icon = "",
      color = "#D74E78",
      name = "GraphQL",
    },
    graphql = {
      icon = "",
      color = "#D74E78",
      name = "GraphQL",
    },
    -- hy = {
    --   icon = "",
    --   color = "#D9B06F",
    --   name = "Hy",
    -- },
    -- TODO: a lot more of these for webpack
    ["webpack"] = {
      icon = "",
      color = "#9FD3F3",
      name = "Webpack",
    },
    ["webpack.js"] = {
      icon = "",
      color = "#9FD3F3",
      name = "Webpack",
    },
    ["webpack.config"] = {
      icon = "",
      color = "#9FD3F3",
      name = "Webpack",
    },
    [".tmux.conf"] = {
      icon = "",
      color = "#57B53E",
      name = "Tmux",
    },
    ["truffle-config.js"] = {
      icon = "",
      color = "#73DDC6",
      name = "Truffle",
    },
    -- vy = {
    --   icon = "",
    --   color = "#0288D1",
    --   name = "Vyper",
    -- },
    md = {
      icon = "",
      color = "#42A5F5",
      name = "Markdown",
    },
    [".markdownlint.json"] = {
      icon = "",
      color = "#42A5F5",
      name = "MarkdownLint",
    },
    [".firebaserc"] = {
      icon = "",
      color = "#FBC02D",
      name = "Firebase",
    },
    ["firebase.json"] = {
      icon = "",
      color = "#FBC02D",
      name = "Firebase",
    },
    -- deb = {
    --   icon = "",
    --   color = "#9A1E33",
    --   name = "deb",
    -- },
    ["docker-compose.yaml"] = {
      icon = "",
      color = "#0187C9",
      name = "Dockerfile",
    },
    ["docker-compose.yml"] = {
      icon = "",
      color = "#0187C9",
      name = "Dockerfile",
    },
    Dockerfile = {
      icon = "",
      color = "#0187C9",
      name = "Dockerfile",
    },
    dockerfile = {
      icon = "",
      color = "#0187C9",
      name = "Dockerfile",
    },
    dockerignore = {
      icon = "",
      color = "#0187C9",
      name = "Dockerfile",
    },
    ["Cargo.lock"] = {
      icon = "",
      color = "#FFD54F",
      name = "Lock",
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
      name = "zip",
    },
    zip = {
      icon = "",
      color = "#AFB42B",
      name = "zip",
    },
    yml = {
      icon = "",
      color = "#FF5252",
      name = "Yaml",
    },
    yaml = {
      icon = "",
      color = "#FF5252",
      name = "Yaml",
    },
    toml = {
      icon = "",
      color = "#FF5252",
      name = "Toml",
    },
    bash = {
      -- icon = "",
      icon = "",
      -- icon = "",
      color = "#FF7043",
      name = "Zsh",
    },
    sh = {
      -- icon = "",
      icon = "",
      -- icon = "",
      color = "#FF7043",
      name = "Sh",
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
      name = "Zsh",
    },
    [".zshenv"] = {
      -- icon = "",
      icon = "",
      -- icon = "",
      color = "#FF7043",
      name = "Zsh",
    },
    [".zprofile"] = {
      -- icon = "",
      icon = "",
      -- icon = "",
      color = "#FF7043",
      name = "Zsh",
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
      name = "Node",
    },
    ["package-lock.json"] = {
      -- icon = "",
      icon = "",
      color = "#7EAE44",
      name = "Node",
    },
    ["yarn.lock"] = {
      icon = "",
      color = "#42A5F5",
      name = "Yarn",
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
    ["go.sum"] = {
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
