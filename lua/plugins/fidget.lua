--[[
- @file fidget.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-07 21:38:09
--]]

local fidget = {
    'j-hui/fidget.nvim',
    config = function()
        require "fidget".setup {}
    end,
}

return { fidget }
