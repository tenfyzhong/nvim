--[[
- @file iswap.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-15 10:18:33
--]]

local iswap = {
    'mizlan/iswap.nvim',
    config = function()
        require('iswap').setup {
            -- The keys that will be used as a selection, in order
            -- ('asdfghjklqwertyuiopzxcvbnm' by default)
            keys = 'asdfghjkl',

            -- Grey out the rest of the text when making a selection
            -- (enabled by default)
            -- grey = 'disable',

            -- Highlight group for the sniping value (asdf etc.)
            -- default 'Search'
            -- hl_snipe = 'ErrorMsg',

            -- Highlight group for the visual selection of terms
            -- default 'Visual'
            -- hl_selection = 'WarningMsg',

            -- Highlight group for the greyed background
            -- default 'Comment'
            -- hl_grey = 'LineNr',

            -- Post-operation flashing highlight style,
            -- either 'simultaneous' or 'sequential', or false to disable
            -- default 'sequential'
            flash_style = 'simultaneous',

            -- Highlight group for flashing highlight afterward
            -- default 'IncSearch'
            hl_flash = 'ModeMsg',

            -- Move cursor to the other element in ISwap*With commands
            -- default false
            move_cursor = true,

            -- Automatically swap with only two arguments
            -- default nil
            autoswap = false,

            -- Other default options you probably should not change:
            debug = nil,
            hl_grey_priority = '1000',
        }

        vim.keymap.set('n', 'g>', '<cmd>silent ISwapNodeWithRight<cr>', { remap = false, silent = true })
        vim.keymap.set('n', 'g<', '<cmd>silent ISwapNodeWithLeft<cr>', { remap = false, silent = true })
    end,
    event = 'VeryLazy',
}

return { iswap }
