return {
  "neovim/nvim-lspconfig",
  init = function()
    require("utils").lazy_load "nvim-lspconfig"
  end,
  config = function()
    require "configs.lspconfig"
  end,
}
