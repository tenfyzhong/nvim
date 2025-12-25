# Personal Neovim Configuration

A modern, feature-rich Neovim configuration built with Lua, designed for productive development across multiple programming languages. This configuration uses `lazy.nvim` for plugin management and features extensive LSP integration, debugging support, git tooling, and fuzzy finding capabilities.

## Features

* **🚀 Fast Startup**: Optimized for quick startup with lazy loading
* **🎨 Modern UI**: Clean interface with material theme and consistent styling
* **📝 Smart Completion**: Full LSP support with nvim-cmp and intelligent snippets
* **🔍 Fuzzy Finding**: Fast file/buffer searching with Telescope + fzf
* **🔧 Code Formatting**: Automatic and manual formatting with conform.nvim
* **🐛 Debugging**: Integrated debugging with nvim-dap and dap-ui
* **📦 LSP Management**: Automatic LSP installation with mason.nvim
* **🌳 File Explorer**: Modern file tree with neo-tree
* **📝 Git Integration**: Git signs, diff view, and lazygit integration
* **⚡ Smart Navigation**: Hop for quick motions, smart line navigation

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

# Language servers are auto-installed via Mason on first launch
```

## Key Mappings

### Leader Keys
- **Leader**: `'` (single quote)
- **Local Leader**: `,` (comma)

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

### LSP & Code Navigation
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

## Plugin Categories

### Core
- **lazy.nvim** - Plugin manager
- **nvim-treesitter** - Syntax parsing and highlighting
- **nvim-cmp** - Completion engine
- **lualine.nvim** - Status line
- **material.nvim** - Color scheme

### LSP & Completion
- **mason.nvim** - LSP package manager
- **telescope.nvim** - Fuzzy finder with LSP integration
- **nvim-autopairs** - Auto-pair completion

### Git
- **gitsigns.nvim** - Git gutter signs
- **diffview.nvim** - Git diff viewer
- **lazygit.nvim** - Lazygit integration
- **committia.lua** - Conventional commits

### Debugging
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - DAP UI
- **nvim-dap-virtual-text** - Virtual text for DAP

### File Management
- **neo-tree.nvim** - File explorer
- **fzf.vim** - Fuzzy finder (legacy)

### Utilities
- **hop.nvim** - Motion plugin
- **yanky.nvim** - Improved yank/put
- **nvim-surround** - Surround operations
- **undotree** - Undo history visualization
- **conform.nvim** - Code formatting
- **nvim-ufo** - Modern folding

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

Tests cover utility functions like argument parsing, path manipulation, and formatting logic.

## Architecture

This configuration follows a modular pattern:

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── opt.lua           # Vim options
│   ├── g.lua             # Global variables
│   ├── keymap.lua        # Core key mappings
│   ├── plugin.lua        # lazy.nvim setup
│   ├── feature.lua       # Utility functions
│   ├── plugins/          # 90+ plugin configs
│   │   ├── nvim-cmp.lua
│   │   ├── telescope.lua
│   │   ├── conform.lua
│   │   └── ...
│   └── tests/            # Test suite
├── lsp/                  # LSP configs
├── ftdetect/             # Filetype detection
└── lazy-lock.json        # Plugin versions
```

## License

MIT
