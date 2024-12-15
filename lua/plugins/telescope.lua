return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      -- find
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      {
        "<leader>fd",
        "<cmd>Telescope file_browser hidden=true respect_gitignore=false<cr>",
        desc = "Open file browser",
      },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find all" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help page" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find oldfiles" },
      {
        "<leader>fz",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Find in current buffer",
      },
      -- lsp
      {
        "<leader>jd",
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "Jump to definition",
      },
      {
        "<leader>r",
        "<cmd>Telescope lsp_references<cr>",
        desc = "Display references",
      },
      {
        "<leader>ic",
        "<cmd>Telescope lsp_incoming_calls<cr>",
        desc = "Display incoming calls",
      },
      {
        "<leader>oc",
        "<cmd>Telescope lsp_outgoing_calls<cr>",
        desc = "Display outgoing calls",
      },
      {
        "<leader>ds",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Display document symbols",
      },
      {
        "<leader>ws",
        function()
          local telescope = require "telescope.builtin"
          telescope.lsp_workspace_symbols { query = vim.fn.input "Query: " }
        end,
        desc = "Display query workspace symbols",
      },
      {
        "<leader>di",
        "<cmd> Telescope diagnostics<cr>",
        desc = "Display diagnostic",
      },
      {
        "<leader>K",
        "<cmd>vsplit<bar>Telescope lsp_definitions<cr>",
        desc = "Open definition into vertical right split window",
      },
      -- git
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches, select to checkout branch" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status, select to jump to file" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits, select to checkout commit" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Display files tracked by git" },
      -- pick a hidden term
      { "<leader>ht", "<cmd>Telescope terms<cr>", desc = "Pick hidden term" },
      -- pick marks, type m followd by a letter to mark a line
      -- press '<char> to jump to <char> mark
      -- :marks to see all marks
      -- :delmarks! to delete all marks
      { "<leader>ma", "<cmd>Telescope marks<cr>", desc = "Marks" },
      -- tmux
      { "<leader>tp", "<cmd>Telescope tmux pane_contents<cr>", desc = "Tmux pane content" },
      { "<leader>tw", "<cmd>Telescope tmux windows<cr>", desc = "Tmux windows" },
      { "<leader>ts", "<cmd>Telescope tmux sessions<cr>", desc = "Tmux sessions" },
    },
    opts = {
      extensions_list = { "fzf", "file_browser", "tmux" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

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
}
