local M = {}

M.neotest = {
  plugin = true,
  n = {
    ["<leader>rt"] = {
      function()
        require("neotest").run.run()
      end,
      "Run the nearest test",
    },
    ["<leader>rd"] = {
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      "Run the nearest test in debug mode",
    },
    ["<leader>rl"] = {
      function()
        require("neotest").run.run_last()
      end,
      "Run the last test",
    },
    ["<leader>rs"] = {
      function()
        require("neotest").run.stop()
      end,
      "Stop the nearest test",
    },
    ["<leader>rf"] = {
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "Run all test in the current file",
    },
    ["<leader>ot"] = {
      function()
        require("neotest").output.open { { enter = true } }
      end,
      "Open the output of a test result",
    },
    ["<leader>op"] = {
      function()
        require("neotest").output_panel.open()
      end,
      "Open the output panel",
    },
    ["<leader>tt"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "Toogle test summary window",
    },
  },
}

return M
