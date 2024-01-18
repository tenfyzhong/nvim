--[[
- @file go.nvim.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-01 00:12:36
--]]

local run = function(fmtargs, bufnr, cmd)
    local utils = require('go.utils')
    local api = vim.api
    local vfn = vim.fn

    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.o.mod == true then
        vim.cmd('noautocmd silent write')
    end

    local args = vim.deepcopy(fmtargs)
    table.insert(args, api.nvim_buf_get_name(bufnr))

    local old_lines = api.nvim_buf_get_lines(0, 0, -1, true)
    table.insert(args, 1, cmd)

    local j = vfn.jobstart(args, {
        on_stdout = function(_, data, _)
            data = utils.handle_job_data(data)
            if not data then
                return
            end
            if not utils.check_same(old_lines, data) then
                vim.notify('updating codes', vim.log.levels.DEBUG)
                api.nvim_buf_set_lines(0, 0, -1, false, data)
                vim.cmd('silent write')
            else
                vim.notify('already formatted.', vim.log.levels.INFO)
            end
            old_lines = nil
        end,
        on_stderr = function(_, data, _)
            data = utils.handle_job_data(data)
            if data then
                vim.notify(vim.inspect(data) .. ' from stderr', vim.log.levels.DEBUG)
            end
        end,
        on_exit = function(_, data, _) -- id, data, event
            if data ~= 0 then
                return vim.notify('goimports failed ' .. tostring(data), vim.log.levels.ERROR)
            end
            old_lines = nil
            vim.defer_fn(function()
                if vfn.getbufinfo('%')[1].changed == 1 then
                    vim.cmd('noautocmd silent write')
                end
            end, 200)
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
    vfn.chansend(j, old_lines)
    vfn.chanclose(j, 'stdin')
end

local function table_contains(tbl, x)
    local found = false
    for _, v in pairs(tbl) do
        if v == x then
            found = true
        end
    end
    return found
end

local imports = function(...)
    if vim.o.diff then
        return
    end

    local goimport = 'goimports'
    local args = { ... }

    local l = os.getenv('GOIMPORTS_LOCAL')
    if not table_contains(args, '-local') and l ~= '' then
        table.insert(args, '-local')
        table.insert(args, l)
    end

    local buf = vim.api.nvim_get_current_buf()
    require('go.install').install(goimport)
    return run(args, buf, goimport)
end

local go = {
    'tenfyzhong/go.nvim',
    config = function()
        require('go').setup {
            lsp_gofumpt = true,
            lsp_document_formatting = true,
            comment_placeholder = '',
            -- goimport = 'goimports',
            -- fillstruct = 'fillstruct',
        }

        vim.api.nvim_create_user_command('GoImports', function(opts)
            imports(unpack(opts.fargs))
        end, {
            desc = 'go.vim: goimports, use env<$GOIMPORTS_LOCAL> to set the -local option',
            nargs = '*',
        })

        -- Run gofmt on save
        local format_sync_grp = vim.api.nvim_create_augroup("go_format", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                -- require('go.format').gofmt()
                imports('-format-only')
            end,
            group = format_sync_grp,
        })

        local go_nvim_local_group = vim.api.nvim_create_augroup('go_nvim_local', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = go_nvim_local_group,
            pattern = 'go',
            callback = function()
                vim.keymap.set('n', '<leader>r', '<NOP>', { buffer = true, remap = true })
                vim.keymap.set('n', '<leader>rb', ':GoBuild<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoBuild' })
                vim.keymap.set('n', '<leader>rd', ':GoDoc<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoDoc' })
                vim.keymap.set('n', '<leader>re', ':silent GoRename<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoRename' })
                vim.keymap.set('n', '<leader>rc', ':GoCoverage -gcflags=all=-l<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoCoverage' })
                vim.keymap.set('n', '<leader>rm', ':GoCmt<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoCmt' })
                vim.keymap.set('n', '<leader>ri', ':GoImport ',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoImport' })
                vim.keymap.set('n', '<leader>rr', ':GoRun<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoRun' })
                vim.keymap.set('n', '<leader>rtt', ':GoTestFunc<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoTestFunc' })
                vim.keymap.set('n', '<leader>rtf', ':GoTestFile<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoTestFile' })
                -- vim.keymap.set('n', '<leader>rg', ':GoGet<cr>',
                --     { buffer = true, remap = true, silent = true, desc = 'go.nvim: GoGet' })
                vim.keymap.set('n', '<leader>rfe', ':GoIfErr<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoIfErr' })
                vim.keymap.set('n', '<leader>rtw', ':GoFillSwitch<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoFillSwitch' })
                vim.keymap.set('n', '<leader>rts', ':GoFillStruct<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoFillStruct' })
                vim.keymap.set('n', '<leader>rtp', ':GoFixPlurals<cr>',
                    { buffer = true, remap = true, silent = false, desc = 'go.nvim: GoFixPlurals' })
                vim.keymap.set('n', '<leader>rtg', ':GoAddTest<cr>',
                    { buffer = true, remap = false, silent = false, desc = 'go.nvim: GoAddTest' })
                vim.keymap.set('n', '<leader>aa', ':GoAlt<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoAlt' })
                vim.keymap.set('n', '<leader>as', ':GoAltS<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoAltS' })
                vim.keymap.set('n', '<leader>av', ':GoAltS<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoAltV' })
                vim.keymap.set('n', '<leader>af',
                    ':silent GoImports<cr>',
                    { buffer = true, remap = false, silent = true, desc = 'go.nvim: GoImports' })
            end,
        })
    end,
    run = function()
        vim.cmd('GoInstallBinaries')
    end,
    ft = 'go',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap' },
    event = 'VeryLazy',
    goimports = imports,
}

return { go }
