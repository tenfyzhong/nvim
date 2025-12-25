# Neovim Config Agent Guidelines

## Build/Test Commands
- Run all tests: `make test` or `cd lua && lua tests/* -v`
- Run single test: `cd lua && lua tests/<suite>.lua -v <TestName>` (e.g., `lua tests/feature_test_suite.lua -v TestParseArgs`)
- Formatting: `stylua` (Lua), `markdownlint-cli2` (Markdown)

## Coding Style
- Format with `stylua`; 2-space indent
- Locals/functions: `snake_case`; types/metatables: `PascalCase`
- Explicit `require`; avoid globals
- One plugin per `lua/plugins/<name>.lua`, return table spec

## Testing
- Framework: `luaunit`; test prefix: `Test*`
- Add tests for `feature.lua` helpers and public APIs

## Agent Rules
- Don’t commit generated files (e.g., `lazy-lock.json`)
- Document new Vim vars (`g:conform_*`) in README
