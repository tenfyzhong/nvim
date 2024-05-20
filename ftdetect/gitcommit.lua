vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    callback = function()
        vim.bo.textwidth = 79
        vim.bo.cindent = false
    end,
})
