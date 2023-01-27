--[[
- @file vim-easymotion.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:49:07
--]]
local easymotion = {
    'easymotion/vim-easymotion',
    config = function()
        vim.g.EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'
        vim.g.EasyMotion_smartcase = 1
        vim.g.EasyMotion_startofline = 0
        vim.g.EasyMotion_verbose = 0

        vim.keymap.set('n', '<tab>J', '<Plug>(easymotion-sol-j)', { remap = true })
        vim.keymap.set('n', '<tab>K', '<Plug>(easymotion-sol-k)', { remap = true })
        vim.keymap.set('n', '<tab>;', '<Plug>(easymotion-next)', { remap = true })
        vim.keymap.set('n', '<tab>,', '<Plug>(easymotion-prev)', { remap = true })
        vim.keymap.set('n', '<tab>.', '<Plug>(easymotion-repeat)', { remap = true })

        vim.keymap.set('n', '<tab>F', '<Plug>(easymotion-overwin-f)', { remap = true })
        vim.keymap.set('n', '<tab>L', '<Plug>(easymotion-overwin-line)', { remap = true })
        vim.keymap.set('n', '<tab>W', '<Plug>(easymotion-overwin-w)', { remap = true })

        vim.cmd([[
hi EasyMotionTarget2First ctermbg=none ctermfg=DarkBlue
hi EasyMotionTarget2Second ctermbg=none ctermfg=DarkBlue
        ]])
    end,
}

return { easymotion }
