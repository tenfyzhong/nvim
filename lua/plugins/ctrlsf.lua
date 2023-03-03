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

        vim.keymap.set('n', '<leader>sf', '<Plug>CtrlSFPrompt', { remap = true, desc = 'ctrlsf: Prompt search' })
        vim.keymap.set('n', '<leader>sb', '<Plug>CtrlSFCCwordPath<cr>',
            { remap = true, silent = true, desc = 'ctrlsf: search cword' })
        vim.keymap.set('n', '<leader>sn', '<Plug>CtrlSFCwordPath', { remap = true, desc = 'ctrlsf: search cword prompt' })
        vim.keymap.set('n', '<leader>sp', '<Plug>CtrlSFPwordPath',
            { remap = true, desc = 'ctrlsf: search full word prompt' })
        vim.keymap.set('n', '<leader>st', ':CtrlSFToggle<cr>', { remap = false, desc = 'ctrlsf: toggle ctrlsf window' })
        vim.keymap.set('v', '<leader>sf', '<Plug>CtrlSFVwordExec', { remap = true, desc = 'ctrlsf: search visual word' })
        vim.keymap.set('v', '<leader>sF', '<Plug>CtrlSFVwordPath',
            { remap = true, desc = 'ctrlsf: search visual word prompt' })
    end,
    event = 'VeryLazy',
}

return { ctrlsf }
