local M = {}

M.oil = {
  n = {
    ["<leader>od"] = { "<cmd>lua require('oil').open('.') <cr>", "Open directory" },
    ["<leader>of"] = { "<cmd>lua require('oil').open_float('.') <cr>", "Open float directory" },
  },
}

return M
