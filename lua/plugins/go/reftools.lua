--[[
- @file reftools.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 12:10:01
--]]

local reftools = {
    'tenfyzhong/reftools.vim',
    config = function()
        local group = vim.api.nvim_create_augroup('reftools_local', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'go',
            callback = function()
                vim.keymap.set('n', '<leader>rtp', '<Plug>(reftools#fixplurals)',
                    { silent = true, buffer = true, remap = true })
                vim.keymap.set('n', '<leader>rts', '<Plug>(reftools#fixstruct)',
                    { silent = true, buffer = true, remap = true })
                vim.keymap.set('n', '<leader>rtw', '<Plug>(reftools#fixswitch)',
                    { silent = true, buffer = true, remap = true })
            end,
        })
    end,
    ft = 'go',
}

return { reftools }
