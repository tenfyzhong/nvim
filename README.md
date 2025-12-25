# Personal Neovim Configuration

A modern, feature-rich Neovim configuration built with Lua, designed for productive development across multiple programming languages. This configuration uses `lazy.nvim` for plugin management and features extensive LSP integration, AI-assisted coding, git tooling, and advanced fuzzy finding capabilities.

## Features

* **🚀 Fast Startup**: Optimized for quick startup with lazy loading
* **🎨 Modern UI**: Clean interface with material theme and consistent styling
* **📝 Smart Completion**: Full LSP support with nvim-cmp and intelligent snippets
* **🔍 Advanced Fuzzy Finding**: Telescope with 20+ custom pickers including zoxide, fzf-marks, git worktree, and bookmarks
* **🔧 Code Formatting**: Automatic and manual formatting with conform.nvim and per-project customization
* **🤖 AI Assistant**: CodeCompanion integration with custom ARK and MIMO adapters for intelligent coding assistance
* **📦 LSP Management**: Automatic installation of 30+ LSP servers and tools with mason.nvim
* **🌳 File Explorer**: Modern file tree with neo-tree
* **📝 Git Integration**: Git signs, diff view, and lazygit integration
* **⚡ Smart Navigation**: Smart line navigation, hop motions, and improved yank/put operations
* **🧪 Testing**: Comprehensive test suite for utility functions

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/tenfyzhong/nvim.git ~/.config/nvim

# Launch Neovim - lazy.nvim will auto-install all plugins
nvim
```

### Required External Tools

Install these tools for full functionality:

```bash
# Formatters
go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install mvdan.cc/gofumpt@latest
go install github.com/incu6us/goimports-reviser@latest
go install golang.org/x/tools/cmd/goimports@latest
npm install -g markdownlint-cli2
cargo install stylua
go install github.com/jzelinskie/gojq@latest
go install github.com/google/yamlfmt/cmd/yamlfmt@latest

# Optional: AI API Keys (for CodeCompanion)
export ARK_API_KEY="your_ark_api_key"           # For doubao-seed-code-preview model
export CODECOMPANION_MIMO_API_KEY="your_mimo_key" # For MIMO model

# Language servers are auto-installed via Mason on first launch
# (30+ tools including gopls, lua_ls, pylsp, yamlls, bash-language-server, typescript-language-server, etc.)
```

## Key Mappings

### Leader Keys
* **Leader**: `'` (single quote)
* **Local Leader**: `,` (comma)

### Core Navigation

| Key | Action |
|-----|--------|
| `j` / `k` | Smart line navigation (respects wrapped lines) |
| `H` | Go to start of line |
| `L` | Go to end of line |
| `;` | Enter command mode |
| `<esc><esc>` | Clear search highlighting |

### Window Management

| Key | Action |
|-----|--------|
| `<C-w>\` | Vertical split |
| `<C-w>-` | Horizontal split |

### Folding

| Key | Action |
|-----|--------|
| `<Space><Space>` | Toggle folds |

### LSP & Code Navigation (via Telescope)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Peek definition |
| `gh` | Show references |
| `K` | Hover documentation |
| `<leader>la` | Code actions |
| `<leader>re` | Rename symbol |
| `<leader>ll` | Line diagnostics |
| `<leader>lc` | Cursor diagnostics |
| `<leader>lb` | Buffer diagnostics |
| `<leader>li` | Incoming calls |
| `<leader>lo` | Outgoing calls |

### Git Operations (with gitsigns)

| Key | Action |
|-----|--------|
| `<leader>ga` | Stage hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gA` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |

### File & Buffer Operations

| Key | Action |
|-----|--------|
| `<leader>nt` | Toggle file tree (neo-tree) |
| `<leader>w` | Save all and redraw |
| `<leader>tn` | New tab |
| `<leader>tc` | Close tab |

