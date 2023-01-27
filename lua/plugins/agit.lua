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
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = { 'agit,agit_stat,agit_diff' },
            callback = function()
                vim.keymap.set({ 'n' }, 'C', '<Plug>(agit-git-cherry-pick)', { buffer = true })
                vim.keymap.set({ 'n' }, 'co', '<Plug>(agit-git-checkout)', { buffer = true })
            end,
        })
    end,
}

return { agit }
