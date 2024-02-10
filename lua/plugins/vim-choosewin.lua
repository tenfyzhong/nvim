--[[
- @file vim-choosewin.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:48:24
--]]

local choosewin = {
    't9md/vim-choosewin',
    config = function()
    end,
    cmd = { 'ChooseWin', 'ChooseWinSwap', 'ChooseWinSwapStay' },
    keys = {
        { '<leader>sw', '<Plug>(choosewin)', mode = 'n', remap = true, desc = 'choosewin: choosewin' },
    },
}

return { choosewin }
