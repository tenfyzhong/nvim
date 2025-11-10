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
    if indent ~= "" then
        args[#args + 1] = "-i"
        args[#args + 1] = indent
    end

    local binary_next_line = os.getenv("SHFMT_BINARY_NEXT_LINE")
    if is_not_whitespace(binary_next_line) then
        args[#args + 1] = "-bn"
    end

    local case_index = os.getenv("SHFMT_CASE_INDEX")
    if is_not_whitespace(case_index) then
        args[#args + 1] = "-ci"
    end

    local space_redirects = os.getenv("SHFMT_SPACE_REDIRECTS")
    if is_not_whitespace(space_redirects) then
        args[#args + 1] = "-sr"
    end

    local keep_padding = os.getenv("SHFMT_KEEP_PADDING")
    if is_not_whitespace(keep_padding) then
        args[#args + 1] = "-kp"
    end

    local func_next_line = os.getenv("SHFMT_FUNC_NEXT_LINE")
    if is_not_whitespace(func_next_line) then
        args[#args + 1] = "-fn"
    end

    args[#args + 1] = "--filename"
    args[#args + 1] = "$FILENAME"

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
        args[#args + 1] = "-format"
    end

    local imports_order = os.getenv("GOIMPORTS_REVISER_IMPORTS_ORDER")
    if is_not_whitespace(imports_order) then
        args[#args + 1] = "--imports-order"
        args[#args + 1] = imports_order
    end

    local project_name = os.getenv("GOIMPORTS_REVISER_PROJECT_NAME")
    if is_not_whitespace(project_name) then
        args[#args + 1] = "-project-name"
        args[#args + 1] = project_name
    end

    local separate_named = os.getenv("GOIMPORTS_REVISER_SEPARATE_NAMED")
    if is_not_whitespace(separate_named) then
        args[#args + 1] = "-separate-named"
    end

    local set_alias = os.getenv("GOIMPORTS_REVISER_SET_ALIAS")
    if is_not_whitespace(set_alias) then
        args[#args + 1] = "-set-alias"
    end

    local use_cache = os.getenv("GOIMPORTS_REVISER_USE_CACHE")
    if is_not_whitespace(use_cache) then
        args[#args + 1] = "-use-cache"
    end

    if rm_unused then
        args[#args + 1] = "-rm-unused"
    end

    args[#args + 1] = "-output"
    args[#args + 1] = "stdout"

    args[#args + 1] = "$FILENAME"

    return args
end

local function gofumpt_args()
    -- GOFUMPT_EXTRA=
    -- GOFUMPT_LANG=
    -- GOFUMPT_MODPATH=

    local args = {}

    local extra = os.getenv("GOFUMPT_EXTRA")
    if is_not_whitespace(extra) then
        args[#args + 1] = "-extra"
    end

    local lang = os.getenv("GOFUMPT_LANG")
    if is_not_whitespace(lang) then
        args[#args + 1] = "-lang"
        args[#args + 1] = lang
    end

    local modpath = os.getenv("GOFUMPT_MODPATH")
    if is_not_whitespace(modpath) then
        args[#args + 1] = "-modpath"
        args[#args + 1] = modpath
    end

    return args
end

local function goimports_args(format_only)
    -- GOIMPORTS_LOCAL=
    local args = {}
    local l = os.getenv("GOIMPORTS_LOCAL")
    if is_not_whitespace(l) then
        args[#args + 1] = "-local"
    end

    if format_only then
        args[#args + 1] = "-format-only"
    end

    return args
end

local function yq_args()
    local ft = vim.bo.filetype

    local args = {}
    local upper_ft = ft:upper()
    local key = string.format("%s_INDENT", upper_ft)
    local indent = os.getenv(key)
    if is_not_whitespace(indent) then
        args[#args + 1] = "-I"
        args[#args + 1] = indent
    end

    args[#args + 1] = "-p"
    args[#args + 1] = ft
    args[#args + 1] = "-o"
    args[#args + 1] = ft
    args[#args + 1] = "-P"
    args[#args + 1] = "-"

    return args
end

local function get_formatters_from_env(typ, ft, default_formatters)
    -- CONFORM_AUTO_GO_FORMATTERS=goimports-reviser,gofumpt
    -- CONFORM_MANUAL_SH_FORMATTERS=

    local upper_ft = ft:upper()
    local key = string.format("CONFORM_%s_%s_FORMATTERS", typ, upper_ft)
    local str = os.getenv(key)
    if str ~= nil then
        -- split by ','
        return vim.split(str, ",")
    end
    return default_formatters
end

local function get_manual_formatters_from_env(ft, default_formatters)
    -- CONFORM_MANUAL_GO_FORMATTERS=goimports-reviser,gofumpt
    -- CONFORM_MANUAL_SH_FORMATTERS=

    return get_formatters_from_env("MANUAL", ft, default_formatters)
end

local function get_auto_formatters_from_env(ft, default_formatters)
    -- CONFORM_AUTO_GO_FORMATTERS=goimports-reviser,gofumpt
    -- CONFORM_AUTO_SH_FORMATTERS=

    return get_formatters_from_env("AUTO", ft, default_formatters)
end

local function disable_formatter_from_env(ft)
    local upper_ft = ft:upper()
    local key = string.format("CONFORM_DISABLE_%s", upper_ft)
    local str = os.getenv(key)
    if not str then
        return false
    end
    local upper_str = str:upper()
    return upper_str == "1" or upper_str == "TRUE"
end

local function format(args)
    local conform = require("conform")
    local feature = require("feature")

    local disable = disable_formatter_from_env(vim.bo.filetype)
    if disable then
        return
    end

    local skip_fts = {}

    local option = {}
    option.bufnr = args.buf

    if vim.tbl_contains(skip_fts, vim.bo.filetype) then
        return
    end

    -- The format from env is the highest priority
    local formatters = args.get_formatters_fn and args.get_formatters_fn(vim.bo.filetype, args.formatters)
    option.formatters = formatters
    option.async = args.async or false
    option.lsp_format = "fallback"

    feature.format(function()
        conform.format(option)
    end)
end

local function format_manual()
    local buf = vim.api.nvim_get_current_buf()

    if vim.bo.filetype == "go" then
        format({
            buf = buf,
            formatters = { "goimports", "gofumpt" },
            get_formatters_fn = get_manual_formatters_from_env,
        })
    else
        format({
            buf = buf,
        })
    end
end

local conform = {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        local sh_formatters = get_auto_formatters_from_env("sh", { "shfmt" })
        local go_formatters = get_auto_formatters_from_env("go", { "goimports_format_only", "gofumpt" })

        conform.setup({
            -- log_level = vim.log.levels.TRACE,
            formatters_by_ft = {
                sh = sh_formatters,
                bash = sh_formatters,
                zsh = sh_formatters,
                go = go_formatters,
                markdown = { "markdownlint-cli2" },
                lua = { "stylua" },
                fish = { "fish_indent" },
                json = { "yq" },
                yaml = { "yq" },
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
                -- goimports-reviser will result in `no such file or directory` errors
                ["goimports-reviser"] = {
                    inherit = false,
                    command = "goimports-reviser",
                    args = goimports_reviser_args(false),
                },
                ["goimports-reviser-rm-unused"] = {
                    inherit = false,
                    command = "goimports-reviser",
                    args = goimports_reviser_args(true),
                },
                goimports = {
                    inherit = false,
                    command = "goimports",
                    args = goimports_args(false),
                },
                goimports_format_only = {
                    inherit = false,
                    command = "goimports",
                    args = goimports_args(true),
                },
                yq = {
                    inherit = false,
                    command = "yq",
                    args = yq_args,
                },
            },
            default_format_opts = {
                lsp_format = "never",
            },
            -- If this is set, Conform will run the formatter on save.
            -- It will pass the table to conform.format().
            -- This can also be a function that returns the table.
            format_on_save = {
                -- I recommend these options. See :help conform.format for details.
                lsp_format = "never",
                timeout_ms = 500,
            },
        })

        local shfmt_group = vim.api.nvim_create_augroup("shfmt_init", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = shfmt_group,
            pattern = "*",
            callback = function(args)
                format({
                    buf = args.buf,
                    async = true,
                    get_formatters_fn = get_auto_formatters_from_env,
                })
            end,
        })

        vim.api.nvim_create_user_command("Format", function()
            format_manual()
        end, { desc = "Run formatter manually" })

        vim.keymap.set("n", "<leader>af", function()
            format_manual()
        end, {
            silent = true,
            remap = false,
            desc = "Run formatter manually",
        })
    end,
    event = "VeryLazy",
}

return { conform }
