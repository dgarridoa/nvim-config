local M = {}
M.venv = {
  plugin = true,
  n = {
    ["<leader>vs"] = { "<cmd>:VenvSelect<cr>" },
  },
}
return M
