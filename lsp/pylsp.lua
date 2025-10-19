---@type vim.lsp.Config
return {
  filetypes = { "python" },
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
