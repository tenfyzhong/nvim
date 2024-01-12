local f = {
    'tenfyzhong/nvim-F',
    event = 'VeryLazy',
    config = function()
        require('f').setup({})
    end
}

return { f }
