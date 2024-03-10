--[[
- @file ftemplate.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:25:33
--]]
local ftemplate = {
    'tenfyzhong/ftemplate.vim',
    config = function()
        vim.g.ftemplate_ignore_ft = { 'go' }
    end,
}

return { ftemplate }
