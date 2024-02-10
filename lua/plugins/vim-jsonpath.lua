--[[
- @file vim-jsonpath.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:03:03
--]]

local jsonpath = {
    'mogelbrod/vim-jsonpath',
    ft = 'json',
    config = function()
    end,
    keys = {
        { '<leader>rp', ':call jsonpath#echo()<cr>', mode = 'n', ft = 'json', buffer = true, silent = true, remap = false },
        { '<leader>rg', ':call jsonpath#goto()<cr>', mode = 'n', ft = 'json', buffer = true, silent = true, remap = false },
    }
}

return { jsonpath }
