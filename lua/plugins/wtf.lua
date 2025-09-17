local wtf = {
    "piersolenski/wtf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim", -- Optional: For WtfGrepHistory
    },
    opts = {
        provider = "gemini",
        search_engine = "duck_duck_go",
        popup_type = "popup",
        providers = {
            gemini = {
                -- An alternative way to set your API key
                api_key = function()
                    return os.getenv("GOOGLE_API_KEY")
                end,
                -- Your preferred model
                model_id = "gemini-2.5-flash",
            },
        },
    },
    keys = {
        {
            "<leader>td",
            mode = { "n", "x" },
            function()
                require("wtf").diagnose()
            end,
            desc = "Debug diagnostic with AI",
        },
        {
            "<leader>tf",
            mode = { "n", "x" },
            function()
                require("wtf").fix()
            end,
            desc = "Fix diagnostic with AI",
        },
        {
            mode = { "n" },
            "<leader>ts",
            function()
                require("wtf").search()
            end,
            desc = "Search diagnostic with Google",
        },
        -- {
        --     mode = { "n" },
        --     "<leader>wp",
        --     function()
        --         require("wtf").pick_provider()
        --     end,
        --     desc = "Pick provider",
        -- },
        -- {
        --     mode = { "n" },
        --     "<leader>th",
        --     function()
        --         require("wtf").history()
        --     end,
        --     desc = "Populate the quickfix list with previous chat history",
        -- },
        -- {
        --     mode = { "n" },
        --     "<leader>tg",
        --     function()
        --         require("wtf").grep_history()
        --     end,
        --     desc = "Grep previous chat history with Telescope",
        -- },
    },
    cmd = { "Wtf", "WtfFix", "WtfPickProvider", "WtfSearch", "WtfGrepHistory" },
}
return { wtf }
