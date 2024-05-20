vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'vim' },
    callback = function()
        vim.bo.foldmethod = 'marker'
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
    end,
})
