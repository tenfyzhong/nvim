--[[
- @file conflict-marker.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 23:44:49
--]]
local marker = {
    'tenfyzhong/conflict-marker.vim',
    config = function()
        vim.g.conflict_marker_enable_hooks = 1
        vim.g.conflict_marker_enable_mappings = 1
        vim.g.conflict_marker_enable_highlight = 1
    end,
}

return {marker}
