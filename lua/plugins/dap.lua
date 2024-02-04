return {
  -- debug adapter protocol (dap) client
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("utils").load_mappings "dap"
    end,
  },
  -- nvim-dap UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- dap for python
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      -- might have to activate the project environment before
      -- with virtual environment selector or poetry shell
      -- check with :VenvSelectCurrent
      local path = "~/.pyenv/versions/debugpy/bin/python"
      require("dap-python").setup(path)
      require("dap-python").test_runner = "pytest"
      require("utils").load_mappings "dap_python"
    end,
  },
}
