--[[
- @file vim-easy-align.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 19:19:35
--]]

local align = {
    'junegunn/vim-easy-align',
    config = function()
        vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)', { remap = true, desc = 'easy-align: align' })
    end,
}

return { align }
