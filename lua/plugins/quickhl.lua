--[[
- @file quickhl.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 19:49:01
--]]

local quickhl = {
    't9md/vim-quickhl',
    config = function()
        vim.keymap.set({ 'n' }, '<leader>m', '<Plug>(quickhl-manual-this-whole-word)',
            { remap = true, silent = true, desc = 'quickhl: highlight this whole word' })
        vim.keymap.set({ 'x' }, '<leader>m', '<Plug>(quickhl-manual-this)',
            { remap = true, silent = true, desc = 'quickhl: highlight this' })
        vim.keymap.set({ 'n' }, '<tab>m', '<Plug>(quickhl-manual-reset)',
            { remap = true, silent = true, desc = 'quickhl: reset highlight' })
        vim.g.quickhl_manual_colors = {
            'ctermfg=17  ctermbg=112 cterm=none guifg=#001767 guibg=#8fd757 gui=none',
            'ctermfg=52  ctermbg=221 cterm=none guifg=#570000 guibg=#fcd757 gui=none',
            'ctermfg=225 ctermbg=90  cterm=none guifg=#ffdff7 guibg=#8f2f8f gui=none',
            'ctermfg=195 ctermbg=68  cterm=none guifg=#dffcfc guibg=#5783c7 gui=none',
            'ctermfg=19  ctermbg=189 cterm=bold guifg=#0000af guibg=#d7d7fc gui=bold',
            'ctermfg=89  ctermbg=225 cterm=bold guifg=#87005f guibg=#fcd7fc gui=bold',
            'ctermfg=52  ctermbg=180 cterm=bold guifg=#570000 guibg=#dfb787 gui=bold',
            'ctermfg=223 ctermbg=130 cterm=bold guifg=#fcd7a7 guibg=#af5f17 gui=bold',
            'ctermfg=230 ctermbg=242 cterm=bold guifg=#f7f7d7 guibg=#676767 gui=bold',
            'ctermfg=22  ctermbg=194 cterm=bold guifg=#004f00 guibg=#d7f7df gui=bold',
        }
    end,
    event = 'VeryLazy',
}

return { quickhl }
