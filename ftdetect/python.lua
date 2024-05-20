vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'python' },
    callback = function()
        vim.bo.textwidth = 79
    end,
})
