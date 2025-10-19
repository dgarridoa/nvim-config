local border = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local get_path = function(package)
  -- Use activated virtualenv
  if vim.env.VIRTUAL_ENV then
    return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", package)
  end

  local status, workspace = pcall(vim.lsp.buf.list_workspace_folders()[1])
  if status then
    -- Find and use local virtualenv
    local match = vim.fn.glob(vim.fs.joinpath(workspace, ".venv"))
    if match ~= "" then
      return vim.fs.joinpath(match, "bin", package)
    end

    -- Find and use virtualenv via poetry in workspace directory
    match = vim.fn.glob(vim.fs.joinpath(workspace, "poetry.lock"))
    if match ~= "" then
      local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
      return vim.fs.joinpath(venv, "bin", package)
    end
  end

  -- Fallback to system package
  local system_path = vim.fn.exepath(package)
  return system_path
end

local cmd_from_path = function(package)
  local path = get_path(package)
  if path ~= "" then
    return path
  end
  return package
end

---@param package string
---@return boolean
local is_package_in_pyproject = function(package)
  local match = vim.fn.glob(vim.fs.joinpath(vim.fn.getcwd(), "pyproject.toml"))
  if match ~= "" then
    local f = assert(io.open(match, "r"))
    local content = f:read "*all"
    f:close()
    if string.find(content, package) then
      return true
    end
  end
  return false
end

return {
  border = border,
  get_path = get_path,
  cmd_from_path = cmd_from_path,
  is_package_in_pyproject = is_package_in_pyproject,
}
