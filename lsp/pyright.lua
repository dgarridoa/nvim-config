---@type vim.lsp.Config
return {
  cmd = { require("utils").cmd_from_path "pyright-langserver", "--stdio" },
  filetypes = { "python" },
}
