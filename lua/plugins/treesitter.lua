return {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "vim",
      "vimdoc",
      "lua",
      "python",
      "scala",
      "r",
      "yaml",
      "sql",
      "latex",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "c",
      "rust",
      "go",
      "terraform",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
