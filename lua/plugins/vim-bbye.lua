--[[
- @file vim-bbye.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 12:31:39
--]]

local bbye = {
    'moll/vim-bbye',
    config = function()
        vim.keymap.set('n', '<leader>bd', function()
            vim.cmd('Bdelete')
        end, { silent = true, remap = false, desc = 'bbye: buffer delete' })
    end,
    event = 'VeryLazy',
}

return { bbye }
