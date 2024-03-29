-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet
--
--
lvim.icons.git.LineAdded = "洛"
lvim.icons.git.LineModified = "柳"
lvim.icons.git.LineRemoved = ""
lvim.icons.diagnostics.Error = ""
lvim.icons.diagnostics.Warning = ""
lvim.icons.diagnostics.Information = ""

lvim.icons.dev = {
  ["docker-compose.yml"] = {
    icon = "",
    color = "#00a4ff",
    name = "Dockerfile",
  },
  [".dockerignore"] = {
    icon = "",
    color = "#00a4ff",
    name = "Dockerfile",
  },
  ["Dockerfile"] = {
    icon = "",
    color = "#00a4ff",
    name = "Dockerfile",
  },
  [".git"] = {
    icon = "",
    color = "#aaeaff",
    name = "GitIgnore",
  },
  [".gitignore"] = {
    icon = "",
    color = "#aaeaff",
    name = "GitIgnore",
  },
  [".gitmodules"] = {
    icon = "",
    color = "#aaeaff",
    name = "GitModules",
  },
  ["js"] = {
    icon = "",
    color = "#e7d54c",
    name = "Js",
  },
  ["json"] = {
    icon = "ﬥ",
    color = "#cbcb41",
    name = "Json",
  },
  ["lua"] = {
    icon = "",
    color = "#42a5f5",
    name = "Lua",
  },
  [".luacheckrc"] = {
    icon = "",
    color = "#42a5f5",
    name = "Lua",
  },
  ["rs"] = {
    icon = "",
    color = "#ee7950",
    name = "Rust",
  },
  ["toml"] = {
    icon = "",
    color = "#ffffff",
    name = "Toml",
  },
  ["ts"] = {
    icon = "ﯤ",
    color = "#3178c6",
    name = "Ts",
  },
  ["mts"] = {
    icon = "",
    color = "#3178c6",
    name = "Ts",
  },
  ["cjs"] = {
    icon = "",
    color = "#e7d54c",
    name = "Js",
  },
  ["xml"] = {
    icon = "",
    color = "#98c15c",
    name = "Xml",
  },
  ["package.json"] = {
    icon = "",
    color = "#98c15c",
    name = "NodeJS",
  },
  ["package-lock.json"] = {
    icon = "",
    color = "#98c15c",
    name = "NodeJS",
  },
  ["yaml"] = {
    icon = "",
    color = "#ff5252",
    name = "Yaml",
  },
  ["yml"] = {
    icon = "",
    color = "#ff5252",
    name = "Yaml",
  },
  [".prettierignore"] = {
    icon = "",
    color = "#efefef",
    name = "PrettierIgnore",
  },
  [".eslintignore"] = {
    icon = "",
    color = "#efefef",
    name = "EslintIgnore",
  },
  ["Makefile"] = {
    icon = "M",
    color = "#e3833e",
    name = "Makefile",
  },
  [".tmux.conf"] = {
    icon = "",
    color = "#98c15c",
    name = "Tmux",
  },
  ["zsh"] = {
    icon = "",
    color = "#98c15c",
    name = "Shell",
  },
  [".zshrc"] = {
    icon = "",
    color = "#98c15c",
    name = "Shell",
  },
  ["sh"] = {
    icon = "",
    color = "#98c15c",
    name = "Shell",
  },
  ["bash"] = {
    icon = "",
    color = "#98c15c",
    name = "Shell",
  },
  ["lfrc"] = {
    icon = "",
    color = "#98c15c",
    name = "Shell",
  },
}

if not lvim.icons.dev then
  return
end

require("nvim-web-devicons").set_icon(lvim.icons.dev)
