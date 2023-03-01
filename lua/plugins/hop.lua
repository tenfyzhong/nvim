--[[
- @file hop.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-07 23:59:35
--]]

local hop = {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        local hop = require('hop')
        hop.setup {
            keys = 'asdfghjklqwertyuiopzxcvbnm'
        }

        local directions = require('hop.hint').HintDirection
        local position = require('hop.hint').HintPosition
        vim.keymap.set('n', '<tab>f', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
        end, { remap = true, desc = 'hop: f char' })
        vim.keymap.set('n', '<tab>F', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
        end, { remap = true, desc = 'hop: F char' })
        vim.keymap.set('n', '<tab>t', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
        end, { remap = true, desc = 'hop: t char' })
        vim.keymap.set('n', '<tab>T', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
        end, { remap = true, desc = 'hop: T char' })

        vim.keymap.set('n', '<tab>w', function()
            hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
        end, { remap = true, desc = 'hop: w' })
        vim.keymap.set('n', '<tab>W', function()
            hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false, multi_windows = true })
        end, { remap = true, desc = 'hop: W' })
        vim.keymap.set('n', '<tab>b', function()
            hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
        end, { remap = true, desc = 'hop: b' })
        vim.keymap.set('n', '<tab>e', function()
            hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false,
                hint_position = position.END })
        end, { remap = true, desc = 'hop: e' })
        vim.keymap.set('n', '<tab>ge', function()
            hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false,
                hint_position = position.END })
        end, { remap = true, desc = 'hop: ge' })

        vim.keymap.set('n', '<tab>j', function()
            hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
        end, { remap = true, desc = 'hop: j' })
        vim.keymap.set('n', '<tab>k', function()
            hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
        end, { remap = true, desc = 'hop: k' })
        vim.keymap.set('n', '<tab>J', function()
            hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false, multi_windows = true })
        end, { remap = true, desc = 'hop: J' })
        vim.keymap.set('n', '<tab>K', function()
            hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false, multi_windows = true })
        end, { remap = true, desc = 'hop: K' })
    end
}

return { hop }
