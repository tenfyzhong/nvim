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
