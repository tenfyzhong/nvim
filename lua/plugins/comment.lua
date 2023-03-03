--[[
- @file Comment.nvim.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-03 11:03:07
--]]
local comment = {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup {
            ignore = '^$',
        }
    end
}

return { comment }
