return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    return require "configs.dashboard"
  end,
  config = function(_, opts)
    vim.cmd "RetrailDisable"
    require("dashboard").setup(opts)
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
