local null_ls = require "null-ls"

local opts = {
  sources = {
    -- null_ls.builtins.formatting.flake8,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.luacheck,
    -- null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.diagnostics.ruff,
    -- null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.completion.spell,
  },
}
return opts
