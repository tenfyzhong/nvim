# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Neovim configuration repository (`~/.config/nvim/`). It's a complete Lua-based Neovim configuration designed for productive development with modern plugins and optimizations. The configuration uses `lazy.nvim` as the plugin manager and features extensive LSP integration, git tooling, fuzzy finding, and AI-assisted coding.

## Architecture & Structure

### Core Configuration Files (Load Order)
```
init.lua                    # Main entry point - loads all modules in order:
├── opt.lua                 # Vim options (clipboard, encoding, UI, etc.)
├── g.lua                   # Global variables (leader keys, Python paths)
├── abbreviate.lua          # Text abbreviations
├── autocmd.lua             # Autocommands (BufWritePost, InsertEnter/Leave, TextYankPost, etc.)
├── command.lua             # Custom user commands (:XXD)
├── keymap.lua              # Core key mappings (leader, navigation, window management)
├── plugin.lua              # lazy.nvim plugin manager setup
└── highlight.lua           # Syntax highlighting configuration
```

### Plugin Configuration (`lua/plugins/`)
Plugins are configured individually in separate files. Each follows lazy.nvim spec pattern:
- `conform.lua` - Formatter with per-project customization via `.vimrc.local`
- `telescope.lua` - Fuzzy finder with 20+ custom pickers (zoxide, fzf-marks, git worktree, bookmarks)
- `codecompanion.lua` - AI coding assistant with custom adapters (ARK, MIMO)
- `nvim-cmp.lua` - Completion engine with vsnip snippets
- `mason.lua` - LSP package manager (installs 30+ tools on first run)
- `lualine.lua`, `neo-tree.lua`, `gitsigns.lua` - UI components
- `yanky.lua` - Improved yank/put operations
- `hop.lua` - Motion plugin
- `nvim-ufo` - Modern folding
- `bookmarks.lua` - Code bookmarks with Telescope integration

### Language Server Protocol (`lsp/`)
- `gopls.lua` - Go language server with gofumpt integration
- `lua_ls.lua` - Lua language server
- `pylsp.lua` - Python language server
- `yamlls.lua` - YAML language server

### Utility Functions (`lua/feature.lua`)
**Core utilities used across the configuration:**
- `poll_number()` - Cycle line number modes (relative → absolute → none → both)
- `xxd()` - Toggle hex dump view using external `xxd` command
- `format()` - Format buffer preserving view/cursor (uses `winsaveview`/`winrestview`)
- `get_relative_path()` - Calculate relative paths with normalization
- `parse_args()` - Parse command arguments with quote handling (supports `"` and `'`)
- `to_list()` - Type conversion utility (string→table, table→table, function→recursive)

### Test Suite (`lua/tests/feature_test_suite.lua`)
Comprehensive tests for all feature.lua functions using LuaUnit framework.

### Local Development Plugins (`lua/dev/`)
Plugins in this directory are auto-loaded for local development:
- Pattern matching: `tenfyzhong` or `zhongtenghui`
- Configured in `lua/plugin.lua:13`
- `bookmarks.nvim` - Custom bookmark implementation
- `tsnippets.vim` - Custom snippet utilities

## Development Commands

### Testing
```bash
# Run all tests
make test

# Run single test function
cd lua && lua tests/feature_test_suite.lua -v -p TestParseArgs

# Run test with specific pattern
cd lua && lua tests/feature_test_suite.lua -v -p TestGetRelativePath
```

### Plugin Management
**No build process** - this is runtime configuration. Plugins load on Neovim startup:
- First launch installs `lazy.nvim` and all configured plugins
- Plugin versions tracked in `lazy-lock.json` (auto-generated)
- Local development: place plugins in `~/.config/nvim/lua/dev/` (auto-detected for "tenfyzhong" or "zhongtenghui" patterns)

### Per-Project Customization
Create `.vimrc.local` in project directories for formatter customization:

```vim
" Override formatters
let g:conform_auto_formatters_go = ['goimports-reviser', 'gofumpt']
let g:conform_manual_formatters_sh = ['shfmt']

" Disable formatting
let g:conform_disable_go = 1

" Custom formatter arguments
let g:conform_args_shfmt = ['-i', '4', '-bn']
let g:conform_args_gofumpt = ['-extra']
```

## Key Implementation Details

### Conform Formatter (`lua/plugins/conform.lua`)
- **Auto-format**: Triggered on `BufWritePre` for configured filetypes
- **Manual format**: `<leader>af` or `:Format`
- **Per-project config**: Reads `g:conform_*` variables from `.vimrc.local`
- **View preservation**: Uses `feature.format()` to save/restore cursor and window view
- **Supported formatters**: shfmt, gofumpt, goimports, markdownlint-cli2, stylua, fish_indent, gojq, yamlfmt

### Telescope Custom Pickers (`lua/plugins/telescope.lua`)
Custom picker functions defined in the same file:
- `fzf_marks_picker()` - Reads `~/.fzf-marks` file, changes directory on selection
- `git_worktree_picker()` - Lists git worktrees, supports tab opening with `<c-t>`
- `bookmarks_picker()` - Uses `bookmarks.nvim` data, shows relative paths

