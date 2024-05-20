vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'java' },
    callback = function()
        vim.bo.expandtab = false
    end,
})
