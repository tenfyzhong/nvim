vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '*.bats' },
    callback = function()
        vim.bo.filetype = 'sh'
    end,
})
