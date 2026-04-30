-- Opencode assistant integration for prompts and terminal actions.

local function opencode_or_fallback(opencode_cmd, fallback_key)
    return function()
        if vim.bo.filetype == "opencode_terminal" then
            require("opencode").command(opencode_cmd)
        else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(fallback_key, true, true, true), "n", false)
        end
    end
end

local opencode = {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- provider = {
            --     enabled = "tmux",
            --     tmux = {},
            -- },
        }
    end,
    keys = {
        {
            "<leader>oa",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            mode = { "n", "x" },
            remap = false,
            desc = "Ask opencode about the current line",
        },
        {
            "<leader>ob",
            function()
                require("opencode").ask("@buffer: ", { submit = true })
            end,
            mode = { "n", "x" },
            remap = false,
            desc = "Ask opencode about the current buffer",
        },
        {
            "<leader>ox",
            function()
                require("opencode").select()
            end,
            mode = { "n", "x" },
            remap = false,
            desc = "Execute opencode action…",
        },
        {
            "<leader>o.",
            function()
                require("opencode").toggle()
            end,
            mode = { "n", "t" },
            remap = false,
            desc = "Toggle opencode",
        },
        {
            "<leader>og",
            function()
                return require("opencode").operator("@this ")
            end,
            mode = { "n", "x" },
            expr = true,
            desc = "Add range to opencode",
        },
        {
            "<leader>ogg",
            function()
                return require("opencode").operator("@this ") .. "_"
            end,
            mode = { "n" },
            expr = true,
            desc = "Add line to opencode",
        },
        {
            "<c-u>",
            opencode_or_fallback("session.half.page.up", "<c-u>"),
            mode = { "t" },
            remap = false,
            desc = "opencode half page up / fallback",
        },
        {
            "<c-d>",
            opencode_or_fallback("session.half.page.down", "<c-d>"),
            mode = { "t" },
            remap = false,
            desc = "opencode half page down / fallback",
        },
        {
            "<c-b>",
            opencode_or_fallback("session.page.up", "<c-b>"),
            mode = { "t" },
            remap = false,
            desc = "opencode page up / fallback",
        },
        {
            "<c-f>",
            opencode_or_fallback("session.page.down", "<c-f>"),
            mode = { "t" },
            remap = false,
            desc = "opencode page down / fallback",
        },
        {
            "<leader>o+",
            "<C-a>",
            mode = { "n" },
            remap = false,
            desc = "Increment",
        },
        {
            "<leader>o-",
            "<C-x>",
            mode = { "n" },
            remap = false,
            desc = "Decrement",
        },
    },
}

return { opencode }
