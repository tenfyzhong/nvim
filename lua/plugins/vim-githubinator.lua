--[[
- @file vim-githubinator.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:12:29
--]]

local githubinator = {
    'tenfyzhong/vim-githubinator',
    config = function()
        vim.keymap.set({ 'n', 'x' }, '<leader>go', '<Plug>(githubinator-open)',
            { remap = true, desc = 'githubinator: open in browser' })
        vim.keymap.set({ 'n', 'x' }, '<leader>gy', '<Plug>(githubinator-copy)',
            { remap = true, desc = 'githubinator: copy to clipboard' })
    end,
}

return { githubinator }
