local mason = {
    "williamboman/mason.nvim",
    build = function()
        vim.cmd("MasonUpdate")

        local pkg = {
            -- do not install golangci-lint, it will generate
            -- an error "Running error: context loading failed: no go files to
            -- analyze" always
            -- 'golangci-lint',
            "ast-grep",
            "autotools-language-server",
            "bash-language-server",
            "fish-lsp",
            "gofumpt",
            "goimports",
            "golines",
            "gopls",
            "gotests",
            "iferr",
            "impl",
            "json-lsp",
            "json-to-struct",
            "lua-language-server",
            "luacheck",
            "luaformatter",
            "markdownlint-cli2",
            "protols",
            "python-lsp-server",
            "rust-analyzer",
            "shfmt",
            "sqlfmt",
            "sqlls",
            "stylua",
            "thriftls",
            "typescript-language-server",
            "vim-language-server",
            "yaml-language-server",
        }
        local str = table.concat(pkg, " ")
        vim.cmd("MasonInstall " .. str)
    end,
    opts = {},
}

return { mason }
