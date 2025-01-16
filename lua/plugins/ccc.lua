local ccc = {
    'uga-rosa/ccc.nvim',
    config = function()
        require('ccc').setup {}
    end,
    cmd = { 'CccPick', 'CccConvert', 'CccHighlighterEnable', 'CccHighlighterDisable', 'CccHighlighterToggle' }
}

return { ccc }
