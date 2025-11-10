# Neovim Configuration

This is a personal Neovim configuration tailored for a productive and enjoyable development experience. It is built upon a foundation of Lua-based plugins and is optimized for performance and ease of use.

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/your-repo-name.git ~/.config/nvim
    ```

2.  **Install `lazy.nvim`, the plugin manager:**

    The configuration uses `lazy.nvim` to manage plugins. It will be automatically installed the first time you launch Neovim.

3.  **Launch Neovim:**

    Open Neovim, and `lazy.nvim` will handle the rest, installing all the configured plugins.

    ```bash
    nvim
    ```

## Features

*   **Fast Startup Time:** Optimized for quick startup and responsiveness.
*   **Modern and Consistent UI:** A clean and consistent user interface with a focus on usability.
*   **Extensible and Customizable:** Easily extend and customize the configuration to fit your workflow.
*   **LSP and Autocompletion:** Full-featured Language Server Protocol (LSP) support for intelligent code completion, diagnostics, and navigation.
*   **Debugging:** Integrated debugging support for a seamless debugging experience.
*   **Git Integration:** Deep integration with Git for efficient version control.
*   **Fuzzy Finding:** Fast and intuitive fuzzy finding for files, buffers, and more.

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

*   **shfmt**: A shell parser, formatter, and interpreter.
    *   Installation: `go install mvdan.cc/sh/v3/cmd/shfmt@latest`
*   **gofumpt**: A Go formatter, a stricter variant of `gofmt`.
    *   Installation: `go install mvdan.cc/gofumpt@latest`
*   **goimports-reviser**: A tool for revising Go imports.
    *   Installation: `go install github.com/incu6us/goimports-reviser@latest`
*   **goimports**: A tool for fixing Go imports.
    *   Installation: `go install golang.org/x/tools/cmd/goimports@latest`
*   **markdownlint-cli2**: A fast, flexible, and configurable Markdown linter.
    *   Installation: `npm install -g markdownlint-cli2` or `yarn global add markdownlint-cli2`
*   **stylua**: An opinionated Lua code formatter.
    *   Installation: `cargo install stylua`
*   **fish_indent**: The Fish shell auto-indenter.
    *   Installation: Usually comes with Fish shell. If not, install Fish shell.
*   **yq**: A lightweight and portable command-line YAML, JSON and XML processor.
    *   Installation: Refer to [yq documentation](https://mikefarah.gitbook.io/yq/#install) for various installation methods.

### Environment Variables for Conform.nvim

This configuration allows for fine-grained control over `conform.nvim` and its integrated formatters through environment variables. These variables can be set to customize formatting behavior without modifying the Lua configuration files directly.

#### General Conform.nvim Variables

| Environment Variable | Description | Example Value |
| :------------------- | :---------- | :------------ |
| `CONFORM_AUTO_{FILETYPE}_FORMATTERS` | Overrides the default automatic formatters for a given filetype. Replace `{FILETYPE}` with the actual filetype (e.g., `GO`, `SH`). Multiple formatters should be comma-separated. | `CONFORM_AUTO_GO_FORMATTERS=goimports-reviser,gofumpt` |
| `CONFORM_MANUAL_{FILETYPE}_FORMATTERS` | Overrides the default manual formatters for a given filetype. Replace `{FILETYPE}` with the actual filetype. Multiple formatters should be comma-separated. | `CONFORM_MANUAL_SH_FORMATTERS=shfmt` |
| `CONFORM_DISABLE_{FILETYPE}` | If set to "1" or "TRUE" (case-insensitive), disables formatting for the specified filetype. Replace `{FILETYPE}` with the actual filetype. | `CONFORM_DISABLE_GO=TRUE` |

#### `shfmt` Formatter Variables

These variables control the behavior of the `shfmt` formatter. Setting them to any non-whitespace value (e.g., `1`, `true`, `yes`) will enable the corresponding flag, except for `SHFMT_INDENT` which takes an integer value.

| Environment Variable | Description | `shfmt` Flag |
| :------------------- | :---------- | :----------- |
| `SHFMT_INDENT` | Sets the indentation width. | `-i <value>` |
| `SHFMT_BINARY_NEXT_LINE` | Binary operators (&&, ||) will be followed by a newline. | `-bn` |
| `SHFMT_CASE_INDEX` | Indent `case` patterns. | `-ci` |
| `SHFMT_SPACE_REDIRECTS` | Add space before redirects. | `-sr` |
| `SHFMT_KEEP_PADDING` | Keep existing indentation. | `-kp` |
| `SHFMT_FUNC_NEXT_LINE` | Function opening brace on next line. | `-fn` |

#### `goimports-reviser` Formatter Variables

These variables control the behavior of the `goimports-reviser` formatter. Setting them to any non-whitespace value (e.g., `1`, `true`, `yes`) will enable the corresponding flag, except for those that require a specific value.

| Environment Variable | Description | `goimports-reviser` Flag |
| :------------------- | :---------- | :----------------------- |
| `GOIMPORTS_REVISER_FORMAT` | Enable formatting. | `-format` |
| `GOIMPORTS_REVISER_IMPORTS_ORDER` | Specifies the order of imports. | `--imports-order <value>` |
| `GOIMPORTS_REVISER_PROJECT_NAME` | Specifies the project name for grouping imports. | `-project-name <value>` |
| `GOIMPORTS_REVISER_SEPARATE_NAMED` | Separate named imports. | `-separate-named` |
| `GOIMPORTS_REVISER_SET_ALIAS` | Set aliases for imports. | `-set-alias` |
| `GOIMPORTS_REVISER_USE_CACHE` | Use cache for faster processing. | `-use-cache` |

#### `gofumpt` Formatter Variables

These variables control the behavior of the `gofumpt` formatter. Setting them to any non-whitespace value (e.g., `1`, `true`, `yes`) will enable the corresponding flag, except for those that require a specific value.

| Environment Variable | Description | `gofumpt` Flag |
| :------------------- | :---------- | :------------ |
| `GOFUMPT_EXTRA` | Enable extra checks. | `-extra` |
| `GOFUMPT_LANG` | Specifies the Go language version. | `-lang <value>` |
| `GOFUMPT_MODPATH` | Specifies the module path. | `-modpath <value>` |

#### `goimports` Formatter Variables

This variable controls the behavior of the `goimports` formatter. Setting it to any non-whitespace value (e.g., `1`, `true`, `yes`) will enable the corresponding flag.

| Environment Variable | Description | `goimports` Flag |
| :------------------- | :---------- | :-------------- |
| `GOIMPORTS_LOCAL` | Specifies local import paths. | `-local <value>` |

#### `yq` Formatter Variables

This variable controls the behavior of the `yq` formatter.

| Environment Variable | Description | `yq` Flag |
| :------------------- | :---------- | :-------- |
| `{FILETYPE}_INDENT` | Sets the indentation width for the specific filetype (e.g., `JSON_INDENT`, `YAML_INDENT`). | `-I <value>` |
