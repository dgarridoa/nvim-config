return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "copilot",
    auto_suggestion_provider = "copilot",
    copilot = {
      model = "o3-mini",
      timeout = 30000,
      temperature = 0,
      max_tokens = 4096,
    },
    behavior = {
      enable_cursor_planning_mode = true,
    },
  },
  build = "make", -- run :AvanteBuild if failed to load avante_repo_map
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "zbirenbaum/copilot.lua",
      lazy = false,
      priority = 1000,
      config = function()
        local cmd_path = vim.fn.stdpath "data" .. "/mason/bin/copilot-language-server"
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
          server_opts_overrides = {
            trace = "verbose",
            cmd = { cmd_path, "--stdio" },
            settings = {
              advanced = {
                listCount = 10,
                inlineSuggestCount = true,
              },
            },
          },
          filetypes = {
            yaml = true,
            markdown = true,
            help = false,
            gitcommit = true,
            gitrebase = true,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
            ["*"] = true,
          },
        }
      end,
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function(_, opts)
    require("img-clip").setup()
    require("copilot").setup()
    require("render-markdown").setup()
    require("avante_lib").load(opts)
    require("avante").setup(opts)
  end,
}
