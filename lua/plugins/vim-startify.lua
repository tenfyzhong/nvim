--[[
- @file vim-startify.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 14:14:29
--]]

local startify = {
    'mhinz/vim-startify',
    config = function()
        vim.cmd([[
let g:startify_enable_special = 0
let g:startify_change_to_dir = 1

" let g:startify_bookmarks = [ {'c': '~/.vim'}, '~/.zshrc' ]
let g:startify_bookmarks = []

let g:startify_skiplist = [
            \ 'bundle/.*/doc',
            \ 'COMMIT_EDITMSG',
            \ ]

let g:startify_custom_header = 
            \['*---------------------------------------------------*',
            \ '| Open: b(buffer) s(split) v(vertical split) t(tab) |',
            \ '| Action: q(quit) e(empty buffer) i(insert) - tenfy |',
            \ '*---------------------------------------------------*',
            \ '       o                                             ',
            \ '        o   ^__^                                     ',
            \ '         o  (oo)\_______                             ',
            \ '            (__)\       )\/\                         ',
            \ '                ||----w |                            ',
            \ '                ||     ||                            ',
            \ ]
        ]])
    end
}

return { startify }
