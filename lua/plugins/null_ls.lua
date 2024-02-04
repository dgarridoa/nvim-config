return {
  "nvimtools/none-ls.nvim",
  ft = { "lua", "python" },
  opts = function()
    return require "configs.null_ls"
  end,
}
