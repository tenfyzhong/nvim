--[[
- @file xml.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:21:25
--]]

local xml = {
    'othree/xml.vim',
    ft = 'xml',
    config = function()
        vim.g.xml_syntax_folding = 1
    end,
    event = 'VeryLazy',
}

return { xml }
