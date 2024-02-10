--[[
- @file hop.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-07 23:59:35
--]]

local hop = {
    'smoka7/hop.nvim',
    version = '*', -- optional but strongly recommended
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        local hop = require('hop')
        hop.setup {
            keys = 'asdfghjklqwertyuiopzxcvbnm'
        }
    end,
    keys = {
        {
            '<tab>f',
            function()
                require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
            end,
            remap = true,
            desc = 'hop: f char',
        },
        {
            '<tab>F',
            function()
                require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
            end,
            remap = true,
            desc = 'hop: F char',
        },
        {
            '<tab>t',
            function()
                require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
            end,
            remap = true,
            desc = 'hop: t char',
        },
        {
            '<tab>T',
            function()
                require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
            end,
            remap = true,
            desc = 'hop: T char',
        },

        {
            '<tab>w',
            function()
                require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
            end,
            remap = true,
            desc = 'hop: w',
        },
        {
            '<tab>W',
            function()
                require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false, multi_windows = true })
            end,
            remap = true,
            desc = 'hop: W',
        },
        {
            '<tab>b',
            function()
                require('hop').hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
            end,
            remap = true,
            desc = 'hop: b',
        },
        {
            '<tab>e',
            function()
                require('hop').hint_words({
                    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                    current_line_only = false,
                    hint_position = require('hop.hint').HintPosition.END
                })
            end,
            remap = true,
            desc = 'hop: e',
        },
        {
            '<tab>ge',
            function()
                require('hop').hint_words({
                    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                    current_line_only = false,
                    hint_position = require('hop.hint').HintPosition.END
                })
            end,
            remap = true,
            desc = 'hop: ge',
        },

        {
            '<tab>j',
            function()
                require('hop').hint_lines({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
            end,
            remap = true,
            desc = 'hop: j',
        },
        {
            '<tab>k',
            function()
                require('hop').hint_lines({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
            end,
            remap = true,
            desc = 'hop: k',
        },
        {
            '<tab>J',
            function()
                require('hop').hint_lines({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false, multi_windows = true })
            end,
            remap = true,
            desc = 'hop: J',
        },
        {
            '<tab>K',
            function()
                require('hop').hint_lines({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false, multi_windows = true })
            end,
            remap = true,
            desc = 'hop: K',
        },
    },
}

return { hop }
