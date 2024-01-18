--[[
- @file vim-markdown.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 18:37:40
--]]

local markdown = {
    'tpope/vim-markdown',
    config = function()
        vim.g.vim_markdown_folding_disabled = 1
    end,
    ft = { 'markdown' },
}

return { markdown }
