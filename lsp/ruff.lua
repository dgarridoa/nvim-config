---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<leader>fm", function()
      local buf_path = vim.api.nvim_buf_get_name(bufnr)
      vim.api.nvim_command("!" .. require("utils").get_path "ruff" .. " format " .. buf_path)
      vim.api.nvim_command("!" .. require("utils").get_path "ruff" .. " check " .. buf_path .. " --fix")
    end, bufopts)
  end,
  filetypes = { "python" },
}
