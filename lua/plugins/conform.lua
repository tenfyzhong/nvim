local auto_formatters_by_ft = {
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    go = { "goimports_format_only", "gofumpt" },
    markdown = { "markdownlint-cli2" },
    lua = { "stylua" },
    fish = { "fish_indent" },
    json = { "yq_json" },
    yaml = { "yq_yaml" },
}

local function log(msg, level)
    vim.notify(msg, level)
end

local manual_formatters_by_ft = {
    go = { "goimports", "gofumpt" },
}

-- return true if str has content
local function realstr(str)
    return str and str:match("%S")
end

local function parse_value(value)
    local value_type = type(value)
    if value_type == "string" then
        return { value }
    elseif value_type == "table" then
        return value
    elseif value_type == "function" then
        local success, result = pcall(value)
        if success then
            return parse_value(result)
        end
    end
    return {}
end

-- Helper function to parse arguments, respecting quotes
local function parse_args_with_quotes(s)
    local args_list = {}
    -- Pattern to match either double-quoted strings, single-quoted strings, or non-whitespace sequences
    for match in s:gmatch("\"[^\"]*\"|'[^']*'|%S+") do
        -- If the match starts with a quote, remove the surrounding quotes
        if match:sub(1, 1) == '"' or match:sub(1, 1) == "'" then
            table.insert(args_list, match:sub(2, -2))
        else
            table.insert(args_list, match)
        end
    end
    return args_list
end

-- env format:
-- CONFORM_ARGS_{FORMATTER}="formatter args"
local function conform_args_from_env(formatter, args)
    return function()
        local v = parse_value(args) or {}

        formatter = formatter:upper()
        formatter = string.gsub(formatter, "%-", "_")
        local key = string.format("CONFORM_ARGS_%s", formatter)
        local value = os.getenv(key) or ""
        if not realstr(value) then
            return v
        end

        local parsed_items = parse_args_with_quotes(value)
        for _, item in ipairs(parsed_items) do
            v[#v + 1] = item
        end

        vim.notify("args " .. formatter .. " " .. vim.inspect(v))
        return v
    end
end

local function gen_formatter(formatter, option)
    return function()
        option.args = conform_args_from_env(formatter, option.args)
        log("gen_formatter, " .. formatter .. ", " .. vim.inspect(option), vim.log.levels.TRACE)
        return option
    end
end

-- env format:
-- CONFORM_AUTO_FORMATTERS_{FILETYPE}="formatter1,formatter2"
-- CONFORM_MANUAL_FORMATTERS_{FILETYPE}="formatter1,formatter2"
local function formatters_from_env(typ, ft)
    local upper_ft = ft:upper()
    local key = string.format("CONFORM_%s_FORMATTERS_%s", typ, upper_ft)
    local str = os.getenv(key)
    if str ~= nil then
        return vim.split(str, ",")
    end
    return nil
end

-- env format:
-- CONFORM_DISABLE_{FILETYPE}=1
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

local function get_formatters(manual, filetype)
    local typ = manual and "MANUAL" or "AUTO"

    local ft = filetype or vim.bo.filetype

    local formatters = formatters_from_env(typ, ft)
    if formatters then
        return formatters
    end

    return manual and manual_formatters_by_ft[ft] or auto_formatters_by_ft[ft]
end

-- args = {
-- bufnr = int,
-- async = bool,
-- formatters = [string],
-- }
local function format(args)
    local disable = disable_formatter_from_env(vim.bo.filetype)
    if disable then
        return
    end

    local conform = require("conform")
    local feature = require("feature")

    local option = {}
    option.bufnr = args.buf
    option.formatters = args.formatters
    option.async = args.async or false
    option.lsp_format = "fallback"

    log("format option: " .. vim.inspect(option), vim.log.levels.TRACE)

    feature.format(function()
        conform.format(option)
    end)
end

local function format_manual()
    local buf = vim.api.nvim_get_current_buf()
    local formatters = get_formatters(true) or get_formatters(false)
    format({
        buf = buf,
        async = false,
        formatters = formatters,
    })
end

local conform = {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        local formatters_by_ft = {}
        for k in pairs(auto_formatters_by_ft) do
            formatters_by_ft[k] = get_formatters(false, k)
        end

        conform.setup({
            log_level = vim.log.levels.TRACE,
            formatters_by_ft = formatters_by_ft,
            formatters = {
                shfmt = {
                    command = "shfmt",
                },
                gofumpt = gen_formatter("gofumpt", {
                    command = "gofumpt",
                }),
                ["goimports-reviser"] = gen_formatter("goimports-reviser", {
                    command = "goimports-reviser",
                    args = { "-output", "stdout", "$FILENAME" },
                }),
                ["goimports-reviser-rm-unused"] = gen_formatter("goimports-reviser-rm-unused", {
                    command = "goimports-reviser",
                    args = { "-rm-unused", "-output", "stdout", "$FILENAME" },
                }),
                goimports = gen_formatter("goimports", {
                    command = "goimports",
                }),
                goimports_format_only = gen_formatter("goimports_format_only", {
                    command = "goimports",
                    args = { "-format-only" },
                }),
                yq_json = gen_formatter("yq_json", {
                    command = "yq",
                    args = { "-p", "json", "-o", "json", "-P", "-" },
                }),
                yq_yaml = gen_formatter("yq_yaml", {
                    command = "yq",
                    args = { "-p", "yaml", "-o", "yaml", "-P", "-" },
                }),
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = {
                lsp_format = "fallback",
                timeout_ms = 500,
            },
        })

        local shfmt_group = vim.api.nvim_create_augroup("shfmt_init", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = shfmt_group,
            pattern = "*",
            callback = function(args)
                local formatters = get_formatters(false)
                format({
                    buf = args.buf,
                    async = true,
                    formatters = formatters,
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
