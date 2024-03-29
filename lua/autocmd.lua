--[[
- @file autocmd.lua
- @brief global autocmd
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:05:25
--]]

local init_group = vim.api.nvim_create_augroup('global_initial', {})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = init_group,
    pattern = { '*vimrc', '*.vim' },
    callback = function() vim.cmd('source %') end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
    group = init_group,
    pattern = '*',
    callback = function() vim.o.paste = false end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
    group = init_group,
    pattern = '*',
    callback = function()
        vim.o.number = true
        vim.o.relativenumber = false
    end
})

vim.api.nvim_create_autocmd('InsertLeave', {
    group = init_group,
    pattern = '*',
    callback = function()
        vim.o.number = true
        vim.o.relativenumber = true
    end
})

vim.api.nvim_create_autocmd('WinLeave', {
    group = init_group,
    pattern = '*',
    callback = function()
        vim.wo.cursorline = false
    end
})

vim.api.nvim_create_autocmd('WinEnter', {
    group = init_group,
    pattern = '*',
    callback = function()
        vim.wo.cursorline = true
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = init_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
    end
})

vim.api.nvim_create_autocmd('BufWritePre', {
    group = init_group,
    pattern = '*',
    callback = function()
        if vim.bo.filetype == 'go' or vim.bo.filetype == 'markdown' then
            return
        end
        vim.lsp.buf.format { async = false }
    end,
})
