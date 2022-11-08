local M = {}

function M.is_web_project()
  return (
    vim.fn.glob("package.json", nil, nil) ~= ""
    or vim.fn.glob("yarn.lock", nil, nil) ~= ""
    or vim.fn.glob("node_modules", nil, nil) ~= ""
  )
end

--
-- Does package.json file contain speficied configuration or dependency?
-- (e.g. "prettier", "tailwind", etc.)
-- IMPORTANT! package.json file is found only if current working directory (cwd)
-- is in the root of the project, i.e. lvim was launched in the directory
-- where package.json is or vim-rooter (or something similar) is activated
--
function M.is_in_package_json(field)
  if vim.fn.filereadable(vim.fn.getcwd() .. "/package.json") ~= 0 then
    local package_json = vim.fn.json_decode(vim.fn.readfile "package.json")
    if package_json[field] ~= nil then
      return true
    end
    local dev_dependencies = package_json["devDependencies"]
    if dev_dependencies ~= nil and dev_dependencies[field] ~= nil then
      return true
    end
    local dependencies = package_json["dependencies"]
    if dependencies ~= nil and dependencies[field] ~= nil then
      return true
    end
  end
  return false
end

-- Does the current project have a Tailwind dependency?
-- Assumes that LunarVim has been opened in the root of the project
function M.project_has_tailwindcss_dependency()
  return (vim.fn.glob "tailwind*" ~= "" or M.is_in_package_json "tailwindcss")
end

-- Does the current project have a Prettier dependency?
-- Assumes that LunarVim has been opened in the root of the project
function M.project_has_prettier_dependency()
  return (vim.fn.glob ".prettierrc*" ~= "" or vim.fn.glob "prettier.*" ~= "" or M.is_in_package_json "prettier")
end

return M
