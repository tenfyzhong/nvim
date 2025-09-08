# nvim

My personal Neovim configuration, designed for a productive and efficient development experience.

## Features

This configuration is packed with features to provide a modern and powerful development environment inside Neovim. It's built upon a curated list of plugins managed by `lazy.nvim`.

### Core Development
*   **LSP & Completion**: Full-featured Language Server Protocol (LSP) support for code intelligence, using `nvim-cmp` for completion, `mason.nvim` for LSP server management, and `lspsaga.lua` for enhanced UI.
*   **Linting & Formatting**: On-the-fly linting with `nvim-lint` and code formatting with `conform.lua`. Diagnostics are neatly displayed using `trouble.lua`.
*   **Syntax Highlighting**: Advanced syntax highlighting and code analysis powered by `nvim-treesitter`.
*   **Debugging**: Integrated debugging capabilities with `nvim-dap` and `traces.lua`.

### Git & Version Control
*   **Git Integration**: Deep Git integration with `gitsigns.nvim` (hunk management), `diffview.nvim` (side-by-side diffs), `agit.nvim`, and `nvim-gito.lua`.
*   **Terminal Git UIs**: Quick access to `lazygit.nvim`.
*   **Commit Assistance**: `committia.lua` to help with conventional commit messages.

### Editing & Productivity
*   **AI-Powered Development**: In-editor assistance from AI with `copilot.lua` and `codecompanion.lua`.
*   **Efficient Navigation**: Fast movement with `hop.lua` and `jumpy.lua`. Fuzzy finding across files, buffers, and more with `fzf.lua`. `zoxide.lua` for quick directory jumping.
*   **Text Manipulation**: Advanced text objects with `targets.lua`. Surrounding text with `nvim-surround`. Splitting and joining code blocks with `treesj.lua`. Swapping arguments with `iswap.lua`.
*   **Multi-Cursor**: `multicursors.lua` for simultaneous editing.
*   **Snippets & Templates**: `ftemplate.lua` for file templates and extensive language snippets.
*   **Session Management**: Automatically saves sessions with `remember.lua`.
*   **Pasting & Undo**: Enhanced paste mechanics with `yanky.lua` and a persistent undo tree with `undotree.lua`.
*   **Commenting**: `ts-comments.lua` for powerful comment toggling.
*   **Bookmarks**: `vim-bookmarks.lua` for project-based bookmarks.
*   **Task Runner**: `overseer.nvim` for managing and running background tasks and commands.

### User Interface & Experience
*   **Modern UI**: A clean and informative statusline from `lualine.nvim`, notifications from `notify.lua`, and LSP progress from `fidget.lua`.
*   **File Explorer**: A feature-rich file explorer with `neo-tree.nvim`.
*   **Theming**: `material.lua` for a pleasant color scheme.
*   **Code Outline**: `aerial.lua` provides a symbol tree for easy navigation.
*   **Folding**: `nvim-ufo` for beautiful and performant code folding.
*   **Utility UI**: `ccc.lua` for a color picker, `quickhl.lua` for temporary highlighting, and a distraction-free start screen with `vim-startify.lua`.

### Language & Filetype Support
*   **Web Development**: Enhanced support for TypeScript/JavaScript (`vim-jsx-typescript.lua`).
*   **Go**: Specific enhancements for Go development (`go.lua`).
*   **DevOps**: Support for Docker (`dockerfile.lua`), Nginx (`nginx.lua`), and `iptables.lua`.
*   **Markdown**: A superior Markdown experience with `markdown-preview.lua`, `vim-markdown.lua`, `toc.lua` for table of contents, `mermaid.lua` for diagrams, `bullets.lua` for list management, and `vim-table-mode.lua`.
*   **Data Formats**: Tools for JSON (`vim-json.lua`, `vim-jsonpath.lua`), XML (`xml.lua`), KDL (`kdl.lua`), and Thrift (`thrift.lua`).
*   **Diagramming**: Support for `d2` diagrams.

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
