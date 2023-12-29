local M = {}

M.harpoon = {
  n = {
    ["<leader>m"] = { "<cmd> lua require('harpoon.mark').add_file() <cr>", "Add file to revisit later on" },
    ["<leader>u"] = { "<cmd> lua require('harpoon.ui').toggle_quick_menu() <cr>", "Display harpoon ui" },
    ["<leader>t1"] = { "<cmd> lua require('harpoon.term').gotoTerminal(1) <cr>", "Go to terminal 1" },
    ["<leader>t2"] = { "<cmd> lua require('harpoon.term').gotoTerminal(2) <cr>", "Go to terminal 2" },
    ["<leader>t3"] = { "<cmd> lua require('harpoon.term').gotoTerminal(3) <cr>", "Go to terminal 3" },
    ["<leader>t4"] = { "<cmd> lua require('harpoon.term').gotoTerminal(4) <cr>", "Go to terminal 4" },
    ["<leader>t5"] = { "<cmd> lua require('harpoon.term').gotoTerminal(5) <cr>", "Go to terminal 5" },
    ["<leader>t6"] = { "<cmd> lua require('harpoon.term').gotoTerminal(6) <cr>", "Go to terminal 6" },
    ["<leader>t7"] = { "<cmd> lua require('harpoon.term').gotoTerminal(7) <cr>", "Go to terminal 7" },
    ["<leader>t8"] = { "<cmd> lua require('harpoon.term').gotoTerminal(8) <cr>", "Go to terminal 8" },
    ["<leader>t9"] = { "<cmd> lua require('harpoon.term').gotoTerminal(9) <cr>", "Go to terminal 9" },
  },
}

return M
