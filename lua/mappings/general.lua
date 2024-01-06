local M = {}

M.general = {
  i = {
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },
  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
    -- write and quit shorcuts
    ["<leader>w"] = { ":w<cr>", "Write" },
    ["<leader>q"] = { ":q<cr>", "Quit" },
    ["<leader>Q"] = { ":q!<cr>", "Force quit" },
    -- navigate between vim and tmux window
    ["<C-h>"] = { ":<C-U>NvimTmuxNavigateLeft<cr>", "Move left" },
    ["<C-j>"] = { ":<C-U>NvimTmuxNavigateDown<cr>", "Move down" },
    ["<C-k>"] = { ":<C-U>NvimTmuxNavigateUp<cr>", "Move up" },
    ["<C-l>"] = { ":<C-U>NvimTmuxNavigateRight<cr>", "Move right" },
    ["<C-\\>"] = { ":<C-U>NvimTmuxNavigateLastActive<cr>", "Move to previous" },
    -- split resize
    ["<C-UP>"] = { ":resize -2<cr>", "Resize from down to up" },
    ["<C-DOWN>"] = { ":resize +2<cr>", "Resize from up to down" },
    ["<C-LEFT>"] = { ":vertical resize -2<cr>", "Resize from right to left" },
    ["<C-RIGHT>"] = { ":vertical resize +2<cr>", "Resize from left to right" },
    -- reload config
    ["<leader>lc"] = { ":luafile ~/.config/nvim/init.lua<cr>", "Reload config" },
    -- replace text
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace current word" },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected text one line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected text one line up" },
  },
  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    ["<Esc>"] = { "<C-\\><C-n>", "Exit terminal mode" }, -- CTRL-[]
  },
}

return M
