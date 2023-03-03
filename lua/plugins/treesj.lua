--[[
- @file treesj.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-13 10:15:41
--]]

local treesj = {
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
    config = function()
        require('treesj').setup {
            -- [[ Use default keymaps
            --  (<space>m - toggle, <space>j - join, <space>s - split)
            -- ]]
            use_default_keymaps = false,
        }

        vim.keymap.set({ 'n' }, '<leader>aw', '<cmd>silent TSJToggle<cr>', { silent = true, remap = false })
    end,
}

return { treesj }
