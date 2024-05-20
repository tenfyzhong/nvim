vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '*.iptables' },
    callback = function()
        vim.bo.filetype = 'iptables'
    end,
})
