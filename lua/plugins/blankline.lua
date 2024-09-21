return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "|",
      highlight = "IndentBlanklineChar",
    },
    exclude = {
      filetypes = {
        "checkhealth",
        "dashboard",
        "gitcommit",
        "help",
        "lazy",
        "lspinfo",
        "man",
        "mason",
        "TelescopePrompt",
        "TelescopeResults",
        "terminal",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },
}
