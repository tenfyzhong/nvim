--[[
- @file committia.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 19:12:03
--]]

local committia = {
    'rhysd/committia.vim',
    config = function()
        vim.cmd([[
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal nonu
    setlocal nornu
    augroup edit_open_init
        autocmd InsertEnter * set nonumber norelativenumber
        autocmd InsertLeave * set nonumber norelativenumber 
    augroup END

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

function! g:committia_hooks.status_open(info)
    setlocal nonu
    setlocal nornu
    augroup edit_open_init
        autocmd InsertEnter * set nonumber norelativenumber
        autocmd InsertLeave * set nonumber norelativenumber 
    augroup END

endfunction

        ]])
    end,
}

return { committia }
