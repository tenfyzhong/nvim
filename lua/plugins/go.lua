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
        require('go').setup {
            dap_debug_vt = false,
        }

        local group = vim.api.nvim_create_augroup('go_nvim_local', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'go',
            callback = function()
                vim.keymap.set('n', '<leader>r', '<NOP>', { buffer = true, remap = true })
                vim.keymap.set('n', '<leader>rb', ':GoBuild<cr>',
                    { buffer = true, remap = true, silent = true, desc = 'go.nvim: GoBuild' })
                vim.keymap.set('n', '<leader>rd', ':GoDoc<cr>',
                    { buffer = true, remap = true, silent = true, desc = 'go.nvim: GoDoc' })
                vim.keymap.set('n', '<leader>re', ':silent GoRename<cr>',
                    { buffer = true, remap = true, silent = true, desc = 'go.nvim: GoRename' })
                vim.keymap.set('n', '<leader>rc', ':GoCoverage -gcflags=all=-l<cr>',
                    { buffer = true, remap = true, silent = true, desc = 'go.nvim: GoCoverage' })
                vim.keymap.set('n', '<leader>ri', ':GoImport ',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoImport' })
                vim.keymap.set('n', '<leader>rr', ':GoRun<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoRun' })
                vim.keymap.set('n', '<leader>rtt', ':GoTestFunc<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoTestFunc' })
                vim.keymap.set('n', '<leader>rtf', ':GoTestFile<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoTestFile' })
                -- vim.keymap.set('n', '<leader>rg', ':GoGet<cr>',
                --     { buffer = true, remap = true, silent = true, desc = 'go.nvim: GoGet' })
                vim.keymap.set('n', '<leader>rfe', ':GoIfErr<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoIfErr' })
                vim.keymap.set('n', '<leader>rtw', ':GoFillSwitch<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoFillSwitch' })
                vim.keymap.set('n', '<leader>rts', ':GoFillStruct<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoFillStruct' })
                vim.keymap.set('n', '<leader>rtp', ':GoFixPlurals<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoFixPlurals' })
                vim.keymap.set('n', '<leader>rtg', ':GoAddTest<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoAddTest' })
                vim.keymap.set('n', '<leader>aa', ':GoAlt<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoAlt' })
                vim.keymap.set('n', '<leader>as', ':GoAltS<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoAltS' })
                vim.keymap.set('n', '<leader>av', ':GoAltS<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoAltV' })
            end,
        })
    end,
    run = function()
        vim.cmd('GoInstallBinaries')
    end,
    ft = 'go',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap' },
    event = 'VeryLazy',
}

return { go }
