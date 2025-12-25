# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Neovim configuration repository (`~/.config/nvim/`). It's a complete Lua-based Neovim configuration designed for productive development with modern plugins and optimizations. The configuration uses `lazy.nvim` as the plugin manager and features extensive LSP integration, git tooling, fuzzy finding, and a modern UI.

Unlike typical software projects, this is a **runtime configuration** that loads when Neovim starts, not a build-time application. Key considerations include startup performance, user experience workflows, and extensive plugin ecosystem integration.

## Architecture & Structure

### Core Configuration Structure
```
Neovim Configuration Architecture
├── init.lua                    # Main entry point requiring all modules
├── lazy-lock.json              # Plugin version lock file (auto-generated)
├── lua/                        # Core configuration modules
│   ├── opt.lua                 # Vim options (clipboard, encoding, UI, etc.)
│   ├── g.lua                   # Global variables (python paths, leader keys)
│   ├── keymap.lua              # Key mappings with custom functions
│   ├── plugin.lua              # lazy.nvim plugin manager setup
│   ├── autocmd.lua             # Autocommands
│   ├── command.lua             # Custom commands
│   ├── abbreviate.lua          # Text abbreviations
│   ├── feature.lua             # Custom features (utilities)
│   ├── highlight.lua           # Syntax highlighting configuration
│   ├── plugins/                # 93+ individual plugin configs
│   │   ├── nvim-cmp.lua        # Completion engine (example pattern)
│   │   ├── nvim-treesitter.lua # Syntax highlighting
│   │   ├── mason.lua           # LSP package manager
│   │   └── ... (90+ more)
│   └── tests/                  # Test suite
│       └── feature_test_suite.lua
├── lsp/                        # Language Server Protocol configs
│   ├── gopls.lua
│   ├── lua_ls.lua
│   ├── pylsp.lua
│   └── yamlls.lua
├── ftdetect/                   # Filetype detection configs
│   ├── indent.lua
│   ├── tab.lua
│   └── textwidth.lua
└── filetype.lua                # Custom filetype definitions
```

### Core Module Dependencies (init.lua)
The initialization sequence is:
1. `opt.lua` - Vim options and settings
2. `g.lua` - Global variables (leader keys, Python paths)
3. `abbreviate.lua` - Text abbreviations
4. `autocmd.lua` - Autocommands
5. `command.lua` - Custom user commands
6. `keymap.lua` - Core key mappings
7. `plugin.lua` - lazy.nvim setup (loads all plugins from `lua/plugins/`)
8. `highlight.lua` - Syntax highlighting

### Plugin Configuration Pattern
Each plugin in `lua/plugins/*.lua` follows this pattern:
```lua
return {
    {
        "author/repo",
        config = function()
            -- Configuration logic
        end,
        dependencies = { ... },
        event = { "InsertEnter", "CmdlineEnter" },  -- Lazy loading triggers
        keys = { ... },  -- Key mappings for lazy loading
        ft = { ... },  -- Filetype triggers
    }
}
```

### Feature Module (lua/feature.lua)
Utility functions used across the configuration:
- `poll_number()` - Cycles line number modes (relative → absolute → none → both)
- `xxd()` - Toggles hex dump view using xxd
- `format(fmt)` - Formats buffer while preserving view and cursor position
- `get_relative_path(pathA, pathB)` - Calculates relative paths
- `parse_args(s)` - Parses command arguments with quote handling
- `to_list(value)` - Converts values to lists (handles strings, tables, functions)

## Development Commands

### Testing
```bash
make test
```
- Runs LuaUnit tests located in `lua/tests/`
- Test file: `lua/tests/feature_test_suite.lua`
- CI/CD: `.github/workflows/test.yaml` runs tests on Ubuntu with LuaRocks

### Running Single Test
```bash
cd lua && lua tests/feature_test_suite.lua -v -p TestParseArgs
```

### Plugin Management
- **No traditional build process** - this is a configuration, not compiled software
- Plugins are managed automatically by `lazy.nvim` on Neovim startup
- First launch of Neovim installs `lazy.nvim` and all configured plugins
- Plugin versions are tracked in `lazy-lock.json` (auto-generated)
- Local development plugins can be placed in `~/.config/nvim/lua/dev/` and will be auto-detected for patterns matching "tenfyzhong" or "zhongtenghui"

## Key Configuration Patterns

### Adding a New Plugin
1. Create `lua/plugins/plugin-name.lua`
2. Return a plugin specification compatible with `lazy.nvim`
3. Follow the pattern shown in `lua/plugins/nvim-cmp.lua:1`

### Per-Project Customization
Use `.vimrc.local` in project directories to customize behavior:

```vim
" Override formatters for specific filetypes
let g:conform_auto_formatters_go = ['goimports-reviser', 'gofumpt']
let g:conform_manual_formatters_sh = ['shfmt']

" Disable formatting for a filetype
let g:conform_disable_go = 1

" Pass custom arguments to formatters
let g:conform_args_shfmt = ['-i', '4', '-bn']
let g:conform_args_gofumpt = ['-extra']
```

### Available Customization Variables
- `g:conform_auto_formatters_{filetype}` - Override default formatters
- `g:conform_manual_formatters_{filetype}` - Override manual formatters
- `g:conform_disable_{filetype}` - Disable formatting for filetype
- `g:conform_args_{formatter}` - Custom arguments for specific formatters

