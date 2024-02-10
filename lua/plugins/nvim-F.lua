local f = {
    'tenfyzhong/nvim-F',
    config = function()
        require('f').setup({})
    end,
    cmd = { 'F' },
}

return { f }
