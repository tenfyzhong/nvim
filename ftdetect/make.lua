vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'make' },
    callback = function()
        vim.bo.expandtab = false
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
    end,
})
