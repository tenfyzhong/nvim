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

        vim.keymap.set('n', '<leader>dg', '<Plug>GetDiffCharPair', { remap = true })
        vim.keymap.set('n', '<leader>dp', '<Plug>PutDiffCharPair', { remap = true })
    end,
}

return { diffchar }
