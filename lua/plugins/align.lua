--[[
- @file align.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-22 20:31:47
--]]

local align = {
    'Vonr/align.nvim',
    branch = "v2",
    config = function()
    end,
    keys = {
        -- Aligns to 1 character, looking left
        { 'ga', function() require('align').align_to_char(1, true) end,            mode = 'x', remap = false, silent = true, desc = 'align to 1 char' },
        -- Aligns to 2 characters, looking left and with previews
        { 'gt', function() require 'align'.align_to_char(2, true, true) end,       mode = 'x', remap = false, silent = true, desc = 'align to 2 char' },
        -- Aligns to a string, looking left and with previews
        { 'gw', function() require 'align'.align_to_string(false, true, true) end, mode = 'x', remap = false, silent = true, desc = 'align to word' },
        -- Aligns to a Lua pattern, looking left and with previews
        { 'ar', function() require 'align'.align_to_string(true, true, true) end,  mode = 'x', remap = false, silent = true, desc = 'align to lua pattern' },
    }
}

return { align }
