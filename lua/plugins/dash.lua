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
    end,
    keys = {
        { '<leader>ds', '<Plug>DashSearch', silent = true, remap = true, desc = 'dash: search cword' },
    },
    cmd = { 'Dash', 'DashKeywords' },
}

return { dash }
