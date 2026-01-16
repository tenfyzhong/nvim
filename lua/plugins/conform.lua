-- Vim config API:
-- g:conform_args_{formatter} = [] - extra args for formatter
-- g:conform_{auto|manual}_formatters_{ft} = [] - override formatters
-- g:conform_disable_{ft} = 1 - disable formatting for filetype

local feature = require("feature")

local auto_formatters_by_ft = {
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    go = { "goimports_format_only", "gofumpt" },
    markdown = { "markdownlint-cli2" },
    lua = { "stylua" },
    fish = { "fish_indent" },
    json = { "gojq" },
    yaml = { "yamlfmt" },
    jsonc = { "deno_fmt" },
}

local manual_formatters_by_ft = {
    go = { "goimports", "gofumpt" },
}

local function gen_formatter(name, opts)
    opts = opts or {}
    return function()
        local args = feature.to_list(vim.g["conform_args_" .. name])
        for _, arg in ipairs(feature.to_list(opts.args)) do
            args[#args + 1] = arg
        end
        local result = { command = opts.command or name, args = args }
        vim.notify("gen_formatter, " .. name .. ", " .. vim.inspect(result), vim.log.levels.TRACE)
        return result
    end
end

local function get_formatters(manual, ft)
    ft = ft or vim.bo.filetype
    local typ = manual and "manual" or "auto"
    local local_formatters = feature.to_list(vim.g["conform_" .. typ .. "_formatters_" .. ft])
    if #local_formatters > 0 then
        return local_formatters
    end
    return manual and manual_formatters_by_ft[ft] or auto_formatters_by_ft[ft]
end

local function format(args)
    local ft = vim.bo.filetype
    local disable = vim.g["conform_disable_" .. ft]
    if disable and disable ~= 0 then
        vim.notify("disable format " .. ft .. " " .. disable, vim.log.levels.DEBUG)
        return
    end

    local option = {
        bufnr = args.buf,
        formatters = args.formatters,
        async = args.async or false,
        lsp_format = "fallback",
    }

    vim.notify("format option: " .. vim.inspect(option), vim.log.levels.TRACE)
    feature.format(function()
        require("conform").format(option)
    end)
end

local function format_manual()
    format({
        buf = vim.api.nvim_get_current_buf(),
        async = false,
        formatters = get_formatters(true) or get_formatters(false),
    })
end

return {
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        config = function()
            local conform = require("conform")

            local formatters_by_ft = {}
            for ft in pairs(auto_formatters_by_ft) do
                formatters_by_ft[ft] = get_formatters(false, ft)
            end

            conform.setup({
                log_level = vim.log.levels.TRACE,
                formatters_by_ft = formatters_by_ft,
                formatters = {
                    shfmt = { command = "shfmt" },
                    jsonc = { command = "deno_fmt" },
                    gofumpt = gen_formatter("gofumpt"),
                    ["goimports-reviser"] = gen_formatter("goimports-reviser", {
                        args = { "-output", "stdout", "$FILENAME" },
                    }),
                    ["goimports-reviser-rm-unused"] = gen_formatter("goimports-reviser-rm-unused", {
                        command = "goimports-reviser",
                        args = { "-rm-unused", "-output", "stdout", "$FILENAME" },
                    }),
                    goimports = gen_formatter("goimports"),
                    goimports_format_only = gen_formatter("goimports_format_only", {
                        command = "goimports",
                        args = { "-format-only" },
                    }),
                    gojq = gen_formatter("gojq"),
                },
                default_format_opts = {
                    lsp_format = "fallback",
                },
            })

            vim.api.nvim_create_augroup("conform_format", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = "conform_format",
                pattern = "*",
                callback = function(args)
                    format({
                        buf = args.buf,
                        async = true,
                        formatters = get_formatters(false),
                    })
                end,
            })

            vim.api.nvim_create_user_command("Format", format_manual, { desc = "Run formatter manually" })
            vim.keymap.set("n", "<leader>af", format_manual, {
                silent = true,
                remap = false,
                desc = "Run formatter manually",
            })
        end,
    },
}
