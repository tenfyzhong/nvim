vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '*.kdl' },
    callback = function()
        vim.bo.filetype = 'kdl'
    end,
})
