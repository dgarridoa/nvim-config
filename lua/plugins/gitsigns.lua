local keymaps = {
  -- Navigation through hunks
  ["[c"] = {
    function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        require("gitsigns").next_hunk()
      end)
      return "<Ignore>"
    end,
    { desc = "Jump to next hunk", expr = true },
  },
  ["]c"] = {
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        require("gitsigns").prev_hunk()
      end)
      return "<Ignore>"
    end,
    { desc = "Jump to prev hunk", expr = true },
  },
  -- Actions
  ["<leader>hs"] = {
    function()
      require("gitsigns").stage_hunk()
    end,
    { desc = "Stage hunk" },
  },
  ["<leader>hS"] = {
    function()
      require("gitsigns").stage_buffer()
    end,
    { desc = "Stage buffer" },
  },
  ["<leader>hu"] = {
    function()
      require("gitsigns").undo_stage_hunk()
    end,
    { desc = "Undo stage hunk" },
  },
  ["<leader>hr"] = {
    function()
      require("gitsigns").reset_hunk()
    end,
    { desc = "Reset hunk" },
  },
  ["<leader>hR"] = {
    function()
      require("gitsigns").reset_buffer()
    end,
    { desc = "Reset buffer" },
  },
  ["<leader>hp"] = {
    function()
      require("gitsigns").preview_hunk()
    end,
    { desc = "Preview hunk" },
  },
  ["<leader>hd"] = {
    function()
      require("gitsigns").diffthis()
    end,
    { desc = "Display diff" },
  },
  ["<leader>hD"] = {
    function()
      require("gitsigns").diffthis "~"
    end,
    { desc = "Display diff with HEAD" },
  },
  ["<leader>hb"] = {
    function()
      require("gitsigns").blame_line()
    end,
    { desc = "Blame hunk" },
  },
  ["<leader>hf"] = {
    function()
      require("gitsigns").blame_line { full = true }
    end,
    { desc = "Blame hunk" },
  },
  ["<leader>tb"] = {
    function()
      require("gitsigns").toggle_current_line_blame()
    end,
    { desc = "Toggle blame hunk" },
  },
  ["<leader>td"] = {
    function()
      require("gitsigns").toggle_deleted()
    end,
    { desc = "Toggle deleted" },
  },
}

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      on_attach = function(bufnr)
        for key, value in pairs(keymaps) do
          local lhs = key
          local rhs = value[1]
          local opts = value[2]
          opts.buffer = bufnr
          vim.keymap.set("n", lhs, rhs, opts)
        end
      end,
    }
  end,
}
