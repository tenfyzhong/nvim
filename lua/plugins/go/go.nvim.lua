--[[
- @file go.nvim.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-01 00:12:36
--]]

local go = {
    'ray-x/go.nvim',
    config = function()
        require('go').setup()

        local group = vim.api.nvim_create_augroup('go_nvim_local', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'go',
            callback = function()
                vim.keymap.set('n', '<leader>r', '<NOP>', { buffer = true, remap = true })
                vim.keymap.set('n', '<leader>rd', ':GoDoc<cr>', { buffer = true, remap = true, silent = true })
                vim.keymap.set('n', '<leader>re', ':GoRename<cr>', { buffer = true, remap = true, silent = true })
                vim.keymap.set('n', '<leader>rc', ':GoCoverage -gcflags=all=-l<cr>',
                    { buffer = true, remap = true, silent = true })
                vim.keymap.set('n', '<leader>ri', ':GoImport', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rr', ':GoRun<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rtt', ':GoTestFunc<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rtf', ':GoTestFile<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rg', ':GoGet<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rfe', ':GoIfErr<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rtw', ':GoFillSwitch<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rts', ':GoFillStruct<cr>', { buffer = true, remap = true, silent = false })
                vim.keymap.set('n', '<leader>rtp', ':GoFixPlurals<cr>', { buffer = true, remap = true, silent = false })
            end,
        })
    end,
    run = function()
        vim.cmd('GoInstallBinaries')
    end,
    ft = 'go',
    requires = { 'ray-x/guihua.lua', 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter' }
}

return { go }
