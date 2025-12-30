local set_keymaps = function(keymaps)
  for mode, mappings in pairs(keymaps) do
    for key, mapping in pairs(mappings) do
      local action = mapping[1]
      local desc = mapping[2]
      vim.keymap.set(mode, key, action, { desc = desc })
    end
  end
end

local general_keymaps = {
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
}

local lsp_keymaps = {
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },
    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },
    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },
    ["<leader>rn"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "LSP rename",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },
    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },
    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },
}

set_keymaps(general_keymaps)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    set_keymaps(lsp_keymaps)
  end,
})
