local plugins = {
  -- asynchronous programming using coroutines
  {
    "nvim-lua/plenary.nvim",
  },
  -- icons
  {
    "nvim-tree/nvim-web-devicons",
  },
  -- theme
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup {}
      vim.cmd "colorscheme github_dark_default"
    end,
  },
  -- buffer tabs
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      require("utils").load_mappings "bufferline"
      require("bufferline").setup {}
    end,
  },
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      require("lualine").setup {}
    end,
    config = function()
      require("lualine").setup {
        options = {
          theme = "auto",
        },
      }
    end,
  },
  -- indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    init = function()
      require("utils").lazy_load "indent-blankline.nvim"
    end,
    opts = function()
      return require "configs.blankline"
    end,
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },
  -- parse generator that build syntax tree of any language
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("utils").lazy_load "nvim-treesitter"
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require "configs.gitsigns"
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  ---- lsp stuff ----
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  -- make non-LSP sources to hook into its LSP client
  {
    "nvimtools/none-ls.nvim",
    ft = { "lua", "python" },
    opts = function()
      return require "configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require "configs.luasnip"(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "jc-doyle/cmp-pandoc-references",
        "rcarriga/cmp-dap",
        "zbirenbaum/copilot-cmp",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
    config = function(_, opts)
      -- completion for search mode
      local cmp = require "cmp"
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- completion for command mode
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
      cmp.setup(opts)
      -- completion for debug mode
      cmp.setup {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      }
      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
      -- to enable popupmenu-completion for copilot
      require("copilot_cmp").setup()
    end,
  },
  -- to comment code
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
      require("utils").load_mappings "comment"
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  -- vim like file explorer
  {
    "stevearc/oil.nvim",
    opts = {},
    init = function()
      require("oil").setup {
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-x>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["."] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["h"] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      }
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- file managing, picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    init = function()
      require("utils").load_mappings "telescope"
    end,
    opts = function()
      return require "configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "camgraff/telescope-tmux.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "norcalli/nvim-terminal.lua" },
  },
  -- only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    init = function()
      require("utils").load_mappings "whichkey"
    end,
    cmd = "WhichKey",
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
  -- virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = true,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      {
        "<leader>vs",
        "<cmd>:VenvSelect<cr>",
        -- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
        "<leader>vs",
        "<cmd>:VenvSelectCached<cr>",
      },
    },
  },
  -- unlimited terminal and navigation, mark files and jump
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
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
  -- framework to interact with test through neovim
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    init = function()
      require("utils").load_mappings "neotest"
    end,
    opts = function()
      return require "configs.neotest"
    end,
    config = function(_, opts)
      require("neotest").setup(opts)
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
  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    -- Lazy load when event occurs. Events are triggered
    -- as mentioned in:
    -- https://vi.stackexchange.com/a/4495/20389
    event = "InsertEnter",
    -- You can also have it load at immediately at
    -- startup by commenting above and uncommenting below:
    -- lazy = false
    opts = function()
      return require "configs.copilot"
    end,
  },
  -- gpt api
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup {
        openai_params = {
          model = "gpt-4-32k",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 2000,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      }
      require "configs.chatgpt"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  -- set project dir
  {
    "ahmedkhalf/project.nvim",
    init = function()
      require("project_nvim").setup {}
    end,
  },
  -- render markdown files in a browser
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- syntax highlighting for terminal files
  {
    -- activate with setl filetype=terminal
    "norcalli/nvim-terminal.lua",
    init = function()
      require("terminal").setup()
    end,
  },
  -- highlight trailing whitespaces
  {
    "kaplanz/nvim-retrail",
    init = function()
      require("retrail").setup {}
    end,
  },
  -- git plugin
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  -- navigate between tmux and nvim panes seamlessly
  {
    "alexghergh/nvim-tmux-navigation",
    init = function()
      require("nvim-tmux-navigation").setup {}
    end,
  },
}

require("lazy").setup(plugins, require "configs.lazy_nvim")
