local lint = {
    'mfussenegger/nvim-lint',
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            go = { 'golangcilint' },
            python = { 'flake8' },
            lua = { 'luacheck' },
        }

        local group = vim.api.nvim_create_augroup('lint_init', {})
        vim.api.nvim_create_autocmd('BufWritePost', {
            group = group,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
    enabled = true,
}

return { lint }
