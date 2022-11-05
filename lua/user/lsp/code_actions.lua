local M = {}

return {
  xo = { command = "xo" },
  -- NOTE: sometimes it needs a "eslint_d restart" to pickup plugins.
  eslintd = { command = "eslint_d" },
  shellcheck = { command = "shellcheck" },
}
