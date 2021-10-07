-- input new file (create dirctories and files with the same command)

-- If the input value ends with '/', the directory will be created and
-- If the input value contains '/', and the directory does not exist, it will be created recursively
-- If the input file name does not contain '.' or '/', check if it is a directory.
-- If the first string is '.' and show_hidden_files is false, set it to true and display it again.
-- =========================================
return function()
  local lir = require "lir"
  local utils = require "lir.utils"
  local config = require "lir.config"
  local actions = require "lir.actions"
  local Path = require "plenary.path"

  local no_confirm_patterns = {
    "^LICENSE$",
    "^Makefile$",
  }
  local lcd = function(path)
    vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], path))
  end
  local need_confirm = function(filename)
    for _, pattern in ipairs(no_confirm_patterns) do
      if filename:match(pattern) then
        return false
      end
    end
    return true
  end

  -- local function input_newfile()
  local save_curdir = vim.fn.getcwd()
  lcd(lir.get_context().dir)
  local name = vim.fn.input("New file: ", "", "file")
  lcd(save_curdir)

  if name == "" then
    return
  end

  if name == "." or name == ".." then
    utils.error("Invalid file name: " .. name)

    return
  end

  -- If I need to check, I will.
  if need_confirm(name) then
    -- '.' is not included or '/' is not included, then
    -- I may have entered it as a directory, I'll check.
    if not name:match "%." and not name:match "/" then
      if vim.fn.confirm("Directory?", "&No\n&Yes", 1) == 2 then
        name = name .. "/"
      end
    end
  end

  local path = Path:new(lir.get_context().dir .. name)
  if string.match(name, "/$") then
    -- mkdir
    name = name:gsub("/$", "")
    path:mkdir {
      parents = true,
      mode = tonumber("700", 8),
      exists_ok = false,
    }
  else
    -- touch
    path:touch {
      parents = true,
      mode = tonumber("644", 8),
    }
  end

  -- If the first character is '.' and show_hidden_files is false, set it to true
  if name:match [[^%.]] and not config.values.show_hidden_files then
    config.values.show_hidden_files = true
  end

  actions.reload()

  -- Jump to a line in the parent directory of the file you created.
  local lnum = lir.get_context():indexof(name:match "^[^/]+")
  if lnum then
    vim.cmd(tostring(lnum))
  end
end
