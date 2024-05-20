vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'typescript' },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
    end,
})
