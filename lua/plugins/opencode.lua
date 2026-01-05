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
            -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
        }

        -- Required for `opts.events.reload`.
        vim.o.autoread = true

        -- Recommended/example keymaps.
        vim.keymap.set("n", "<S-C-u>", function()
            require("opencode").command("session.half.page.up")
        end, { desc = "opencode half page up" })
        vim.keymap.set("n", "<S-C-d>", function()
            require("opencode").command("session.half.page.down")
        end, { desc = "opencode half page down" })

        -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
        vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
        vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
    keys = {
        {
            "<leader>oa",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            mode = { "n", "x" },
            remap = false,
            desc = "Ask opencode",
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
            "<leader>ou",
            function()
                require("opencode").command("session.half.page.up")
            end,
            mode = { "n" },
            remap = false,
            desc = "opencode half page up",
        },
        {
            "<leader>od",
            function()
                require("opencode").command("session.half.page.down")
            end,
            mode = { "n" },
            remap = false,
            desc = "opencode half page down",
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