## Key Mappings Reference

### Leader Keys
- **Leader**: `'` (single quote)
- **Local leader**: `,` (comma)

### Core Navigation
- `j`/`k` - Smart line navigation (respects wrapped lines via `gj`/`gk`)
- `gj`/`gk` - Standard j/k navigation
- `H` - Go to start of line (`0`)
- `L` - Go to end of line (`$`)
- `;` - Enter command mode (normal mode)

### Window Management
- `<C-w>\` - Vertical split
- `<C-w>-` - Horizontal split

### Folding
- `<Space><Space>` - Toggle folds

### LSP (via Telescope)
- `gh` - LSP references
- `gd` - Go to definition
- `gD` - Peek definition
- `K` - Hover documentation
- `<leader>la` - Code actions
- `<leader>re` - Rename symbol
- `<leader>ll` - Line diagnostics
- `<leader>lc` - Cursor diagnostics
- `<leader>lb` - Buffer diagnostics
- `<leader>li` - Incoming calls
- `<leader>lo` - Outgoing calls

### Formatting
- `<leader>af` - Manual format
- `:Format` - Manual format command
- Auto-format on save (BufWritePre) for configured filetypes

### Other
- `<leader>w` - Save all and redraw
- `<leader>nn` - Cycle line number modes
- `<leader>tn` - New tab
- `<leader>tc` - Close tab
- `<esc><esc>` - Clear search highlighting
- `:XXD` - Toggle hex dump view

## External Dependencies

### Formatter Tools (required for conform.nvim)
| Tool | Purpose | Installation |
|------|---------|--------------|
| **shfmt** | Shell formatter | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| **gofumpt** | Go formatter (stricter gofmt) | `go install mvdan.cc/gofumpt@latest` |
| **goimports-reviser** | Go import reviser | `go install github.com/incu6us/goimports-reviser@latest` |
| **goimports** | Go imports fixer | `go install golang.org/x/tools/cmd/goimports@latest` |
| **markdownlint-cli2** | Markdown linter | `npm install -g markdownlint-cli2` |
| **stylua** | Lua formatter | `cargo install stylua` |
| **fish_indent** | Fish shell formatter | Comes with Fish shell |
| **gojq** | JSON processor | `go install github.com/jzelinskie/gojq@latest` |
| **yamlfmt** | YAML formatter | `go install github.com/google/yamlfmt/cmd/yamlfmt@latest` |

### Language Servers (via mason.nvim)
- **gopls** (Go): `lsp/gopls.lua`
- **lua_ls** (Lua): `lsp/lua_ls.lua`
- **pylsp** (Python): `lsp/pylsp.lua`
- **yamlls** (YAML): `lsp/yamlls.lua`

## Testing Strategy

### Test Framework
- **Framework**: LuaUnit
- **Location**: `lua/tests/feature_test_suite.lua`
- **Run**: `make test` executes all tests with verbose output

### Test Coverage
Tests focus on configuration logic and utility functions:
- `parse_args()` - Argument parsing with quoted strings and escapes
- `get_relative_path()` - Path manipulation and normalization
- `to_list()` - Type conversion utilities
- `poll_number()` - Line number state transitions
- `xxd()` - Hex dump toggle functionality
- `format()` - Formatter wrapper with view preservation

### CI/CD Pipeline
- **Workflow**: `.github/workflows/test.yaml`
- **Platform**: Ubuntu with LuaRocks
- **Actions**: Installs LuaUnit, runs test suite
- **Trigger**: On push to main branch and pull requests

## Development Workflow

### Common Tasks
1. **Add plugin**: Create `lua/plugins/name.lua` with lazy.nvim spec
2. **Modify plugin**: Edit corresponding `lua/plugins/*.lua` file
3. **Test changes**: Run `make test` or manually test in Neovim
4. **Customize per-project**: Add `.vimrc.local` with `g:conform_*` variables
5. **Add utility function**: Add to `lua/feature.lua` with tests in `lua/tests/feature_test_suite.lua`

### Unique Aspects vs. Typical Software Projects
1. **Runtime configuration** loads at Neovim startup, not build time
2. **Heavy plugin reliance** - 93+ external plugins configured
3. **Performance critical** - Startup time optimization is key
4. **User experience focus** - Key mappings, UI themes, editor workflows
5. **External dependencies** - Formatters, linters, language servers
6. **Personalization** - Designed for individual workflow
7. **Testing approach** - Tests configuration logic, not application behavior

### Local Plugin Development
The configuration supports local plugin development:
- Development directory: `~/.config/nvim/lua/dev/`
- Auto-detected for author patterns: "tenfyzhong", "zhongtenghui"
- Configured in `lua/plugin.lua:9-15`

## Important Files for Reference

- `init.lua:1` - Main entry point
- `lua/plugin.lua:3` - lazy.nvim setup
- `lua/plugins/nvim-cmp.lua:1` - Example plugin configuration pattern
- `lua/plugins/conform.lua:1` - Formatter configuration with per-project customization
- `lua/feature.lua:1` - Utility functions
- `lua/tests/feature_test_suite.lua:1` - Test suite
- `Makefile:3` - Test command definition
- `.github/workflows/test.yaml` - CI/CD configuration
