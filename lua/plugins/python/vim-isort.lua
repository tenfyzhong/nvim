--[[
- @file vim-isort.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 14:03:32
--]]

local isort = {
    'fisadev/vim-isort',
    run = function()
        vim.cmd('system("pip install isort")')
    end,
    config = function()
        vim.g.vim_isort_map = ''
        local group = vim.api.nvim_create_augroup('isort_init', {})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = group,
            pattern = '*.py',
            command = 'Isort',
        })
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'python',
            callback = function()
                vim.keymap.set('n', '<leader>is', function() vim.cmd('Isort') end,
                    { silent = true, buffer = true, remap = false })
            end,
        })
    end,
}

return { isort }
