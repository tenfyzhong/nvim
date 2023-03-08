--[[
- @file tmux.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:07:44
--]]

local tmux = {
    'aserowy/tmux.nvim',
    config = function()
        local tmux = require('tmux')
        tmux.setup {}
        vim.keymap.set('n', '<c-h>', function() require('tmux').move_left() end,
            { remap = false, silent = true, desc = 'tmux: goto left window' })
        vim.keymap.set('n', '<c-j>', function() require('tmux').move_bottom() end,
            { remap = false, silent = true, desc = 'tmux: goto below window' })
        vim.keymap.set('n', '<c-k>', function() require('tmux').move_top() end,
            { remap = false, silent = true, desc = 'tmux: goto above window' })
        vim.keymap.set('n', '<c-l>', function() require('tmux').move_right() end,
            { remap = false, silent = true, desc = 'tmux: goto right window' })
    end,
    event = 'VeryLazy',
}

return { tmux }
