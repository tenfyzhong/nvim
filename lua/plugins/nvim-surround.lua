--[[
- @file vim-surround.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:24:04
--]]

local surround = {
    'kylechui/nvim-surround',
    config = function()
        require("nvim-surround").setup({})
    end,
    event = 'VeryLazy',
}
return { surround }
