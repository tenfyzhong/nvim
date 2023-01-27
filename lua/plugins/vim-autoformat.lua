--[[
- @file vim-autoformat.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:43:40
--]]

local autoformat = {
    'vim-autoformat/vim-autoformat',
    config = function()
        vim.g.formatdef_my_custom_cpp = '"clang-format -style=file"'
        vim.g.formatters_cpp = { 'my_custom_cpp' }
        vim.g.formatters_python = { 'yapf' }
        vim.g.formatdef_gofmt_2 = '"gofmt -s"'
        vim.g.run_all_formatters_go = 1

        local group = vim.api.nvim_create_augroup('autoformat_init', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'python',
            callback = function()
                vim.b.autoformat_autoindent = 0
                vim.b.autoformat_retab = 0
            end,
        })

        vim.keymap.set('n', '<leader>af', ':Autoformat<cr>', { remap = false })
    end,
}
