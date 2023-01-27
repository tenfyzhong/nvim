--[[
- @file bullets.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 23:25:18
--]]

local bullets = {
    'dkarter/bullets.vim',
    config = function()
        vim.cmd([[
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \]

let g:bullets_checkbox_markers = ' x'
let g:bullets_renumber_on_change = 0
            ]])
    end,
}

return { bullets }
