local M = {}

M.telescope = {
  plugin = true,
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fd"] = { "<cmd> Telescope file_browser hidden=true respect_gitignore=false <cr>", "Open file browser" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    -- lsp
    ["<leader>jd"] = { "<cmd> Telescope lsp_definitions <cr>", "Jump to definition" },
    ["<leader>r"] = { "<cmd> Telescope lsp_references <cr>", "Display references" },
    ["<leader>ic"] = { "<cmd> Telescope lsp_incoming_calls <cr>", "Display incoming calls" },
    ["<leader>oc"] = { "<cmd> Telescope lsp_outgoing_calls <cr>", "Display outgoing calls" },
    ["<leader>ds"] = { "<cmd> Telescope lsp_document_symbols <cr>", "Display document symbols" },
    ["<leader>ws"] = { ":Telescope lsp_workspace_symbols query=", "Display query workspace symbols" },
    ["<leader>di"] = { "<cmd> Telescope diagnostics <cr>", "Display diagnostic" },
    ["<leader>K"] = {
      "<cmd> vsplit <bar> Telescope lsp_definitions <cr>",
      "Open definition into vertical right split window",
    },
    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>gb"] = { "<cmd> Telescope git_branches <cr>" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <cr>" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <cr>" },
    ["<leader>gf"] = { "<cmd> Telescope git_files <cr>" },
    ["<leader>gd"] = { "<cmd> Git diff <cr>" },
    ["<leader>glg"] = { "<cmd> Git log <cr>" },
    ["<leader>gl"] = { "<cmd> Git log --oneline --decorate --all --graph <cr>" },
    -- pick a hidden term
    ["<leader>ht"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },
    -- pick marks, type m followd by a letter to mark a line
    -- press '<char> to jump to <char> mark
    -- :marks to see all marks
    -- :delmarks! to delete all marks
    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
    -- tmux
    ["<leader>tp"] = { "<cmd> Telescope tmux pane_contents <cr>", "Tmux pane content" },
    ["<leader>tw"] = { "<cmd> Telescope tmux windows <cr>", "Tmux windows" },
    ["<leader>ts"] = { "<cmd> Telescope tmux sessions <cr>", "Tmux sessions" },
  },
}

return M
