local M = {}

local goto_buf = function(n)
  require("bufferline").go_to(n, true)
end

M.bufferline = {
  plugin = true,
  n = {
    ["<leader>x"] = {
      ":bp<bar>sp<bar>bn<bar>bd<CR>",
    },
    ["<Tab>"] = {
      function()
        vim.cmd "BufferLineCycleNext"
      end,
      "Goto next buffer",
    },
    ["<S-Tab>"] = {
      function()
        vim.cmd "BufferLineCyclePrev"
      end,
      "Goto previous buffer",
    },
    ["<leader>1"] = {
      function()
        goto_buf(1)
      end,
      "Goto buffer 1",
    },
    ["<leader>2"] = {
      function()
        goto_buf(2)
      end,
      "Goto buffer 2",
    },
    ["<leader>3"] = {
      function()
        goto_buf(3)
      end,
      "Goto buffer 3",
    },
    ["<leader>4"] = {
      function()
        goto_buf(4)
      end,
      "Goto buffer 4",
    },
    ["<leader>5"] = {
      function()
        goto_buf(5)
      end,
      "Goto buffer 5",
    },
    ["<leader>6"] = {
      function()
        goto_buf(6)
      end,
      "Goto buffer 6",
    },
    ["<leader>7"] = {
      function()
        goto_buf(7)
      end,
      "Goto buffer 7",
    },
    ["<leader>8"] = {
      function()
        goto_buf(8)
      end,
      "Goto buffer 8",
    },
    ["<leader>9"] = {
      function()
        goto_buf(-1)
      end,
      "Goto last buffer",
    },
  },
}

return M
