--[[
- @file coverage-highlight.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 13:30:30
--]]
local highlight = {
    'mgedmin/coverage-highlight.vim',
    config = function()
    end,
    cmd = { 'HighlightCoverage' },
    keys = {
        { '<leader>rc', ':HighlightCoverage', mode = { 'n' }, ft = 'python', silent = true, buffer = true, remap = false },

    },
}

return { highlight }
