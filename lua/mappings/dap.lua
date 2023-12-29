local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <cr>" },
    ["<leader>dr"] = { "<cmd> DapContinue <cr>" },
    ["<leader>dc"] = { "<cmd> DapTerminate <cr>" },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dt"] = {
      function()
        require("dap-python").test_method()
      end,
    },
  },
}

return M
