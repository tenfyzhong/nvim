--[[
- @file aerial.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:15:47
--]]
local aerial = {
    'stevearc/aerial.nvim',
    config = function()
        vim.keymap.set('n', '<leader>ft', ':call aerial#fzf()<cr>', { silent = true, remap = false })
    end,
}

return { aerial }
