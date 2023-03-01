--[[
- @file align.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-22 20:31:47
--]]

local align = {
    'Vonr/align.nvim',
    config = function()
        vim.keymap.set('x', 'ga', function() require 'align'.align_to_char(1, true) end,
            { remap = false, silent = true, desc = 'align to 1 char' }) -- Aligns to 1 character, looking left
        vim.keymap.set('x', 'gt', function() require 'align'.align_to_char(2, true, true) end,
            { remap = false, silent = true, desc = 'align to 2 char' }) -- Aligns to 2 characters, looking left and with previews
        vim.keymap.set('x', 'gw', function() require 'align'.align_to_string(false, true, true) end,
            { remap = false, silent = true, desc = 'align to word' }) -- Aligns to a string, looking left and with previews
        vim.keymap.set('x', 'ar', function() require 'align'.align_to_string(true, true, true) end,
            { remap = false, silent = true, desc = 'align to lua pattern' }) -- Aligns to a Lua pattern, looking left and with previews
    end,
}

return { align }
