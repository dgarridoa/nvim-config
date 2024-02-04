return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  init = function()
    require("utils").lazy_load "indent-blankline.nvim"
  end,
  opts = function()
    return require "configs.blankline"
  end,
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}
