vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'markdown' },
    callback = function()
        vim.bo.textwidth = 0
        vim.bo.wrap = true
    end,
})
