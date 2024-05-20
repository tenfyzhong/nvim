vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'cpp' },
    callback = function()
        vim.opt_local.iskeyword:remove { '-' }
    end,
})
