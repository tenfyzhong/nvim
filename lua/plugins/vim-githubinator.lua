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
        vim.keymap.set({ 'n', 'x' }, '<leader>gho', '<Plug>(githubinator-open)', { remap = true })
        vim.keymap.set({ 'n', 'x' }, '<leader>ghc', '<Plug>(githubinator-copy)', { remap = true })
    end,
    cmd = { 'GHO', 'GHC' },
    keys = { { 'n', '<leader>gho' }, { 'x', '<leader>gho' }, { 'n', '<leader>ghc' }, { 'x', '<leader>ghc' } },
}

return { githubinator }
