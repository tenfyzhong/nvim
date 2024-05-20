vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { 'Cargo.toml' },
    callback = function()
        vim.bo.filetype = 'cargo.toml'
    end,
})
