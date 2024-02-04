return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    require("lualine").setup {}
  end,
  config = function()
    require("lualine").setup {
      options = {
        theme = "auto",
      },
    }
  end,
}
