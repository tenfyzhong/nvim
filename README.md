# nvim

My personal Neovim configuration, designed for a productive and efficient development experience.

## Features

This configuration leverages a variety of plugins to enhance Neovim's capabilities:

### Core Enhancements
*   **LSP & Completion**: Integrated Language Server Protocol (LSP) for intelligent code completion, diagnostics, and refactoring, powered by `nvim-cmp` and `mason.nvim`.
*   **Linting**: On-the-fly code linting with `nvim-lint`.
*   **Git Integration**: Comprehensive Git integration with `gitsigns.nvim`, `diffview.nvim`, `agit.nvim`, and `lazygit.nvim` for seamless version control workflows.
*   **File Navigation & Fuzzy Finding**: Efficient file browsing and fuzzy finding using `neo-tree.nvim` and `fzf.vim`.
*   **Text Objects & Motions**: Advanced text object manipulation and motions for faster editing.
*   **Syntax Highlighting & Treesitter**: Enhanced syntax highlighting and structural editing powered by `nvim-treesitter`.

### Editing & Productivity
*   **Auto-pairing & Surrounding**: Automatic pairing of delimiters and easy surrounding of text with `nvim-autopairs` and `nvim-surround`.
*   **Multiple Cursors**: Support for multiple cursors for simultaneous editing.
*   **Code Formatting & Refactoring**: Tools for consistent code formatting and quick refactoring.
*   **Snippets**: Extensive snippet support for various languages.
*   **AI Integration**: Integration with AI tools like `copilot.lua` and `gemini.lua` for intelligent code suggestions and assistance.
*   **Debugging**: Integrated debugging capabilities with `nvim-dap`.
*   **Task Runner**: `overseer.nvim` for managing and running tasks.

### User Interface & Experience
*   **Status Line**: A highly customizable status line with `lualine.nvim`.
*   **Theming**: A visually appealing theme for a comfortable coding environment.
*   **Notifications**: Non-intrusive notifications and progress indicators.

### Language Support
*   **Go**: Specific enhancements for Go development.
*   **Docker**: Support for Dockerfile editing.
*   **Nginx**: Configuration file support for Nginx.
*   **Markdown**: Improved Markdown editing and preview.
*   **JSON/XML**: Tools for working with JSON and XML files.
*   **TypeScript/JavaScript**: Enhanced support for web development.

## Installation

1.  **Install lazy.nvim first**:
    ```sh
    git clone --filter=blob:none git@github.com:folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
    ```

2.  **Clone the repo**:
    ```sh
    git clone https://github.com/tenfyzhong/nvim ~/.config/nvim
    ```

## Usage

After installation, launch Neovim. The configuration should load automatically. Explore the keybindings and commands defined in the `lua/keymap.lua` and `lua/command.lua` files for a full list of functionalities.
