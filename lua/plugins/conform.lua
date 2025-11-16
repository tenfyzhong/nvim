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

local function to_list(value)
    local feature = require("feature")
    return feature.to_list(value)
end

-- vim config
-- g:conform_args_{formatter} = []
local function local_conform_args(formatter, args)
    return function()
        local items = to_list(vim.g["conform_args_" .. formatter])
        local v = to_list(args)
        for _, item in ipairs(v) do
            items[#items + 1] = item
        end
        return items
    end
end

local function gen_formatter(formatter, option)
    return function()
        option.args = local_conform_args(formatter, option.args)
        log("gen_formatter, " .. formatter .. ", " .. vim.inspect(option), vim.log.levels.TRACE)
        return option
    end
end

-- vim config
-- g:conform_auto_formatters_{ft} = []
-- g:conform_manual_formatters_{ft} = []
local function formatters_local(typ, ft)
    return to_list(vim.g["conform_" .. typ .. "_formatters_" .. ft])
end

-- vim config
-- g:conform_disable_{ft} = 1
local function disable_formatter_local(ft)
    local disable = vim.g["conform_disable_" .. ft] or 0
    return disable
end

local function get_formatters(manual, filetype)
    local typ = manual and "manual" or "auto"

    local ft = filetype or vim.bo.filetype

    local formatters = formatters_local(typ, ft)
    if #formatters > 0 then
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
    local disable = disable_formatter_local(vim.bo.filetype)
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
