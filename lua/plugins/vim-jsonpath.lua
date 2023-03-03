--[[
- @file vim-jsonpath.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:03:03
--]]

local jsonpath = {
    'mogelbrod/vim-jsonpath',
    ft = 'json',
    config = function()
        local group = vim.api.nvim_create_augroup('jsonpath_init', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'json',
            callback = function()
                vim.keymap.set('n', '<leader>rp', ':call jsonpath#echo()<cr>',
                    { buffer = true, silent = true, remap = false })
                vim.keymap.set('n', '<leader>rg', ':call jsonpath#goto()<cr>',
                    { buffer = true, silent = true, remap = false })
            end,
        })
    end,
}

return { jsonpath }
