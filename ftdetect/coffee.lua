vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'coffee' },
    callback = function()
        vim.bo.foldmethod = 'indent'
    end,
})
