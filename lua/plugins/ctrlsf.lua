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

        vim.keymap.set('n', '<leader>sf', '<Plug>CtrlSFPrompt', { remap = true })
        vim.keymap.set('n', '<leader>sb', '<Plug>CtrlSFCCwordPath<cr>', { remap = true, silent = true })
        vim.keymap.set('n', '<leader>sn', '<Plug>CtrlSFCwordPath', { remap = true })
        vim.keymap.set('n', '<leader>sp', '<Plug>CtrlSFPwordPath', { remap = true })
        vim.keymap.set('n', '<leader>st', ':CtrlSFToggle<cr>', { remap = false })
        vim.keymap.set('v', '<leader>sf', '<Plug>CtrlSFVwordExec', { remap = true })
        vim.keymap.set('v', '<leader>sF', '<Plug>CtrlSFVwordPath', { remap = true })
    end,
    cmd = { 'CtrlSF', 'CtrlSFOpen', 'CtrlSFUpdate', 'CtrlSFClose', 'CtrlSFClearHL', 'CtrlSFStop', 'CtrlSFToggle',
        'CtrlSFToggleMap', 'CtrlSFFocus' },
    keys = { '<leader>sf', '<leader>sb', '<leader>sn', '<leader>sp', '<leader>st', { 'v', '<leader>sf' },
        { 'v', '<leader>sF' } },
}

return { ctrlsf }
