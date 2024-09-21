return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvimtree" },
    { "<leader>nf", "<cmd>NvimTreeFocus<cr>", desc = "Focus nvimtree" },
  },
  opts = {},
}