### CodeCompanion AI Assistant (`lua/plugins/codecompanion.lua`)
- **Custom adapters**: ARK (doubao-seed-code-preview) and MIMO
- **Key mappings**: `<leader>cc` (chat), `<leader>ca` (actions), `gda`/`gdr`/`gdy` (diff controls)
- **Rules system**: Auto-loads `.clinerules`, `.cursorrules`, `CLAUDE.md`, etc.
- **Prompt library**: Looks for `.prompts` in project and `~/.config/prompts`

### Smart Navigation (`lua/keymap.lua`)
- **Smart j/k**: Respects wrapped lines (`gj`/`gk` for standard behavior)
- **Count handling**: `j`/`k` respect count (e.g., `5j` works normally)
- **Search direction**: `n`/`N` respect `searchforward` option
- **Visual mode indent**: `<` and `>` keep selection for multiple indents

### Autocommands (`lua/autocmd.lua`)
- **VimL auto-reload**: Source `*vimrc`/`*.vim` on write
- **Paste mode**: Auto-disable on insert leave
- **Line numbers**: Absolute in insert, relative in normal
- **Cursorline**: Only visible in active window
- **Yank highlight**: Visual feedback on yank (200ms timeout)
- **Direnv**: Auto-allow on `.envrc` write

### Feature Functions (`lua/feature.lua`)
- **`format()`**: Uses `winsaveview()`/`winrestview()` across all windows with the buffer
- **`parse_args()`**: Handles quoted strings with escape sequences
- **`get_relative_path()`**: Normalizes paths, handles `.` and `..`, works with absolute/relative
- **`xxd()`**: Toggles between hex and binary using external `xxd` command
- **`poll_number()`**: 3-state cycle (both → absolute → none → both)

## Key Mappings Reference

### Leader Keys
- **Leader**: `'` (single quote)
- **Local leader**: `,` (comma)

### Core Navigation
- `j`/`k` - Smart line navigation (respects wrapped lines)
- `gj`/`gk` - Standard j/k navigation
- `H` - Start of line (`0`)
- `L` - End of line (`$`)
- `;` - Command mode

### Window Management
- `<C-w>\\` - Vertical split
- `<C-w>-` - Horizontal split

### Folding
- `<Space><Space>` - Toggle folds

### LSP (via Telescope)
- `gh` - LSP references
- `gd` - Go to definition
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

### Telescope (Fuzzy Finding)
- `<leader>ff` - Find files
- `<leader>fr` - Live grep
- `<leader>fb` - Buffers
- `<leader>fg` - Git files
- `<leader>fz` - Zoxide (directory navigation)
- `<leader>fs` - FZF marks
- `<leader>fw` - Git worktree
- `<leader>fM` - Bookmarks
- `<leader><leader>` - Keymaps

### AI Assistant (CodeCompanion)
- `<leader>cc` - Toggle chat
- `<leader>ca` - Actions menu
- `gda` - Accept AI change (DiffAccept)
- `gdr` - Reject AI change (DiffReject)
- `gdy` - Always accept (DiffYolo)

### Other
- `<leader>w` - Save all and redraw
- `<leader>nn` - Cycle line number modes
- `<leader>tn` - New tab
- `<leader>tc` - Close tab
- `<esc><esc>` - Clear search highlighting
- `:XXD` - Toggle hex dump view

## External Dependencies

### Required Formatter Tools
| Tool | Installation |
|------|--------------|
| **shfmt** | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| **gofumpt** | `go install mvdan.cc/gofumpt@latest` |
| **goimports-reviser** | `go install github.com/incu6us/goimports-reviser@latest` |
| **goimports** | `go install golang.org/x/tools/cmd/goimports@latest` |
| **markdownlint-cli2** | `npm install -g markdownlint-cli2` |
| **stylua** | `cargo install stylua` |
| **fish_indent** | Comes with Fish shell |
| **gojq** | `go install github.com/jzelinskie/gojq@latest` |
| **yamlfmt** | `go install github.com/google/yamlfmt/cmd/yamlfmt@latest` |

### AI API Keys (Optional)
- `ARK_API_KEY` - For ARK/doubao-seed-code-preview model
- `CODECOMPANION_MIMO_API_KEY` - For MIMO model

### Language Servers (via Mason)
All auto-installed by `:MasonUpdate` on first run:
- gopls, lua_ls, pylsp, yamlls, bash-language-server, typescript-language-server, etc.

## Testing Strategy

### Framework
- **LuaUnit** framework in `lua/tests/feature_test_suite.lua`
- Tests cover: `parse_args()`, `get_relative_path()`, `to_list()`, `poll_number()`, `xxd()`, `format()`

### CI/CD
- `.github/workflows/test.yaml` runs tests on Ubuntu with LuaRocks
- Triggered on push to main and pull requests

## Important Files for Reference

- `init.lua:1` - Main entry point (module load order)
- `lua/plugin.lua:3` - lazy.nvim setup with dev plugin support
- `lua/plugins/conform.lua:1` - Formatter with per-project customization
- `lua/plugins/telescope.lua:1` - 20+ custom pickers and LSP integration
- `lua/plugins/codecompanion.lua:1` - AI assistant with custom adapters
- `lua/feature.lua:1` - Utility functions used across config
- `lua/tests/feature_test_suite.lua:1` - Test suite
- `Makefile:3` - Test command definition
