local keymaps = {
  i = {
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },
  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>w"] = { ":w<cr>", "Write" },
    ["<leader>q"] = { ":q<cr>", "Quit" },
    ["<leader>Q"] = { ":q!<cr>", "Force quit" },
    ["<C-UP>"] = { ":resize -2<cr>", "Resize from down to up" },
    ["<C-DOWN>"] = { ":resize +2<cr>", "Resize from up to down" },
    ["<C-LEFT>"] = { ":vertical resize -2<cr>", "Resize from right to left" },
    ["<C-RIGHT>"] = { ":vertical resize +2<cr>", "Resize from left to right" },
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace current word" },
    ["<leader>co"] = { ":copen<cr>", "Open the quickfix list window" },
    ["<leader>cc"] = { ":cclose<cr>", "Close the quickfix list window" },
    ["<leader>cn"] = { ":cn<cr>", "Go to the next item on the list" },
    ["<leader>cp"] = { ":cp<cr>", "Go to the previous item on the list" },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected text one line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected text one line up" },
  },
  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    ["<Esc>"] = { "<C-\\><C-n>", "Exit terminal mode" },
  },
}

for mode, mappings in pairs(keymaps) do
  for key, mapping in pairs(mappings) do
    local action = mapping[1]
    local desc = mapping[2]
    vim.keymap.set(mode, key, action, { desc = desc })
  end
end
