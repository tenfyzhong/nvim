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

local function goimports_reviser_args(rm_unused)
    -- GOIMPORTS_REVISER_FORMAT=
    -- GOIMPORTS_REVISER_IMPORTS_ORDER=
    -- GOIMPORTS_REVISER_PROJECT_NAME=
    -- GOIMPORTS_REVISER_SEPARATE_NAMED=
    -- GOIMPORTS_REVISER_SET_ALIAS=
    -- GOIMPORTS_REVISER_USE_CACHE=
    local args = {}
    local format = os.getenv("GOIMPORTS_REVISER_FORMAT")
    if is_not_whitespace(format) then
        args[#args + 1] = '-format'
    end

    local imports_order = os.getenv("GOIMPORTS_REVISER_IMPORTS_ORDER")
    if is_not_whitespace(imports_order) then
        args[#args + 1] = '--imports-order'
        args[#args + 1] = imports_order
    end

    local project_name = os.getenv("GOIMPORTS_REVISER_PROJECT_NAME")
    if is_not_whitespace(project_name) then
        args[#args + 1] = '-project-name'
        args[#args + 1] = project_name
    end

    local separate_named = os.getenv("GOIMPORTS_REVISER_SEPARATE_NAMED")
    if is_not_whitespace(separate_named) then
        args[#args + 1] = '-separate-named'
    end

    local set_alias = os.getenv("GOIMPORTS_REVISER_SET_ALIAS")
    if is_not_whitespace(set_alias) then
        args[#args + 1] = '-set-alias'
    end

    local use_cache = os.getenv("GOIMPORTS_REVISER_USE_CACHE")
    if is_not_whitespace(use_cache) then
        args[#args + 1] = '-use-cache'
    end

    if rm_unused then
        args[#args + 1] = '-rm-unused'
    end

    args[#args + 1] = '-output'
    args[#args + 1] = 'stdout'

    args[#args + 1] = '$FILENAME'

    return args
end

local function gofumpt_args()
    -- GOFUMPT_EXTRA=
    -- GOFUMPT_LANG=
    -- GOFUMPT_MODPATH=

    local args = {}

    local extra = os.getenv("GOFUMPT_EXTRA")
    if is_not_whitespace(extra) then
        args[#args + 1] = '-extra'
    end

    local lang = os.getenv("GOFUMPT_LANG")
    if is_not_whitespace(lang) then
        args[#args + 1] = '-lang'
        args[#args + 1] = lang
    end

    local modpath = os.getenv("GOFUMPT_MODPATH")
    if is_not_whitespace(modpath) then
        args[#args + 1] = '-modpath'
        args[#args + 1] = modpath
    end

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
                gofumpt = {
                    inherit = false,
                    command = "gofumpt",
                    args = gofumpt_args,
                },
                ['goimports-reviser'] = {
                    inherit = false,
                    command = 'goimports-reviser',
                    args = goimports_reviser_args(false),
                },
                ['goimports-reviser-rm-unused'] = {
                    inherit = false,
                    command = 'goimports-reviser',
                    args = goimports_reviser_args(true),
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
