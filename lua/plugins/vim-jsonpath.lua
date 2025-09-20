local jsonpath = {
    "mogelbrod/vim-jsonpath",
    ft = "json",
    config = function() end,
    keys = {
        {
            "<leader>rp",
            ":call jsonpath#echo()<cr>",
            mode = "n",
            ft = "json",
            buffer = true,
            silent = true,
            remap = false,
        },
        {
            "<leader>rg",
            ":call jsonpath#goto()<cr>",
            mode = "n",
            ft = "json",
            buffer = true,
            silent = true,
            remap = false,
        },
    },
}

return { jsonpath }
