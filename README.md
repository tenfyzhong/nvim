# Neovim Configuration

This is a personal Neovim configuration tailored for a productive and enjoyable development experience. It is built upon a foundation of Lua-based plugins and is optimized for performance and ease of use.

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/your-repo-name.git ~/.config/nvim
    ```

2. **Install `lazy.nvim`, the plugin manager:**

    The configuration uses `lazy.nvim` to manage plugins. It will be automatically installed the first time you launch Neovim.

3. **Launch Neovim:**

    Open Neovim, and `lazy.nvim` will handle the rest, installing all the configured plugins.

    ```bash
    nvim
    ```

## Features

* **Fast Startup Time:** Optimized for quick startup and responsiveness.
* **Modern and Consistent UI:** A clean and consistent user interface with a focus on usability.
* **Extensible and Customizable:** Easily extend and customize the configuration to fit your workflow.
* **LSP and Autocompletion:** Full-featured Language Server Protocol (LSP) support for intelligent code completion, diagnostics, and navigation.
* **Debugging:** Integrated debugging support for a seamless debugging experience.
* **Git Integration:** Deep integration with Git for efficient version control.
* **Fuzzy Finding:** Fast and intuitive fuzzy finding for files, buffers, and more.

## Plugins

This configuration is powered by a curated list of plugins that enhance the Neovim experience. Here is a categorized list of the included plugins:

### Core

| Plugin | Description |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | A modern plugin manager for Neovim. |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting and code analysis. |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | A completion engine for Neovim. |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | A blazing fast and easy to configure statusline. |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | A file explorer for Neovim. |

### LSP and Completion

| Plugin | Description |
| --- | --- |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for Neovim that runs everywhere Neovim runs. |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. |
| [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim) | A light-weight lsp plugin based on neovim's built-in lsp with a highly performant UI. |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | Standalone UI for nvim-lsp progress. |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | A super powerful autopair plugin for Neovim. |

### Git

| Plugin | Description |
| --- | --- |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration for Neovim. |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Single tabpage interface for easily cycling through diffs for all modified files. |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Plugin for calling lazygit from within Neovim. |
| [committia.lua](https://github.com/tenfyzhong/committia.lua) | A Lua module for creating conventional commits. |

### User Interface

| Plugin | Description |
| --- | --- |
| [material.nvim](https://github.com/marko-cerovac/material.nvim) | Material colorscheme for Neovim. |
| [notify.nvim](https://github.com/rcarriga/nvim-notify) | A fancy notification manager for Neovim. |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | A pretty list for showing diagnostics, references, and more. |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | A code outline window for skimming and quick navigation. |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | A modern folding plugin for Neovim. |

### Utility

| Plugin | Description |
| --- | --- |
| [fzf.vim](https://github.com/junegunn/fzf.vim) | A fuzzy finder for Neovim. |
| [hop.nvim](https://github.com/phaazon/hop.nvim) | A motion plugin for Neovim. |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | Improved Yank and Put functionalities for Neovim. |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | A plugin for adding/changing/deleting surroundings in pairs. |
| [undotree](https://github.com/mbbill/undotree) | The ultimate undo history visualizer for Neovim. |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight, list and search for todo comments in your projects. |
| [zoxide.lua](https://github.com/jvgrootveld/zoxide.lua) | A Lua-based Zoxide plugin for Neovim. |
| [wakatime.nvim](https://github.com/wakatime/wakatime-nvim) | WakaTime integration for Neovim. |

## Formatter Dependencies

`conform.nvim` relies on external formatter binaries. Please ensure the following tools are installed and available in your system's PATH for optimal formatting functionality:

* **shfmt**: A shell parser, formatter, and interpreter.
  * Installation: `go install mvdan.cc/sh/v3/cmd/shfmt@latest`
* **gofumpt**: A Go formatter, a stricter variant of `gofmt`.
  * Installation: `go install mvdan.cc/gofumpt@latest`
* **goimports-reviser**: A tool for revising Go imports.
  * Installation: `go install github.com/incu6us/goimports-reviser@latest`
* **goimports**: A tool for fixing Go imports.
  * Installation: `go install golang.org/x/tools/cmd/goimports@latest`
* **markdownlint-cli2**: A fast, flexible, and configurable Markdown linter.
  * Installation: `npm install -g markdownlint-cli2` or `yarn global add markdownlint-cli2`
* **stylua**: An opinionated Lua code formatter.
  * Installation: `cargo install stylua`
* **fish_indent**: The Fish shell auto-indenter.
  * Installation: Usually comes with Fish shell. If not, install Fish shell.
* **yq**: A lightweight and portable command-line YAML, JSON and XML processor.
  * Installation: Refer to [yq documentation](https://mikefarah.gitbook.io/yq/#install) for various installation methods.

### Customizing Formatters with Vim Variables

This configuration allows for fine-grained control over `conform.nvim` and its integrated formatters through Vim's global variables (`vim.g`). These variables can be set in a local configuration file like `.vimrc.local` to customize formatting behavior per-project without modifying the core Lua configuration. This approach works well with tools like `direnv`.

#### General Conform.nvim Variables

| Vim Variable | Description | Example |
| :------------------- | :---------- | :------------ |
| `g:conform_auto_formatters_{filetype}` | Overrides the default automatic formatters for a given filetype. Replace `{filetype}` with the actual filetype (e.g., `go`, `sh`). The value should be a Vim list. | `let g:conform_auto_formatters_go = ['goimports-reviser', 'gofumpt']` |
| `g:conform_manual_formatters_{filetype}` | Overrides the default manual formatters for a given filetype. Replace `{filetype}` with the actual filetype. The value should be a Vim list. | `let g:conform_manual_formatters_sh = ['shfmt']` |
| `g:conform_disable_{filetype}` | If set to `1`, disables formatting for the specified filetype. Replace `{filetype}` with the actual filetype. | `let g:conform_disable_go = 1` |

#### Formatter-Specific Arguments

To pass custom arguments to formatters, you can use the `g:conform_args_{formatter}` global variable. This provides a flexible way to control formatter behavior. Replace `{formatter}` with the name of the formatter you want to configure (e.g., `shfmt`, `gofumpt`).

The value of the variable should be a Vim list of command-line arguments.

**Configured Formatter Names:**

* `shfmt`
* `gofumpt`
* `goimports-reviser`
* `goimports-reviser-rm-unused`
* `goimports`
* `goimports_format_only`
* `yq_json`
* `yq_yaml`

| Vim Variable | Description | Example |
| :------------------- | :---------- | :------ |
| `g:conform_args_{formatter}` | A list of command-line arguments to pass to the specified formatter. | `let g:conform_args_shfmt = ['-i', '4', '-bn']` |

**Examples:**

* **`shfmt`**: To set indentation to 4 spaces and move binary operators to the next line for shell scripts:

    ```vim
    let g:conform_args_shfmt = ['-i', '4', '-bn']
    ```

* **`gofumpt`**: To pass the `-extra` flag to `gofumpt`:

    ```vim
    let g:conform_args_gofumpt = ['-extra']
    ```

* **`goimports`**: To pass the `-local` flag to `goimports`:

    ```vim
    let g:conform_args_goimports = ['-local', 'github.com/your/project']
    ```

* **`goimports-reviser`**: To pass the `-rm-unused` flag to `goimports-reviser`:

    ```vim
    let g:conform_args_goimports_reviser = ['-rm-unused']
    ```

* **`yq_json`**: To set the indentation to 4 for JSON files:

    ```vim
    let g:conform_args_yq_json = ['-I', '4']
    ```
