vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    callback = function()
        vim.bo.cindent = false
    end,
})
