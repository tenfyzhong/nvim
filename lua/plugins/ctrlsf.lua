--[[
- @file ctrlsf.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:53:48
--]]

local ctrlsf = {
    'dyng/ctrlsf.vim',
    config = function()
        vim.g.ctrlsf_auto_close = 1
        vim.g.ctrlsf_confirm_save = 0
        vim.g.ctrlsf_default_root = 'project'
        vim.g.ctrlsf_indent = 2
        vim.g.ctrlsf_regex_pattern = 1
    end,
    cmd = { 'CtrlSF', 'CtrlSFOpen', 'CtrlSFUpdate', 'CtrlSFClose', 'CtrlSFClearHL', 'CtrlSFStop', 'CtrlSFToggle', 'CtrlSFToggleMap', 'CtrlSFFocus' },
    keys = {
        { '<leader>sf', '<Plug>CtrlSFPrompt',         mode = 'n', remap = true,  desc = 'ctrlsf: Prompt search' },
        { '<leader>sb', '<Plug>CtrlSFCCwordPath<cr>', mode = 'n', remap = true,  desc = 'ctrlsf: Search cword' },
        { '<leader>sn', '<Plug>CtrlSFCwordPath',      mode = 'n', remap = true,  desc = 'ctrlsf: Search cword prompt' },
        { '<leader>sp', '<Plug>CtrlSFPwordPath',      mode = 'n', remap = true,  desc = 'ctrlsf: Search full word prompt' },
        { '<leader>st', ':CtrlSFToggle<cr>',          mode = 'n', remap = false, desc = 'ctrlsf: Toggle ctrlsf window' },
        { '<leader>sf', '<Plug>CtrlSFVwordExec',      mode = 'v', remap = true,  desc = 'ctrlsf: Search visual word' },
        { '<leader>sF', '<Plug>CtrlSFVwordPath',      mode = 'v', remap = true,  desc = 'ctrlsf: Search visual word prompt' },
    },
}

return { ctrlsf }
