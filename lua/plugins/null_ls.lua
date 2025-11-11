return {
  "nvimtools/none-ls.nvim",
  ft = { "lua", "python", "sql" },
  config = function()
    local null_ls = require "null-ls"
    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.sqlfluff.with {
        extra_args = { "--dialect", "bigquery" },
      },
      null_ls.builtins.formatting.sqlfluff.with {
        extra_args = { "--dialect", "bigquery" },
      },
    }
    null_ls.setup { sources = sources }
  end,
}
