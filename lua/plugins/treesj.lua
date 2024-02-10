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
    end,
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    keys = {
        { '<leader>aw', '<cmd>silent TSJToggle<cr>', mode = 'n', silent = true, remap = false },
    },
}

return { treesj }
