local gito = {
    'tenfyzhong/nvim-gito',
    config = function()
        require('gito').setup({})
    end,
    cmd = { 'GitoOpen', 'GitoCopy', 'GitoOpenFile', 'GitoCopyFile' },
    keys = {
        { '<leader>gf', ':GitoOpenFile<cr>', mode = 'n', silent = true, remap = false, desc = 'Open current file in browser' },
    },
}

return { gito }
