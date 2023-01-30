--[[
- @file vim-conjoin.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:15:13
--]]
local conjoin = {
    'flwyd/vim-conjoin',
    cmd = 'Join',
    keys = { 'J', { 'v', 'J' }, 'gj', { 'v', 'gJ' } },
}

return { conjoin }
