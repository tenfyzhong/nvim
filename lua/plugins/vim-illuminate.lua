--[[
- @file vim-illuminate.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 23:37:01
--]]

local illuminate = {
    'tenfyzhong/vim-illuminate',
    config = function()
        vim.cmd([[
hi illuminatedWord  ctermbg=236
        ]])
    end,
}

return { illuminate }
