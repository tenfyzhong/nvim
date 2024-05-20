vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'c' },
    callback = function()
        vim.opt_local.iskeyword:remove { '-' }
    end,
})
