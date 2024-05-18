local M = {}
local utils = require "utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetype = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

local path = lspconfig.util.path

M.get_python_path = function(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
    return path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

M.get_ruff_path = function(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "ruff")
  end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
    return path.join(venv, "bin", "ruff")
  end

  -- Fallback to system ruff.
  return vim.fn.exepath "ruff" or "ruff"
end

local ruff_on_attach = function(client, bufnr)
  M.on_attach(client, bufnr)
  client.server_capabilities.hoverProvider = false
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<space>fm", function()
    local buf_path = vim.api.nvim_buf_get_name(bufnr)
    vim.api.nvim_command("!" .. client.config.path .. " format " .. buf_path)
    vim.api.nvim_command("!" .. client.config.path .. " check " .. buf_path .. " --fix")
  end, bufopts)
end

local check_package_on_pyproject = function(package)
  local match = vim.fn.glob(path.join(vim.fn.getcwd(), "pyproject.toml"))
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

-- python type checker
lspconfig.pyright.setup {
  before_init = function(_, config)
    config.settings.python.pythonPath = M.get_python_path(config.root_dir)
  end,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetype = { "python" },
}

-- python linter
if check_package_on_pyproject "ruff" then
  lspconfig.ruff_lsp.setup {
    before_init = function(_, config)
      config.path = M.get_ruff_path(config.root_dir)
      config.format = { "--config=" .. path.join(config.root_dir, "pyproject.toml") }
      config.lint = { "--config=" .. path.join(config.root_dir, "pyproject.toml") }
    end,
    on_attach = ruff_on_attach,
    filetype = { "python" },
  }
else
  lspconfig.pylsp.setup {
    before_init = function(_, config)
      config.path = M.get_python_path(config.root_dir)
    end,
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    filetype = { "python" },
    cmd = { "pylsp" },
    settings = {
      pylsp = {
        configurationSources = { "flake8", "black", "isort", "mypy" },
        plugins = {
          pycodestyle = { enabled = false },
          flake8 = {
            enabled = true,
            ignore = { "E203", "W503" },
            max_line_length = 79,
          },
          isort = { enabled = true, profile = "black", multi_line_output = 3, line_length = 79 },
          black = { enabled = true, line_length = 79 },
        },
      },
    },
  }
end

lspconfig.terraformls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetype = { "terraform" },
}

return M
