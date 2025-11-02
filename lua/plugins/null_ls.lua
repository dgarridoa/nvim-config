return {
  "nvimtools/none-ls.nvim",
  ft = { "lua", "python" },
  config = function()
    local null_ls = require "null-ls"
    local sources = {
      null_ls.builtins.formatting.stylua,
    }
    null_ls.setup { sources = sources }
  end,
}
