local M = {}

M.nvimtree = {
  plugin = true,
  n = {
    -- toggle
    ["<leader>nt"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus
    ["<leader>nf"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

return M
