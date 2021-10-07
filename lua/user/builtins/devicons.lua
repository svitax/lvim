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
  }
end

return M
