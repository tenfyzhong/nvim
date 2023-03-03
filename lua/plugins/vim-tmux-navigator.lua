--[[
- @file vim-tmux-navigator.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:16:33
--]]
local tmux = {
    'christoomey/vim-tmux-navigator',
    config = function()
        vim.g.tmux_navigator_no_mappings = 1

        vim.keymap.set('n', '<c-h>', ':TmuxNavigateLeft<cr>',
            { remap = false, silent = true, desc = 'tmux-navigator: goto left window' })
        vim.keymap.set('n', '<c-j>', ':TmuxNavigateDown<cr>',
            { remap = false, silent = true, desc = 'tmux-navigator: goto below window' })
        vim.keymap.set('n', '<c-k>', ':TmuxNavigateUp<cr>',
            { remap = false, silent = true, desc = 'tmux-navigator: goto above window' })
        vim.keymap.set('n', '<c-l>', ':TmuxNavigateRight<cr>',
            { remap = false, silent = true, desc = 'tmux-navigator: goto right window' })
    end,
    event = 'VeryLazy',
}

return { tmux }
