-- Better commit message editing workflow.

local committia = {
    "rhysd/committia.vim",
    config = function()
        vim.cmd([[
let g:committia_status_window_min_height = 20
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

    let l:old_a = getreg('a')
    let comment =<< END
################## Conventional Commits Standard ##################
# type: fix/feat/build/chroe/ci/docs/style/refactor/perf/test/BREAK
###################################################################
END
    call setreg('a', comment)
    set modifiable
    normal! gg"aP
    set nomodifiable
    normal! gg
    call setreg('a', l:old_a)

    let lines = line('$')
    let max_height = g:committia_status_window_min_height != 0 ? g:committia_status_window_min_height : 20
    let height = lines > max_height ? max_height : lines
    execute 'resize ' . height

endfunction

        ]])
    end,
    ft = "gitcommit",
}

return { committia }
