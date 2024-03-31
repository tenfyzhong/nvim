--[[
- @file Comment.nvim.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-03 11:03:07
--]]
local comment = {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup {
            ignore = '^$',
        }
    end,
    keys = {
        { 'gb',  mode = { 'v' } },
        { 'gc',  mode = { 'v' } },
        { 'gbc', mode = { 'n', 'v' } },
        { 'gcc', mode = { 'n', 'v' } },
        { 'gco', mode = { 'n' } },
        { 'gcO', mode = { 'n' } },
        { 'gcA', mode = { 'n' } },
    },
}

return { comment }
