local substitute = {
    "gbprod/substitute.nvim",
    config = function()
        require("substitute").setup({
            on_substitute = require("yanky.integration").substitute(),
        })
    end,
    keys = {
        {
            "<leader>s",
            function()
                require("substitute").operator()
            end,
            mode = "n",
            noremap = true,
            desc = "substitute: operator",
        },
        {
            "<leader>ss",
            function()
                require("substitute").line()
            end,
            mode = "n",
            noremap = true,
            desc = "substitute: line",
        },
        {
            "<leader>S",
            function()
                require("substitute").eol()
            end,
            mode = "n",
            noremap = true,
            desc = "substitute: eol",
        },
        {
            "<leader>s",
            function()
                require("substitute").visual()
            end,
            mode = "x",
            noremap = true,
            desc = "substitute: visual",
        },
    },
}

return { substitute }
