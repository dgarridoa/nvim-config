return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  lazy = false,
  init = function()
    require("utils").load_mappings "venv"
  end,
  opts = function()
    return require "configs.venv"
  end,
  config = function(_, opts)
    require("venv-selector").setup(opts)
  end,
}
