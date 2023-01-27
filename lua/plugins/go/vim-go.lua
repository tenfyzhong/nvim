--[[
- @file vim-go.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 11:10:16
--]]

local function build_go_files()
    local file = vim.api.nvim_buf_get_name(0)
    local test_suffix = '_test.go'
    local go_suffix = '.go'
    if file:sub(-string.len(test_suffix)) == test_suffix then
        vim.fn['go#test#Test'](0, 1)
    elseif file:sub(-string.len(go_suffix)) == go_suffix then
        vim.fn['go#cmd#Build'](0)
    end
end

local function autocmd()
    vim.keymap.set('n', '<leader>r', '<NOP>', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>rs', '<Plug>(go-implements)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>rd', '<Plug>(go-info)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>re', '<Plug>(go-rename)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>rr', '<Plug>(go-run)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>rb', build_go_files, { buffer = true, remap = false })
    vim.keymap.set('n', '<leader>rtt', '<Plug>(go-test)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>rtf', '<Plug>(go-test-func)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>rc',
        function()
            vim.cmd('GoCoverageToggle! -gcflags=all=-l<cr>')
        end, { buffer = true, remap = false })
    vim.keymap.set('n', '<leader>ri',
        function()
            vim.cmd('GoImport')
        end, { buffer = true, remap = false })
    vim.keymap.set('n', '<leader>rf',
        function()
            vim.cmd('GoIfErr')
        end, { buffer = true, remap = false })
    vim.keymap.set('n', '<leader>ra',
        function()
            vim.cmd('GoImportAs')
        end, { buffer = true, remap = false })
    vim.keymap.set('n', '<leader>aa', '<Plug>(go-alternate-edit)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>as', '<Plug>(go-alternate-split)', { buffer = true, remap = true })
    vim.keymap.set('n', '<leader>av', '<Plug>(go-alternate-vertical)', { buffer = true, remap = true })

    vim.api.nvim_create_user_command('A',
        function(opts)
            local b = opts.bang and 1 or 0
            vim.fn['go#alternate#Switch'](b, 'edit')
        end, { force = true })
    vim.api.nvim_create_user_command('AV',
        function(opts)
            local b = opts.bang and 1 or 0
            vim.fn['go#alternate#Switch'](b, 'vsplit')
        end, { force = true })
    vim.api.nvim_create_user_command('AS',
        function(opts)
            local b = opts.bang and 1 or 0
            vim.fn['go#alternate#Switch'](b, 'split')
        end, { force = true })
    vim.api.nvim_create_user_command('AT',
        function(opts)
            local b = opts.bang and 1 or 0
            vim.fn['go#alternate#Switch'](b, 'tabe')
        end, { force = true })
end

local function config()
    vim.g.go_highlight_methods = 0
    vim.g.go_highlight_types = 0
    vim.g.go_highlight_operators = 0
    vim.g.go_highlight_build_constraints = 1
    vim.g.go_fmt_fail_silently = 1
    vim.g.go_get_update = 0
    vim.g.go_fmt_autosave = 0
    vim.g.go_imports_autosave = 0
    vim.g.go_metalinter_autosave = 0
    vim.g.go_echo_go_info = 0
    vim.g.go_doc_popup_window = 1
    vim.g.go_highlight_functions = 0
    local group = vim.api.nvim_create_augroup('vim_go_local', {})
    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'go',
        callback = function() autocmd() end,
    })
end

local function run()
    vim.cmd('GoInstallBinaries')
end

local go = {
    'fatih/vim-go',
    tag = '*',
    run = run,
    config = config,
    ft = 'go',
}

return { go }
