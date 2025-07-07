local function is_not_whitespace(str)
    return str and str:match("%S")
end

local function shfmt_args()
    -- SHFMT_INDENT=
    -- SHFMT_BINARY_NEXT_LINE=
    -- SHFMT_CASE_INDEX=
    -- SHFMT_SPACE_REDIRECTS=
    -- SHFMT_KEEP_PADDING=
    -- SHFMT_FUNC_NEXT_LINE=
    local args = {}
    local indent = os.getenv("SHFMT_INDENT")
    if indent ~= '' then
        args[#args + 1] = '-i'
        args[#args + 1] = indent
    end

    local binary_next_line = os.getenv("SHFMT_BINARY_NEXT_LINE")
    if is_not_whitespace(binary_next_line) then
        args[#args + 1] = '-bn'
    end

    local case_index = os.getenv("SHFMT_CASE_INDEX")
    if is_not_whitespace(case_index) then
        args[#args + 1] = '-ci'
    end

    local space_redirects = os.getenv("SHFMT_SPACE_REDIRECTS")
    if is_not_whitespace(space_redirects) then
        args[#args + 1] = '-sr'
    end

    local keep_padding = os.getenv("SHFMT_KEEP_PADDING")
    if is_not_whitespace(keep_padding) then
        args[#args + 1] = '-kp'
    end

    local func_next_line = os.getenv("SHFMT_FUNC_NEXT_LINE")
    if is_not_whitespace(func_next_line) then
        args[#args + 1] = '-fn'
    end

    args[#args + 1] = '--filename'
    args[#args + 1] = '$FILENAME'

    return args
end

local function format(args)
    local conform = require("conform")
    local feature = require('feature')

    local skip_fts = {}
    local conform_fts = {
        'sh',
        'bash',
        'zsh',
        'go',
    }

    local option = {}
    option.bufnr = args.buf

    if vim.tbl_contains(skip_fts, vim.bo.filetype) then
        return
    elseif vim.tbl_contains(conform_fts, vim.bo.filetype) then
        if args.formatters then
            option.formatters = args.formatters
        end
        if args.async then
            option.async = args.async
        end

        feature.format(function()
            conform.format(option)
        end)
    else
        feature.format(function()
            option.formatters = nil
            option.lsp_format = "prefer"
            conform.format(option)
        end)
    end
end

local function format_manual()
    local buf = vim.api.nvim_get_current_buf()

    if vim.bo.filetype == 'go' then
        format({
            buf = buf,
            formatters = { 'goimports-reviser-rm-unused', 'gofumpt' }
        })
    else
        format({
            buf = buf,
        })
    end
end

local conform = {
    'stevearc/conform.nvim',
    config = function()
        local conform = require("conform")
        conform.setup({
            -- log_level = vim.log.levels.TRACE,
            formatters_by_ft = {
                sh = { 'shfmt' },
                go = { 'goimports-reviser', 'gofumpt' },
            },
            -- The format should print the formatted content to stdout
            formatters = {
                shfmt = {
                    inherit = false,
                    command = "shfmt",
                    args = shfmt_args,
                },
                ['goimports-reviser'] = {
                    inherit = false,
                    command = 'goimports-reviser',
                    args = { '-set-alias', '-format', '-output', 'stdout', '$FILENAME' },
                },
                ['goimports-reviser-rm-unused'] = {
                    inherit = false,
                    command = 'goimports-reviser',
                    args = { '-rm-unused', '-set-alias', '-format', '-output', 'stdout', '$FILENAME' },
                },
            }
        })

        local shfmt_group = vim.api.nvim_create_augroup('shfmt_init', {})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = shfmt_group,
            pattern = '*',
            callback = function(args)
                format({
                    buf = args.buf,
                    async = true,
                })
            end
        })

        vim.api.nvim_create_user_command('Format', function()
            format_manual()
        end, { desc = 'Run formatter manually' })

        vim.keymap.set({ 'n' }, '<leader>af', function() format_manual() end,
            { desc = 'Run formatter manually', silent = true, remap = false })
    end,
    -- event = 'VeryLazy',
}

return { conform }
