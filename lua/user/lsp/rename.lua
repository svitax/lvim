local M = {}

-- TODO: I got this from https://github.com/mattleong/CosmicNvim/blob/05eb50a443162d9773883984123bc3df32f3a029/lua/cosmic/core/theme/ui.lua

local api = vim.api
local lsp = vim.lsp
local buf, win
vim.notify = require("notify")

M.highlight = function(group, bg, fg, gui)
  if gui ~= nil and gui ~= "" then
    vim.api.nvim_command(("hi %s guibg=%s guifg=%s gui=%s"):format(group, bg, fg, gui))
  elseif bg == nil then
    vim.api.nvim_command(("hi %s guifg=%s"):format(group, fg))
  else
    vim.api.nvim_command(("hi %s guibg=%s guifg=%s"):format(group, bg, fg))
  end
end

M.get_relative_path = function(file_path)
  local plenary_path = require "plenary.path"
  local parsed_path, _ = file_path:gsub("file://", "")
  local path = plenary_path:new(parsed_path)
  local relative_path = path:make_relative(vim.fn.getcwd())
  return "./" .. relative_path
end

M.rename = function()
  local prompt_str = "  "
  local map_opts = { noremap = true, silent = true }
  local opts = {
    style = "minimal",
    border = "single",
    relative = "cursor",
    width = 25,
    height = 1,
    row = 1,
    col = 1,
  }
  buf, win = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  api.nvim_open_win(buf, true, opts)
  api.nvim_win_set_option(win, "scrolloff", 0)
  api.nvim_win_set_option(win, "sidescrolloff", 0)
  api.nvim_buf_set_option(buf, "modifiable", true)
  api.nvim_buf_set_option(buf, "buftype", "prompt")

  -- local _, colors = pcall(require, "cosmic.core.theme.colors")
  -- if colors then
  --   api.nvim_buf_add_highlight(buf, -1, "LspRenamePrompt", 0, 0, #prompt_str)
  --   highlight("LspRenamePrompt", "None", colors.selection_caret)
  -- end

  vim.fn.prompt_setprompt(buf, prompt_str)

  vim.api.nvim_command "startinsert!"
  api.nvim_buf_set_keymap(buf, "i", "<esc>", "<CMD>stopinsert <BAR> q!<CR>", map_opts)
  api.nvim_buf_set_keymap(
    buf,
    "i",
    "<CR>",
    -- "<CMD>stopinsert <BAR> lua require('cosmic.core.theme.ui')._rename()<CR>",
    "<CMD>stopinsert <BAR> lua require('user.lsp.rename')._rename()<CR>",
    map_opts
  )

  local function handler(...)
    local result
    local method
    local err = select(1, ...)
    local is_new = not select(4, ...) or type(select(4, ...)) ~= "number"
    if is_new then
      method = select(3, ...).method
      result = select(2, ...)
    else
      method = select(2, ...)
      result = select(3, ...)
    end

    -- if config.lsp.rename_notification then
    if err then
      vim.notify(("Error running LSP query '%s': %s"):format(method, err), vim.log.levels.ERROR)
      return
    end

    -- echo the resulting changes
    local new_word = ""
    if result and result.changes then
      local msg = ""
      for f, c in pairs(result.changes) do
        new_word = c[1].newText
        msg = msg .. ("%d changes -> %s"):format(#c, M.get_relative_path(f)) .. "\n"
      end
      local currName = vim.fn.expand "<cword>"
      msg = msg:sub(1, #msg - 1)
      vim.notify(msg, vim.log.levels.INFO, { title = ("Rename: %s -> %s"):format(currName, new_word) })
    end
    -- end

    vim.lsp.handlers[method](...)
  end

  function M._rename()
    local new_name = vim.trim(vim.fn.getline("."):sub(5, -1))
    vim.cmd [[q!]]
    local params = lsp.util.make_position_params()
    local curr_name = vim.fn.expand "<cword>"
    if not (new_name and #new_name > 0) or new_name == curr_name then
      return
    end
    params.newName = new_name
    lsp.buf_request(0, "textDocument/rename", params, handler)
  end
end

return M
