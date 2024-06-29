return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  init = function()
    require("utils").load_mappings "neotest"
  end,
  opts = function()
    return require "configs.neotest"
  end,
  config = function(_, opts)
    require("neotest").setup(opts)
  end,
}
