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
        { "s",  function() require('substitute').operator() end, mode = "n", noremap = true, desc = 'substitute: operator' },
        { "ss", function() require('substitute').line() end,     mode = "n", noremap = true, desc = 'substitute: line' },
        { "S",  function() require('substitute').eol() end,      mode = "n", noremap = true, desc = 'substitute: eol' },
        { "s",  function() require('substitute').visual() end,   mode = "x", noremap = true, desc = 'substitute: visual' },
    },
}

return { substitute }
