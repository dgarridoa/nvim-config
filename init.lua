require "options"
require "keymaps"
require "config.lazy"

local original_make_position_params = vim.lsp.util.make_position_params
vim.lsp.util.make_position_params = function(win, position_encoding)
  -- If position_encoding is not provided, default to utf-8
  if position_encoding == nil then
    -- Try to get encoding from the first available client
    local clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
    if #clients > 0 then
      position_encoding = clients[1].offset_encoding or "utf-8"
    else
      position_encoding = "utf-8"
    end
  end
  return original_make_position_params(win, position_encoding)
end

local servers_to_enable = { "copilot-language-server", "lua_ls", "terraformls", "gopls", "pyright", "ruff" }
vim.lsp.enable(servers_to_enable)
