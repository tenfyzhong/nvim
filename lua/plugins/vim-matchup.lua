--[[
- @file vim-matchup.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 08:31:55
--]]

local matchup = {
    'andymass/vim-matchup',
    setup = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
}

return { matchup }
