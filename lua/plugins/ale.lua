--[[
- @file ale.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 23:01:02
--]]

-- Plug 'w0rp/ale'

-- let g:ale_linters = {
--             \ 'go': ['golangci-lint'],
--             \ 'c': ['gcc'],
--             \}

-- " 关闭pymode的检查
-- let g:pymode_lint = 0
-- let g:ale_set_quickfix = 0
-- let g:ale_echo_cursor = 0

-- nmap <silent><leader>al <Plug>(ale_lint)
-- nmap <silent><leader>ad <Plug>(ale_detail)
-- nmap <silent><leader>at <Plug>(ale_toggle)
-- nmap <silent><leader>aj <Plug>(ale_next_wrap)
-- nmap <silent><leader>ak <Plug>(ale_previous_wrap)

local ale = {
    'dense-analysis/ale',
    config = function()
        vim.cmd([[
let g:ale_cpp_gcc_options = '-std=c++11 -Wall'
let g:ale_c_gcc_options = '-I. -I.. -I./include -I../include -Wall'
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '-c ~/.golangci.yml'
let g:ale_thrift_thrift_generators = ['go']

let g:ale_linters = {
            \ 'go': ['golangci-lint'],
            \ 'c': ['gcc'],
            \}

let g:pymode_lint = 0
let g:ale_set_quickfix = 0
let g:ale_echo_cursor = 0

nmap <silent><leader>al <Plug>(ale_lint)
nmap <silent><leader>ad <Plug>(ale_detail)
nmap <silent><leader>at <Plug>(ale_toggle)
nmap <silent><leader>aj <Plug>(ale_next_wrap)
nmap <silent><leader>ak <Plug>(ale_previous_wrap)
            ]])
    end,
}

return { ale }
