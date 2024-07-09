# Settings

The easiest way to set up Neovim with this configuration and its dependencies is by

```sh
docker build -t neovim .
```

Start a Docker container in interactive mode and launch a bash shell.

```sh
docker run --name nvim -it neovim bash
```

Inside the container, Neovim must be started four times using the command `nvim`. The first time, it will install the lazy package manager. The second time, it will install all packages using lazy. The third time, it will install language grammar with Tree-sitter. Finally, in command mode install LSP server using `:MasonInstallAll`. Note that in every attempt, you have to press enter enough times until all messages are exhausted and wait for the installation to finish.

To enable Copilot, open a code file with `nvim` and in command mode execute `:Copilot auth`. This will prompt a code that you have to copy in the browser at the provided URL.

To enable ChatGPT set the environment variable `OPENAI_API_KEY`.

Start a Docker container that maintains its previous state with an interactive bash shell.

```sh
docker start nvim
docker exec -it nvim bash
```

# Plugins

This configuration uses [lazy](https://github.com/folke/lazy.nvim) as plugin manager. In the `lua/plugins` directory, you will find the plugin modules. A brief explanation of its contents is provided below:

- `bufferline`: bufffer line (with tabpage integration).
- `chatgpt`: ChatGPT integration through OpenAI ChatGPT API.
- `cmp`: Code completion.
- `comment`: Commenting.
- `copilot`: Github Copilot.
- `dap`: Debuger Adapter Protocol.
- `dashboard`: Pretty dashboard on start screen.
- `devicons`: Web icons.
- `fugitive`: A Git wrapper.
- `github_theme`: Github color schemes.
- `gitsigns`: Git decorations.
- `indent_blankline`: Adds visual identation guides.
- `lspconfig`: To configure LSP servers.
- `lualine`: Status line.
- `markdown_preview`: Preview Markdown in a browser.
- `mason`: LSP package manager.
- `neotest`: Framework for interacting with tests.
- `null_ls`: To use Neovim as a language server for tools without LSP servers.
- `nvimtree`: A file explorer tree.
- `oil`: A file explorer with vim motion support.
- `plenary`: Lua module for asynchronous programming using coroutines. Used as dependency in other plugins.
- `project`: Set nvim cwd to the inferred project root directory (ex: .git/).
- `retrail`: To identify and remove trailing whitespaces.
- `telescope`: Fuzzy finder.
- `terminal`: To highlight log file with terminal colorscheme.
- `tmux_navigation`: To navigate seamlessly between nvim and tmux.
- `treesitter`: For syntax highlighting based on language parsers.
- `undotree`: Undo or redo changes, similar to git but with automatic commits.
- `venv`: A python virtual environment selector.
- `whichkey`: Displays a popup with possible key bindings of the command you started typing.

# Mappings

Most keybindings can be found in the `lua/mappings` directory. You can navigate keymaps using the command `:Telescope keymaps`.

# Configs

Plugin configurations can be found in the `lua/configs` directory. Neovim's general configuration, such as the leader key, is in the `lua/ini.lua` file.
