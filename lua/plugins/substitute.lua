--[[
- @file substitute.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-03-01 11:16:48
--]]
local substitute = {
    'gbprod/substitute.nvim',
    config = function()
        require("substitute").setup {
            on_substitute = require("yanky.integration").substitute(),
        }
        -- Lua
        vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>",
            { noremap = true, desc = 'substitute: operator' })
        vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>",
            { noremap = true, desc = 'substitute: line' })
        vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>",
            { noremap = true, desc = 'substitute: eol' })
        vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>",
            { noremap = true, desc = 'substitute: visual' })
    end,
}

return { substitute }
