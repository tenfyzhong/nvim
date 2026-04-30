-- Treesitter-aware commentstring support.

local comments = {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {
        lang = {
            thrift = "// %s",
            proto = "// %s",
        },
    },
}

return { comments }
