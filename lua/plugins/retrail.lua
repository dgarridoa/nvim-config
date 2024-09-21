return {
  "kaplanz/nvim-retrail",
  opts = {
    -- Enabled filetypes.
    filetype = {
      -- Strictly enable only on `include`ed filetypes. When false, only disabled
      -- on an `exclude`ed filetype.
      strict = false,
      -- Included filetype list.
      include = {},
      -- Excluded filetype list. Overrides `include` list.
      exclude = {
        "",
        "nofile",
        "aerial",
        "alpha",
        "checkhealth",
        "cmp_menu",
        "dashboard",
        "diff",
        "lazy",
        "lspinfo",
        "man",
        "mason",
        "TelescopePrompt",
        "toggleterm",
        "Trouble",
        "WhichKey",
      },
    },
  },
}
