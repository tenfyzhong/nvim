--[[
- @file dash.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:54:20
--]]
local dash = {
    'rizzatti/dash.vim',
    config = function()
        vim.keymap.set('n', '<leader>ds', '<Plug>DashSearch',
            { silent = true, remap = true, desc = 'dash: search cword' })
    end,
    event = 'VeryLazy',
}

return { dash }
