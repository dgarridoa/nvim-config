local M = {}

M.fugitive = {
  plugin = true,
  n = {
    ["<leader>gbl"] = { "<cmd> Git blame <cr>", "Display git blame" },
    ["<leader>gdi"] = { "<cmd> Git diff <cr>", "Display git diff" },
    ["<leader>gds"] = { "<cmd> Ghdiffsplit <cr>", "Display git diff with horizontal split" },
    ["<leader>gdd"] = { "<cmd> Gdiffsplit <cr>", "Display git diff with vertical split" },
    ["<leader>gdt"] = { "<cmd> Git difftool <cr>", "Display git diff into quickfix list" },
    ["<leader>git"] = { "<cmd> Git<cr>", "Open summary git window" },
    ["<leader>glg"] = { "<cmd> Git log <cr>", "Display git log" },
    ["<leader>gl"] = { "<cmd> Git log --oneline --decorate --all --graph <cr>", "Display one line git log" },
    ["<leader>gmt"] = { "<cmd> Git mergetool <cr>", "Display merge conflicts into quickfix list" },
  },
}

return M
