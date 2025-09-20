local lqa = {
    "tenfyzhong/lqa.nvim",
    config = function()
        require("lqa").setup({
            keymap = {
                previous = "<leader>qk",
                next = "<leader>qj",
                close = "<leader>qc",
                open = "<leader>qo",
                quickfix_open = "<leader>qq",
                loclist_open = "<leader>ql",
            },
        })
    end,
    keys = {
        "<leader>qk",
        "<leader>qj",
        "<leader>qc",
        "<leader>qo",
        "<leader>qq",
        "<leader>ql",
    },
}

return { lqa }
