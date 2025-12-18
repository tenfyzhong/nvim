# Repository Guidelines

This repo is a Lua-based Neovim configuration. Keep it consistent and maintainable.

## Project Structure & Module Organization
- `init.lua` entry point.
- `lua/` core logic:
  - `lua/feature.lua` utilities (arg parsing, path helpers).
  - `lua/plugins/` plugin specs for lazy.nvim.
  - `lua/tests/` unit tests using `luaunit`.
- `ftdetect/` filetype detection.
- `lsp/` LSP settings.

## Build, Test, and Development Commands
- Tests: `make test` or `cd lua && lua tests/* -v`.
- Formatting:
  - Lua: `stylua` (`.stylua.toml`).
  - Markdown: `markdownlint-cli2`.
- Reload: Restart Neovim or `:luafile init.lua` for small changes.

## Coding Style & Naming Conventions
- Format with `stylua`. Prefer 2-space indent if unset.
- Locals/functions: `snake_case`. Types/metatables: `PascalCase`.
- Explicit `require` in `lua/` files; avoid globals.
- One plugin per `lua/plugins/<name>.lua`, return a table.

## Testing Guidelines
- Framework: `luaunit`, run via `lua tests/* -v`.
- Naming: Prefix tests with `Test*` (`TestParseArgs`).
- Coverage: Add tests for new helpers in `feature.lua` and public APIs.

## Commit & Pull Request Guidelines
- Conventional commits via `committia.lua`: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `BREAKING CHANGE`.
- Scope: `feat(lsp): add goimports-reviser`.
- PRs: Describe motivation, link issues, show visuals if relevant, note dependency updates.

## Agent-Specific Instructions
- Don’t commit generated files (e.g., `lazy-lock.json`) unless intentionally updating plugin versions.
- Document new Vim variables (`g:conform_*`) in README.
- New formatters: update README list and ensure binaries are widely available.
