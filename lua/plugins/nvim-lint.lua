local lint = {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            python = { 'flake8' },
            lua = { 'luacheck' },
        }

        local group = vim.api.nvim_create_augroup('lint_init', {})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = group,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
    enabled = false,
}

return { lint }
