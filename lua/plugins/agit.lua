--[[
- @file agit.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:54:54
--]]

local agit = {
    'cohama/agit.vim',
    config = function()
        local group = vim.api.nvim_create_augroup('agit_init', {})
    end,
    keys = {
        { 'C',  '<Plug>(agit-git-cherry-pick)', mode = { 'n' }, ft = { 'agit', 'agit_stat', 'agit_diff' }, buffer = true, desc = 'agit: git cherry-pick' },
        { 'co', '<Plug>(agit-git-checkout)',    mode = { 'n' }, ft = { 'agit', 'agit_stat', 'agit_diff' }, buffer = true, desc = 'agit: git checkout' },
    },
}

return { agit }
