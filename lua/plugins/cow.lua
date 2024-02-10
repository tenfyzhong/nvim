--[[
- @file cow.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:16:41
--]]

local cow = {
    'tenfyzhong/cow.vim',
    config = function()
    end,
    keys = {
        { '<leader>ch', '<Plug>(cow-close-h)', desc = 'cow: close left window' },
        { '<leader>cj', '<Plug>(cow-close-j)', desc = 'cow: close below window' },
        { '<leader>ck', '<Plug>(cow-close-k)', desc = 'cow: close above window' },
        { '<leader>cl', '<Plug>(cow-close-l)', desc = 'cow: close right window' },
    }
}

return { cow }
