local options = {
  debounce = 200,
  indent = {
    char = "|",
    highlight = { "IblIndent" },
    smart_indent_cap = true,
    priority = 1,
    repeat_linebreak = true,
  },
  whitespace = {
    highlight = "IblWhitespace",
    remove_blankline_trail = true,
  },
  scope = {
    enabled = false,
    highlight = "IblScope",
    show_start = true,
    show_end = true,
  },
  exclude = {
    filetypes = {
      "checkhealth",
      "help",
      "man",
      "terminal",
      "lazy",
      "lspinfo",
      "gitcommit",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
    },
    buftypes = {
      "terminal",
      "nofile",
      "quickfix",
      "prompt",
    },
  },
}

return options
