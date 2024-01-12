local gito = {
    'tenfyzhong/nvim-gito',
    event = 'VeryLazy',
    config = function()
        require('gito').setup({})
        vim.keymap.set('n', '<leader>gf', ':GitoOpenFile<cr>',
            { silent = true, remap = false, desc = 'Open current file in browser' })
    end
}

return { gito }
