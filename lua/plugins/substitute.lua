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
    end,
    keys = {
        { "s",  "<cmd>lua require('substitute').operator()<cr>", mode = "n", noremap = true, desc = 'substitute: operator' },
        { "ss", "<cmd>lua require('substitute').line()<cr>",     mode = "n", noremap = true, desc = 'substitute: line' },
        { "S",  "<cmd>lua require('substitute').eol()<cr>",      mode = "n", noremap = true, desc = 'substitute: eol' },
        { "s",  "<cmd>lua require('substitute').visual()<cr>",   mode = "x", noremap = true, desc = 'substitute: visual' },
    },
}

return { substitute }
