vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'css' },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
        vim.opt_local.iskeyword:append { '-' }
    end,
})
