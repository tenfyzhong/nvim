vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '*.mmd', '*.mermaid' },
    callback = function()
        vim.bo.filetype = 'mermaid'
    end,
})
