--[[
- @file rainbow.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:40:56
--]]

local rainbow = {
    'luochen1990/rainbow',
    config = function()
        vim.g.rainbow_active = 1
    end,
    event = 'VeryLazy',
}

return { rainbow }
