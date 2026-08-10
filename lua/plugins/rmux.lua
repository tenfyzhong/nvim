-- Seamless navigation between Neovim and rmux panes.

return {
    "tenfyzhong/rmux.nvim",
    config = function()
        require("rmux").setup({})
    end,
    keys = {
        {
            "<C-h>",
            function()
                require("rmux").move_left()
            end,
            mode = { "n", "t" },
            remap = false,
            silent = true,
            desc = "rmux: go to left window",
        },
        {
            "<C-j>",
            function()
                require("rmux").move_bottom()
            end,
            mode = { "n", "t" },
            remap = false,
            silent = true,
            desc = "rmux: go to window below",
        },
        {
            "<C-k>",
            function()
                require("rmux").move_top()
            end,
            mode = { "n", "t" },
            remap = false,
            silent = true,
            desc = "rmux: go to window above",
        },
        {
            "<C-l>",
            function()
                require("rmux").move_right()
            end,
            mode = { "n", "t" },
            remap = false,
            silent = true,
            desc = "rmux: go to right window",
        },
    },
}
