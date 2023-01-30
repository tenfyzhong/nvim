--[[
- @file vim-commentary.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 12:31:01
--]]
local commentary = {
    'tpope/vim-commentary',
    cmd = 'Commentary',
    keys = { 'gc', 'gcc', { 'v', 'gc' }, { 'o', 'gc' }, 'gcgc', 'gcu' },
}

return { commentary }
