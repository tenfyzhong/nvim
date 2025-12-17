# Neovim Configuration (GEMINI.md)

## Project Overview

This is a personal, modular **Neovim configuration** built primarily with **Lua**. It is designed for performance, extensibility, and a modern development experience.

**Key Architecture:**
*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) is used for efficient plugin management and lazy loading.
*   **Structure:** The configuration is highly modularized under the `lua/` directory.
    *   `init.lua`: The main entry point.
    *   `lua/plugins/`: Individual configuration files for each plugin.
    *   `lua/`: Core configuration modules (options, keymaps, autocommands, etc.).
    *   `lsp/`: Language Server Protocol specific settings.

## Building and Running

Since this is a configuration repository, "building" implies setting it up for usage.

### Installation

1.  **Clone:** Clone this repository to your Neovim configuration directory:
    ```bash
    git clone <repository_url> ~/.config/nvim
    ```
2.  **Bootstrap:** Launch Neovim. `lazy.nvim` will automatically bootstrap itself and install all configured plugins:
    ```bash
    nvim
    ```

### Testing

The project includes a Lua test suite for its internal logic.

*   **Run Tests:**
    ```bash
    make test
    ```
    *Command:* `cd lua && lua tests/* -v`
    *Scope:* Runs tests defined in `lua/tests/feature_test_suite.lua`.

## Development Conventions

### Code Structure
*   **Entry Point:** `init.lua` requires core modules from `lua/`.
*   **Plugin Config:**
    *   **Location:** `lua/plugins/*.lua`.
    *   **Pattern:** Each plugin should generally have its own file returning a `lazy.nvim` spec table.
    *   **Example:** `return { "user/repo", config = function() ... end }`.
*   **Local Plugins:** Custom local plugins are supported in `lua/dev/`. The configuration is set to prefer local versions of plugins matching specific patterns (e.g., "tenfyzhong", "zhongtenghui").

### External Dependencies
This configuration relies on several external tools for formatting (`conform.nvim`) and LSP. Ensure these are installed in your `$PATH`:
*   **Formatters:** `shfmt`, `gofumpt`, `goimports`, `stylua`, `markdownlint-cli2`.
*   **LSPs:** Installed via `mason.nvim` (managed within Neovim), but system-level dependencies (like `go`, `npm`, `python3`) are required.

### Customization
*   **Local Overrides:** Project-specific overrides are supported via local vim variables (e.g., `g:conform_args_shfmt`) which can be set in a `.vimrc.local` or similar local configuration file.
