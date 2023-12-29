local border = require("utils").border

local options = {
  -- not an option from mason.nvim
  ensure_installed = {
    "lua-language-server",
    "debugpy",
    "pyright",
    "mypy",
    "ruff-lsp",
    "pylsp",
    "flake8",
    "black",
    "isort",
    "terraform-ls",
    "texlab",
  },
  PATH = "skip",
  ui = {
    border = border "CmpBorder",
    width = 0.87,
    height = 0.8,
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
  max_concurrent_installers = 10,
}

return options
