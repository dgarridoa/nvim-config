local keymaps = {
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
    { desc = "LSP code action" },
    { "n", "v" },
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
    "[d",
    function()
      vim.diagnostic.goto_prev { float = { border = "rounded" } }
    end,
    { desc = "Goto prev" },
  },
  {
    "]d",
    function()
      vim.diagnostic.goto_next { float = { border = "rounded" } }
    end,
    { desc = "Goto next" },
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
}
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
      "[d",
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      { desc = "Goto prev" },
    },
    {
      "]d",
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      { desc = "Goto next" },
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
    local lspconfig = require "lspconfig"

    local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
      end

      for _, keymap in ipairs(keymaps) do
        local lhs, rhs, opts, mode = unpack(keymap)
        mode = mode or "n"
        ---@diagnostic disable
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
        ---@diagnostic enable
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetype = { "lua" },
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
              vim.env.VIMRUNTIME
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

    local get_path = function(workspace, package)
      local path = lspconfig.util.path
      -- Use activated virtualenv
      if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", package)
      end

      -- Find and use virtualenv via poetry in workspace directory
      local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
      if match ~= "" then
        local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
        return path.join(venv, "bin", package)
      end

      -- Fallback to system package
      local system_path = vim.fn.exepath(package)
      return system_path
    end

    local get_python_path = function(workspace)
      local path = get_path(workspace, "python")
      if path == "" then
        path = get_path(workspace, "python3")
      end
      return path
    end

    local get_ruff_path = function(workspace)
      return get_path(workspace, "ruff")
    end

    ---@param package string
    ---@return boolean
    local is_package_in_pyproject = function(package)
      local path = lspconfig.util.path
      local match = vim.fn.glob(path.join(vim.fn.getcwd(), "pyproject.toml"))
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

    local is_pyright = is_package_in_pyproject "pyright"
    local is_ruff = is_package_in_pyproject "ruff"

    if is_pyright then
      -- python type checker
      lspconfig.pyright.setup {
        before_init = function(_, config)
          config.settings.python.pythonPath = get_python_path(config.root_dir)
        end,
        on_attach = on_attach,
        capabilities = capabilities,
        filetype = { "python" },
      }
    end
    if is_ruff then
      lspconfig.ruff_lsp.setup {
        before_init = function(_, config)
          local path = lspconfig.util.path
          config.path = get_ruff_path(config.root_dir)
          config.format = { "--config=" .. path.join(config.root_dir, "pyproject.toml") }
          config.lint = { "--config=" .. path.join(config.root_dir, "pyproject.toml") }
        end,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.hoverProvider = false
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<leader>fm", function()
            local buf_path = vim.api.nvim_buf_get_name(bufnr)
            vim.api.nvim_command("!" .. client.config.path .. " format " .. buf_path)
            vim.api.nvim_command("!" .. client.config.path .. " check " .. buf_path .. " --fix")
          end, bufopts)
        end,
        filetype = { "python" },
      }
    end
    if not is_pyright and not is_ruff then
      lspconfig.pylsp.setup {
        before_init = function(_, config)
          config.path = get_python_path(config.root_dir)
        end,
        on_attach = on_attach,
        capabilities = capabilities,
        filetype = { "python" },
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
      vim.g.pylsp = true
    end

    lspconfig.terraformls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetype = { "terraform" },
    }

    lspconfig.gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetype = { "go" },
    }
  end,
}
