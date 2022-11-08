local M = {}

M.config = function()
  local status_ok, dial_config = pcall(require, "dial.config")
  if not status_ok then
    return
  end

  local augend = require "dial.augend"
  dial_config.augends:register_group {
    default = {
      augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
      augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
      augend.date.alias["%Y-%m-%d"], -- date (2022-02-19, etc.)
      augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
      augend.date.alias["%m/%d"], -- date (02/19, etc.)
      augend.date.alias["%H:%M"], -- time (14:30, etc.)
      augend.constant.alias.bool, -- boolean value (true <-> false)
      augend.semver.alias.semver, -- semantic version (0.3.0, 1.22.1, 3.9.1, etc.)
    },
  }
  require("user.keymaps").set_dial_keymaps()
end

return M
