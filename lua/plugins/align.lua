local align = {
    'Vonr/align.nvim',
    branch = "v2",
    config = function()
    end,
    keys = {
        -- Aligns to 1 character, looking left
        { 'ga', function() require('align').align_to_char({ length = 1, preview = true }) end,     mode = 'x', remap = false, silent = true, desc = 'align to 1 char' },
        -- Aligns to 2 characters, looking left and with previews
        { 'gt', function() require 'align'.align_to_char({ length = 2, preview = true }) end,      mode = 'x', remap = false, silent = true, desc = 'align to 2 char' },
        -- Aligns to a string, looking left and with previews
        { 'gw', function() require 'align'.align_to_string({ regex = false, preview = true }) end, mode = 'x', remap = false, silent = true, desc = 'align to word' },
        -- Aligns to a Lua pattern, looking left and with previews
        { 'ar', function() require 'align'.align_to_string({ regex = true, preview = true }) end,  mode = 'x', remap = false, silent = true, desc = 'align to lua pattern' },
    }
}

return { align }
