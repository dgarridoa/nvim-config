return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    require("utils").load_mappings "bufferline"
    require("bufferline").setup {}
  end,
}
