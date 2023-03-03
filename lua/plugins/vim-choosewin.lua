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
        vim.keymap.set('n', '<leader>sw', '<Plug>(choosewin)', { remap = true, desc = 'choosewin: choosewin' })
    end,
    event = 'VeryLazy',
}

return { choosewin }
