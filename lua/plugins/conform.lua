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

local manual_formatters_by_ft = {
    go = { "goimports", "gofumpt" },
}

local function is_not_whitespace(str)
    return str and str:match("%S")
end

-- env format:
-- CONFORM_ARGS_{FORMATTER}="formatter args"
local function conform_args_from_env(formatter, append_args)
    local args = {}
    formatter = formatter:upper()
    formatter = string.gsub(formatter, "%-", "_")
    local key = string.format("CONFORM_ARGS_%s", formatter)
    local value = os.getenv(key)
    if is_not_whitespace(value) then
        args[#args + 1] = value
    end

    if append_args then
        for _, v in ipairs(append_args) do
            table.insert(args, v)
        end
    end

    return args
end

local function gen_formatter(command, formatter, append_args)
    return function()
        local result = {
            inherit = false,
            command = command,
            args = conform_args_from_env(formatter, append_args),
        }

        vim.notify("gen_formatter, " .. formatter .. ", " .. vim.inspect(result), vim.log.levels.TRACE)
        return result
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

local function get_formatters(manual)
    local typ = manual and "MANUAL" or "AUTO"

    local ft = vim.bo.filetype

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

    vim.notify("format option: " .. vim.inspect(option), vim.log.levels.TRACE)

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

        conform.setup({
            -- log_level = vim.log.levels.TRACE,
            formatters = {
                shfmt = gen_formatter("shfmt", "shfmt", { "--filename", "$FILENAME" }),
                gofumpt = gen_formatter("gofumpt", "gofumpt"),
                -- goimports-reviser will result in `no such file or directory` errors
                ["goimports-reviser"] = gen_formatter(
                    "goimports-reviser",
                    "goimports-reviser",
                    { "-output", "stdout", "$FILENAME" }
                ),
                ["goimports-reviser-rm-unused"] = gen_formatter(
                    "goimports-reviser",
                    "goimports-reviser-rm-unused",
                    { "-rm-unused", "-output", "stdout", "$FILENAME" }
                ),
                goimports = gen_formatter("goimports", "goimports"),
                goimports_format_only = gen_formatter("goimports", "goimports_format_only", { "-format-only" }),
                yq_json = gen_formatter("yq", "yq_json", { "-p", "json", "-o", "json", "-P", "-" }),
                yq_yaml = gen_formatter("yq", "yq_yaml", { "-p", "yaml", "-o", "yaml", "-P", "-" }),
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
