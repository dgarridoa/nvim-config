local options = {
  { "<leader>p", group = "ChatGPT" },
  { "<leader>pc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
  {
    mode = { "n", "v" },
    { "<leader>pe", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
    { "<leader>pg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
    { "<leader>pt", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
    { "<leader>pk", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
    { "<leader>pd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
    { "<leader>pa", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
    { "<leader>po", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
    { "<leader>ps", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
    { "<leader>pf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
    { "<leader>px", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
    { "<leader>pr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
    { "<leader>pl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
  },
}
return options
