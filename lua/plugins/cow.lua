--[[
- @file cow.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:16:41
--]]

local cow = {
    'tenfyzhong/cow.vim',
    config = function()
        vim.keymap.set('n', '<leader>ch', '<Plug>(cow-close-h)')
        vim.keymap.set('n', '<leader>cj', '<Plug>(cow-close-j)')
        vim.keymap.set('n', '<leader>ck', '<Plug>(cow-close-k)')
        vim.keymap.set('n', '<leader>cl', '<Plug>(cow-close-l)')
    end,
    keys = { '<leader>ch', '<leader>cj', '<leader>ck', '<leader>cl' },
}

return { cow }
