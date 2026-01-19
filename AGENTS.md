# Neovim Config Agent Guidelines

This file contains instructions for AI agents (Claude, Gemini, etc.) working on this Neovim configuration repository. Follow these guidelines strictly to maintain code quality and consistency.

## 1. Environment & Build

### System Context

- **Shell:** Fish shell (assume `fish` syntax for complex shell commands if strictly necessary, but standard POSIX/Bash is safer for general agent operations unless specified).
- **Platform:** MacOS (Darwin) is the primary host.
- **Tools:** Standard GNU coreutils are expected.

### Test Commands

The repository uses a custom Lua-based testing setup with `luaunit`.

- **Run all tests:**

  ```bash
  make test
  # OR manually:
  cd lua && lua tests/* -v
  ```

- **Run a single test suite:**

  ```bash
  cd lua && lua tests/feature_test_suite.lua -v
  ```

- **Run a specific test case:**
  Use the `-v <TestName>` pattern.

  ```bash
  cd lua && lua tests/feature_test_suite.lua -v TestParseArgs
  ```

  *Note:* Always run tests from the `lua/` directory to ensure relative paths resolve correctly.

### Formatting & Linting

- **Lua:** `stylua` is the authoritative formatter.

  ```bash
  stylua --indent-type Spaces .
  ```

- **Markdown:** `markdownlint-cli2`.

  ```bash
  markdownlint-cli2 "**/*.md"
  ```

- **Shell:** `shfmt` (indent 4, binary ops at start of line).

## 2. Project Architecture

The configuration follows a modular structure centered around `lazy.nvim`.

### Core Layout

- **`init.lua`**: Entry point. Loads modules in strict order (opt -> g -> abbreviate -> ... -> plugin).
- **`lua/plugins/*.lua`**: Plugin specifications. Each file should return a **single** `lazy.nvim` spec table.
- **`lua/feature.lua`**: Core utility library. **All** reusable logic goes here, not in global scope.
- **`lua/tests/`**: Unit tests mirroring the logic in `lua/`.
- **`lsp/`**: Language server specific configs (e.g., `gopls.lua`, `lua_ls.lua`).

### Key Files

- `lua/plugin.lua`: The `lazy.nvim` bootstrap and setup file.
- `lua/dev/`: Directory for local development plugins (ignored by git).
- `.vimrc.local`: Per-project local overrides (user-specific, not committed).

## 3. Coding Standards

### Lua Style

- **Indentation:** 2 spaces. No tabs.
- **Naming:**
  - `snake_case` for local variables and functions.
  - `PascalCase` for custom types or metatables.
  - `UPPER_CASE` for constants.
- **Scoping:**
  - **ALWAYS** use `local`. Avoid global variables (`_G` or `g:`) unless absolutely necessary for Vim interoperability.
  - Use `M = {} ... return M` pattern for modules.
- **Imports:** Explicitly `require` dependencies at the top of the file.

### Plugin Configuration Pattern

When adding or modifying plugins in `lua/plugins/`:

```lua
return {
  "author/plugin-name",
  event = "VeryLazy", -- Prefer lazy loading
  opts = {
    -- Options here (preferred over config function if possible)
  },
  config = function(_, opts)
    require("plugin").setup(opts)
    -- Custom logic here
  end,
}
```

### Error Handling

- Use `pcall` for risky operations (like file I/O or external commands).
- Fail gracefully if a binary is missing (e.g., check `fn.executable(1, "cmd")` before using).

## 4. Testing Guidelines

- **Framework:** `luaunit` (embedded or assumed available in test env).
- **Location:** `lua/tests/`.
- **Naming:** Test functions must start with `Test` (e.g., `TestGetRelativePath`).
- **Requirements:**
  - Write tests for **any** new utility function in `feature.lua`.
  - Tests must be re-runnable and deterministic.
  - Do not write one-off testing scripts; integrate them into the suite.

## 5. Agent Workflow Rules

1. **Safety First:**
    - NEVER commit generated files like `lazy-lock.json`.
    - NEVER modify `.gitignore` unless explicitly instructed.
    - NEVER output secrets or API keys.

2. **Documentation:**
    - If you add a new global variable (e.g., `g:conform_args_*`), you **MUST** document it in `CLAUDE.md` and/or `README.md`.
    - Update `AGENTS.md` (this file) if you change build/test procedures.

3. **Git Protocol:**
    - Sign-off commits if requested (`git commit -s`).
    - Use conventional commit messages (e.g., `feat: add new plugin`, `fix: logic error in feature.lua`).

4. **Verification:**
    - **Always** run `make test` before declaring a task complete.
    - **Always** run `stylua --indent-type Spaces .` to ensure formatting compliance.

## 6. Common Operations

### Adding a New Plugin

1. Create `lua/plugins/<name>.lua`.
2. Define the `lazy.nvim` spec.
3. (Optional) If it relies on external tools (npm, pip, go), document them in `CLAUDE.md`.

### Modifying Core Logic

1. Check `lua/feature.lua`.
2. If the logic is reusable, add it there.
3. Add a corresponding test in `lua/tests/feature_test_suite.lua`.
4. Run tests.

### Troubleshooting

- **"Module not found":** Ensure you are running lua commands from the `lua/` subdirectory when testing manually.
- **"Global not defined":** You probably forgot to `require` a module or used a vim global that isn't mocked in the test environment.

## 7. External Tool Dependencies

Ensure these are considered when writing code that calls external processes:

- `fzf`, `rg` (ripgrep), `fd`.
- `node`, `go`, `python3`.
- `stylua`, `markdownlint`.
