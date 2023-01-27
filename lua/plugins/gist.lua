--[[
- @file gist.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:56:39
--]]

local gist = {
    'mattn/gist-vim',
    requires = 'mattn/webapi-vim',
    config = function()
        vim.g.gist_show_privates = 1
        vim.g.gist_get_multiplefile = 1
        vim.g.gist_clip_command = 'pbcopy'
    end,
}

return { gist }
