--[[
- @file diffchar.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:02:06
--]]

local diffchar = {
    'rickhowe/diffchar.vim',
    config = function()
        vim.g.DiffPairVisible = 0
    end,
    keys = {
        { '<leader>dg', '<Plug>GetDiffCharPair', remap = true },
        { '<leader>dp', '<Plug>PutDiffCharPair', remap = true },
    },
}

return { diffchar }
