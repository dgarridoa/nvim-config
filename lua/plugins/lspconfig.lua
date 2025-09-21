return {
  "neovim/nvim-lspconfig",
  keys = {
    {
      "gD",
      function()
        vim.lsp.buf.declaration()
      end,
      { desc = "LSP declaration" },
    },
    {
      "gd",
      function()
        vim.lsp.buf.definition()
      end,
      { desc = "LSP definition" },
    },
    {
      "K",
      function()
        vim.lsp.buf.hover()
      end,
      { desc = "LSP hover" },
    },
    {
      "gi",
      function()
        vim.lsp.buf.implementation()
      end,
      { desc = "LSP implementation" },
    },
    {
      "<leader>ls",
      function()
        vim.lsp.buf.signature_help()
      end,
      { desc = "LSP signature help" },
    },
    {
      "<leader>D",
      function()
        vim.lsp.buf.type_definition()
      end,
      { desc = "LSP definition type" },
    },
    {
      "<leader>rn",
      function()
        vim.lsp.buf.rename()
      end,
      { desc = "LSP rename" },
    },
    {
      "<leader>ca",
      function()
        vim.lsp.buf.code_action()
      end,
      { "n", "v" },
      { desc = "LSP code action" },
    },
    {
      "gr",
      function()
        vim.lsp.buf.references()
      end,
      { desc = "LSP references" },
    },
    {
      "<leader>lf",
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      { desc = "Floating diagnostic" },
    },
    {
      "<leader>wa",
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      { desc = "Add workspace folder" },
    },
    {
      "<leader>wr",
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      { desc = "Remove workspace folder" },
    },
    {
      "<leader>wl",
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      { desc = "List workspace folders" },
    },
    {
      "<leader>fm",
      function()
        vim.lsp.buf.format { async = true }
      end,
      { desc = "LSP formatting" },
    },
  },
  config = function()
    -- Override vim.lsp.util.make_position_params to provide default position_encoding
    local original_make_position_params = vim.lsp.util.make_position_params
    vim.lsp.util.make_position_params = function(win, position_encoding)
      -- If position_encoding is not provided, default to utf-8
      if position_encoding == nil then
        -- Try to get encoding from the first available client
        local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
        if #clients > 0 then
          position_encoding = clients[1].offset_encoding or "utf-8"
        else
          position_encoding = "utf-8"
        end
      end
      return original_make_position_params(win, position_encoding)
    end

    local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Set consistent offset encoding to prevent warnings - use utf-8 for better compatibility
    capabilities.offsetEncoding = { "utf-8" }
    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { "utf-8" }

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    vim.lsp.config["lua_ls"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "lua" },
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          ---@diagnostic disable-next-line: undefined-global
          if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,
      settings = {
        Lua = {},
      },
    }

    local get_path = function(package)
      -- Use activated virtualenv
      if vim.env.VIRTUAL_ENV then
        return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", package)
      end

      local status, workspace = pcall(vim.lsp.buf.list_workspace_folders()[1])
      if status then
        -- Find and use local virtualenv
        local match = vim.fn.glob(vim.fs.joinpath(workspace, ".venv"))
        if match ~= "" then
          return vim.fs.joinpath(match, "bin", package)
        end

        -- Find and use virtualenv via poetry in workspace directory
        match = vim.fn.glob(vim.fs.joinpath(workspace, "poetry.lock"))
        if match ~= "" then
          local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
          return vim.fs.joinpath(venv, "bin", package)
        end
      end

      -- Fallback to system package
      local system_path = vim.fn.exepath(package)
      return system_path
    end

    local cmd_from_path = function(package)
      local path = get_path(package)
      if path ~= "" then
        return path
      end
      return package
    end

    ---@param package string
    ---@return boolean
    local is_package_in_pyproject = function(package)
      local match = vim.fn.glob(vim.fs.joinpath(vim.fn.getcwd(), "pyproject.toml"))
      if match ~= "" then
        local f = assert(io.open(match, "r"))
        local content = f:read "*all"
        f:close()
        if string.find(content, package) then
          return true
        end
      end
      return false
    end

    vim.lsp.config["pyright"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { cmd_from_path "pyright-langserver", "--stdio" },
      filetypes = { "python" },
    }
    vim.lsp.config["ruff"] = {
      cmd = { cmd_from_path "ruff", "server" },
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.server_capabilities.hoverProvider = false
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>fm", function()
          local buf_path = vim.api.nvim_buf_get_name(bufnr)
          vim.api.nvim_command("!" .. get_path "ruff" .. " format " .. buf_path)
          vim.api.nvim_command("!" .. get_path "ruff" .. " check " .. buf_path .. " --fix")
        end, bufopts)
      end,
      filetypes = { "python" },
    }
    vim.lsp.config["pylsp"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "python" },
      cmd = { "pylsp" },
      settings = {
        pylsp = {
          configurationSources = { "flake8", "black", "isort", "mypy" },
          plugins = {
            pycodestyle = { enabled = false },
            flake8 = {
              enabled = true,
              ignore = { "E203", "W503" },
              max_line_length = 79,
            },
            isort = { enabled = true, profile = "black", multi_line_output = 3, line_length = 79 },
            black = { enabled = true, line_length = 79 },
          },
        },
      },
    }

    vim.lsp.config["terraformls"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "terraform" },
    }

    vim.lsp.config["gopls"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "go" },
    }

    vim.lsp.config["sqls"] = {
      on_attach = function(client, bufnr)
        require("sqls").on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    }

    local is_pyright = is_package_in_pyproject "pyright"
    local is_ruff = is_package_in_pyproject "ruff"

    local servers_to_enable = { "lua_ls", "terraformls", "gopls", "sqls" }
    if is_pyright then
      table.insert(servers_to_enable, "pyright")
    end
    if is_ruff then
      table.insert(servers_to_enable, "ruff")
    end
    if not is_pyright and not is_ruff then
      table.insert(servers_to_enable, "pylsp")
      vim.g.pylsp = true
    end

    vim.lsp.enable(servers_to_enable)
  end,
}
