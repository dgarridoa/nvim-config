local keymaps = {
  {
    "<leader>rt",
    function()
      require("neotest").run.run()
    end,
    desc = "Run the nearest test",
  },
  {
    "<leader>rd",
    function()
      require("neotest").run.run { strategy = "dap" }
    end,
    desc = "Run the nearest test in debug mode",
  },
  {
    "<leader>rl",
    function()
      require("neotest").run.run_last()
    end,
    desc = "Run the last test",
  },
  {
    "<leader>rs",
    function()
      require("neotest").run.stop()
    end,
    desc = "Stop the nearest test",
  },
  {
    "<leader>rf",
    function()
      require("neotest").run.run(vim.fn.expand "%")
    end,
    desc = "Run all test in the current file",
  },
  {
    "<leader>ot",
    function()
      require("neotest").output.open { { enter = true } }
    end,
    desc = "Open the output of a test result",
  },
  {
    "<leader>op",
    function()
      require("neotest").output_panel.open()
    end,
    desc = "Open the output panel",
  },
  {
    "<leader>tt",
    function()
      require("neotest").summary.toggle()
    end,
    desc = "Toggle test summary window",
  },
}
local options = function()
  return {
    adapters = {
      require "neotest-python" {
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        -- dap = { justMyCode = false },
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = { "--log-level", "DEBUG", "-vv", "-s" },
        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",
        -- Custom python path for the runner.
        -- Can be a string or a list of strings.
        -- Can also be a function to return dynamic value.
        -- If not provided, the path will be inferred by checking for
        -- virtual envs in the local directory and for Pipenev/Poetry configs
        python = nil,
        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
        -- is_test_file = function(file_path)
        --   ...
        -- end,
        -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
        -- instances for files containing a parametrize mark (default: false)
        pytest_discover_instances = true,
      },
    },
  }
end
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  keys = keymaps,
  opts = options,
}
