local M = {}

M.undotree = {
  plugin = true,
  n = {
    ["<leader>ut"] = { "<cmd> UndotreeToggle <cr>", "Toogle Undo Tree" },
  },
}

return M
