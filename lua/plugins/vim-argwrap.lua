--[[
- @file vim-argwrap.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 23:41:37
--]]

local argwrap = {
    'FooSoft/vim-argwrap',
    config = function()
        vim.g.argwrap_wrap_closing_brace = 0
        vim.keymap.set('n', '<leader>aw', ':ArgWrap<cr>', { remap = false, silent = true, desc = 'argwrap: argwrap' })
    end,
}

return { argwrap }
