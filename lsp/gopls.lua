local function on_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

return {
    settings = {
        -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
        gopls = {
            analyses = {
                useany = true,
                unusedvariable = true,
                fieldalignment = false,
            },
            experimentalPostfixCompletions = true,
            gofumpt = true,
            staticcheck = false,
            usePlaceholders = true,
        },
    },

    on_attach = on_attach,
}
