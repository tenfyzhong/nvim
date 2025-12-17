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
│   ├── feature.lua             # Custom features
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

### Key Architectural Decisions

1. **Plugin-per-file pattern**: Each plugin has its own configuration file in `lua/plugins/` for maintainability
2. **Lazy loading**: Plugins are configured for performance optimization via `lazy.nvim`
3. **Modular core**: Core functionality split into focused modules (`opt.lua`, `keymap.lua`, etc.)
4. **Environment-aware configuration**: Supports per-project customization via `.vimrc.local`
5. **Formatter abstraction**: Uses `conform.nvim` with external tool dependencies

## Development Commands

### Testing
```bash
make test
```
- Runs LuaUnit tests located in `lua/tests/`
- Test file: `lua/tests/feature_test_suite.lua`
- CI/CD: `.github/workflows/test.yaml` runs tests on Ubuntu with LuaRocks

### Plugin Management
- **No traditional build process** - this is a configuration, not compiled software
- Plugins are managed automatically by `lazy.nvim` on Neovim startup
- First launch of Neovim installs `lazy.nvim` and all configured plugins
- Plugin versions are tracked in `lazy-lock.json` (auto-generated)
- Local development plugins can be placed in `~/.config/nvim/lua/dev/` and will be auto-detected for patterns matching "tenfyzhong" or "zhongtenghui"

## Plugin Management

### Adding a New Plugin
1. Create `lua/plugins/plugin-name.lua`
2. Return a plugin specification compatible with `lazy.nvim`
3. Follow the pattern shown in `lua/plugins/nvim-cmp.lua:1`

### Plugin Configuration Pattern
Each plugin file exports a table with:
- Plugin repository URL
- Configuration function
- Dependencies
- Event triggers for lazy loading
- Filetype-specific loading conditions

Example from `lua/plugins/nvim-cmp.lua:442`:
```lua
local nvim_cmp = {
    "hrsh7th/nvim-cmp",
    config = cmp_config,
    dependencies = {
        cmp_nvim_lsp,
        lspkind,
        -- ... other dependencies
    },
    event = { "InsertEnter", "CmdlineEnter" },
}
```

### Local Development
The configuration supports local plugin development:
- Development directory: `~/.config/nvim/lua/dev/`
- Auto-detected for author patterns: "tenfyzhong", "zhongtenghui"
- Configured in `lua/plugin.lua:9-15`

## Key Configuration Patterns

### Core Initialization
- **Entry point**: `init.lua:1` requires all core modules
- **Plugin setup**: `lua/plugin.lua:3` configures `lazy.nvim` with `require("lazy").setup("plugins", ...)`

### Key Mappings
- **Leader key**: `'` (single quote)
- **Local leader**: `,` (comma)
- **Smart navigation**: `j`/`k` respect wrapped lines
- **Window splitting**: `<C-w>\` (vertical), `<C-w>-` (horizontal)
- **Fold toggling**: `<Space><Space>`
- **Command mode**: `;` remapped to `:` in normal mode

### Performance Optimizations
- Lazy loading of plugins based on events/filetypes
- Conditional plugin loading
- Optimized startup sequence

## Customization Options

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

## Testing Strategy

### Test Framework
- **Framework**: LuaUnit
- **Location**: `lua/tests/feature_test_suite.lua`
- **Run**: `make test` executes all tests with verbose output

### Test Coverage
Tests focus on configuration logic and utility functions, not application behavior:
- Argument parsing utilities
- Path manipulation functions
- Configuration validation logic

### CI/CD Pipeline
- **Workflow**: `.github/workflows/test.yaml`
- **Platform**: Ubuntu with LuaRocks
- **Actions**: Installs LuaUnit, runs test suite
- **Trigger**: On push to main branch and pull requests

## Important Dependencies

### External Formatter Tools
`conform.nvim` relies on these external binaries (must be in PATH):

| Tool | Purpose | Installation |
|------|---------|--------------|
| **shfmt** | Shell formatter | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| **gofumpt** | Go formatter (stricter gofmt) | `go install mvdan.cc/gofumpt@latest` |
| **goimports-reviser** | Go import reviser | `go install github.com/incu6us/goimports-reviser@latest` |
| **markdownlint-cli2** | Markdown linter | `npm install -g markdownlint-cli2` |
| **stylua** | Lua formatter | `cargo install stylua` |
| **yq** | YAML/JSON processor | See [yq documentation](https://mikefarah.gitbook.io/yq/#install) |

### Language Servers
Configured via `mason.nvim` and `lspconfig`:
- **gopls** (Go): `lsp/gopls.lua`
- **lua_ls** (Lua): `lsp/lua_ls.lua`
- **pylsp** (Python): `lsp/pylsp.lua`
- **yamlls** (YAML): `lsp/yamlls.lua`

## Key Mappings Reference

### Navigation
- `'` - Leader key prefix
- `,` - Local leader prefix
- `j`/`k` - Smart line navigation (respects wrapped lines)
- `<C-w>\` - Vertical split
- `<C-w>-` - Horizontal split
- `<Space><Space>` - Toggle folds

### Editing
- `;` - Enter command mode (normal mode)
- Various plugin-specific mappings defined in individual plugin configs

### Plugin-Specific
- Completion, LSP, git, and other plugin mappings defined in respective `lua/plugins/*.lua` files

## Development Workflow

### Common Tasks
1. **Add plugin**: Create `lua/plugins/name.lua` with lazy.nvim spec
2. **Modify plugin**: Edit corresponding `lua/plugins/*.lua` file
3. **Test changes**: Run `make test` or manually test in Neovim
4. **Customize per-project**: Add `.vimrc.local` with `g:conform_*` variables

### Unique Aspects vs. Typical Software Projects
1. **Runtime configuration** loads at Neovim startup, not build time
2. **Heavy plugin reliance** - 93+ external plugins configured
3. **Performance critical** - Startup time optimization is key
4. **User experience focus** - Key mappings, UI themes, editor workflows
5. **External dependencies** - Formatters, linters, language servers
6. **Personalization** - Designed for individual workflow
7. **Testing approach** - Tests configuration logic, not application behavior

## References

### Existing Documentation
- **README.md** - User documentation with installation, features, plugin list
- **QWEN.md** - Internal architecture documentation and development conventions

### Critical Files
- `init.lua:1` - Main entry point
- `lua/plugin.lua:3` - lazy.nvim setup
- `lua/plugins/nvim-cmp.lua:1` - Example plugin configuration pattern
- `Makefile:3` - Test command definition
- `.github/workflows/test.yaml` - CI/CD configuration
