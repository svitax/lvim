local M = {}

M.smart_quit = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "qa!"
      end
    end)
  else
    -- vim.cmd "SaveSession<cr>"
    vim.cmd "qa!"
  end
end

--- @author Rafat913
--- https://www.reddit.com/r/neovim/comments/um3epn/comment/i8140hi/
M.open_uri_under_cursor = function()
  local function open_uri(uri)
    if type(uri) ~= "nil" then
      uri = string.gsub(uri, "#", "\\#") -- double escapes any # signs
      uri = '"' .. uri .. '"'
      vim.cmd("!open " .. uri .. " > /dev/null")
      vim.cmd "mode"
      -- print(uri)
      return true
    else
      return false
    end
  end

  local word_under_cursor = vim.fn.expand "<cWORD>"

  -- any uri with a protocol segment
  local regex_protocol_uri = "%a*:%/%/[%a%d%#%[%]%-%%+:;!$@/?&=_.,~*()]*"
  if open_uri(string.match(word_under_cursor, regex_protocol_uri)) then
    return
  end

  -- consider anything that looks like string/string a github link
  local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
  local match = string.match(word_under_cursor, regex_plugin_url)
  if match then
    if open_uri("https://github.com/" .. match) then
      return
    end
  end

  -- otherwise, open a new line above
  vim.api.nvim_feedkeys("O", "n", false)
end

--- @author Rafat913
--- https://www.reddit.com/r/neovim/comments/um3epn/comment/i8140hi/
M.lsp_rename = function()
  local count_lsp_res_changes = function(lsp_res)
    local count = { instances = 0, files = 0 }
    if lsp_res.documentChanges then
      for _, changed_file in pairs(lsp_res.documentChanges) do
        count.files = count.files + 1
        count.instances = count.instances + #changed_file.edits
      end
    elseif lsp_res.changes then
      for _, changed_file in pairs(lsp_res.changes) do
        count.instances = count.instances + #changed_file
        count.files = count.files + 1
      end
    end
    return count
  end

  local curr_name = vim.fn.expand "<cword>"
  local input_opts = {
    prompt = "LSP Rename: ",
    default = curr_name,
  }

  vim.ui.input(input_opts, function(new_name)
    if not new_name or #new_name == 0 or curr_name == new_name then
      return
    end
    local params = vim.lsp.util.make_position_params()
    params.newName = new_name

    vim.lsp.buf_request(0, "textDocument/rename", params, function(_, res, ctx, _)
      if not res then
        return
      end

      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

      local changes = count_lsp_res_changes(res)
      local message = string.format(
        "Renamed %s instance%s in %s file%s.%s",
        changes.instances,
        changes.instances == 1 and "" or "s",
        changes.files,
        changes.files == 1 and "" or "s",
        changes.files > 1 and " To save them run ':wa'" or ""
      )
      vim.notify(message)
    end)
  end)
end

M.set_user_commands = function()
  vim.api.nvim_create_user_command("LspRename", M.lsp_rename, {})
  vim.api.nvim_create_user_command("OpenURIUnderCursor", M.open_uri_under_cursor, {})
end

return M
