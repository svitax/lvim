local M = {}

M.config = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  -- require("dap-install").config("python_dbg", {})
  dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  }
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = "/usr/local/bin/python3",
      -- TODO: fix python debugging resolving to conda environment
      -- pythonPath = function()
      -- 	-- TODO: the problem is my VIRTUAL_ENV variable is never set
      -- 	local cwd = vim.fn.getenv("VIRTUAL_ENV")
      -- 	if vim.fn.executable(cwd .. "/bin/python") == 1 then
      -- 		return cwd .. "/bin/python"
      -- 	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
      -- 		return cwd .. "/.venv/bin/python"
      -- 	else
      -- 		return "/usr/local/bin/python3"
      -- 	end
      -- end,
    },
  }
end

return M