### Telescope Fuzzy Finding

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fg` | Git files |
| `<leader>fz` | Zoxide (directory navigation) |
| `<leader>fs` | FZF marks |
| `<leader>fw` | Git worktree |
| `<leader>fM` | Bookmarks |
| `<leader><leader>` | Keymaps |

### AI Assistant (CodeCompanion)

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle chat |
| `<leader>ca` | Actions menu |
| `gda` | Accept AI change (DiffAccept) |
| `gdr` | Reject AI change (DiffReject) |
| `gdy` | Always accept (DiffYolo) |

### Formatting

| Key | Action |
|-----|--------|
| `<leader>af` | Manual format |
| `:Format` | Manual format command |
| *Auto* | Formats on save for configured filetypes |

### Other Utilities

| Key | Action |
|-----|--------|
| `<leader>nn` | Cycle line number modes (relative → absolute → none → both) |
| `:XXD` | Toggle hex dump view |
| `<esc><esc>` | Clear search highlighting |

## Plugin Categories

### Core
* **lazy.nvim** - Plugin manager
* **nvim-treesitter** - Syntax parsing and highlighting
* **nvim-cmp** - Completion engine
* **lualine.nvim** - Status line
* **material.nvim** - Color scheme

### LSP & Completion
* **mason.nvim** - LSP package manager (30+ tools)
* **telescope.nvim** - Fuzzy finder with 20+ custom pickers and LSP integration
* **nvim-autopairs** - Auto-pair completion
* **aerial.nvim** - Code outline/symbols
* **nvim-treesitter** - Syntax parsing and highlighting

### AI & Git
* **codecompanion.nvim** - AI coding assistant with ARK and MIMO adapters
* **gitsigns.nvim** - Git gutter signs
* **diffview.nvim** - Git diff viewer
* **lazygit.nvim** - Lazygit integration
* **committia.lua** - Conventional commits

### Debugging
* **nvim-dap** - Debug Adapter Protocol
* **nvim-dap-ui** - DAP UI
* **nvim-dap-virtual-text** - Virtual text for DAP

### File Management
* **neo-tree.nvim** - File explorer

### Utilities
* **hop.nvim** - Motion plugin
* **yanky.nvim** - Improved yank/put
* **nvim-surround** - Surround operations
* **undotree** - Undo history visualization
* **conform.nvim** - Code formatting with per-project customization
* **nvim-ufo** - Modern folding
* **bookmarks.nvim** - Code bookmarks with Telescope integration

## Per-Project Customization

Create a `.vimrc.local` file in your project root to customize behavior:

```vim
" Override formatters
let g:conform_auto_formatters_go = ['goimports-reviser', 'gofumpt']
let g:conform_manual_formatters_sh = ['shfmt']

" Disable formatting for filetype
let g:conform_disable_go = 1

" Custom formatter arguments
let g:conform_args_shfmt = ['-i', '4', '-bn']
let g:conform_args_gofumpt = ['-extra']
```

## Testing

Run the test suite to verify configuration:

```bash
make test
```

Tests cover utility functions like argument parsing, path manipulation, formatting logic, and more using the LuaUnit framework.

### Test Coverage
* `parse_args()` - Command argument parsing with quote handling
* `get_relative_path()` - Path calculation utilities
* `to_list()` - Type conversion utilities
* `poll_number()` - Line number mode cycling
* `xxd()` - Hex dump view toggling
* `format()` - Buffer formatting with view preservation

## Architecture

This configuration follows a modular pattern:

```
~/.config/nvim/
├── init.lua              # Entry point - loads all modules
├── lua/
│   ├── opt.lua           # Vim options (clipboard, encoding, UI)
│   ├── g.lua             # Global variables (leader keys, paths)
│   ├── abbreviate.lua    # Text abbreviations
│   ├── autocmd.lua       # Autocommands
│   ├── command.lua       # Custom user commands
│   ├── keymap.lua        # Core key mappings
│   ├── plugin.lua        # lazy.nvim setup with dev support
│   ├── highlight.lua     # Syntax highlighting
│   ├── feature.lua       # Utility functions (format, parse_args, etc.)
│   ├── plugins/          # 90+ plugin configs
│   │   ├── codecompanion.lua  # AI assistant with ARK/MIMO adapters
│   │   ├── telescope.lua      # 20+ custom pickers
│   │   ├── conform.lua        # Formatter with per-project config
│   │   ├── mason.lua          # 30+ LSP tools auto-install
│   │   ├── nvim-cmp.lua
│   │   └── ...
│   └── tests/            # LuaUnit test suite
├── lsp/                  # LSP configs (gopls, lua_ls, etc.)
├── ftdetect/             # Filetype detection
└── lazy-lock.json        # Plugin versions
```

## License

MIT
