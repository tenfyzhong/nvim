--[[
- @file lqa.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-05 22:38:01
--]]
local lqa = {
    'tenfyzhong/lqa.nvim',
    config = function()
        require('lqa').setup {
            keymap = {
                previous = '<leader>qk',
                next = '<leader>qj',
                close = '<leader>qc',
                open = '<leader>qo',
                quickfix_open = '<leader>qq',
                loclist_open = '<leader>ql',
            }
        }
    end,
    keys = {
        '<leader>qk',
        '<leader>qj',
        '<leader>qc',
        '<leader>qo',
        '<leader>qq',
        '<leader>ql',
    }
}

return { lqa }
