local autopairs = {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({})
    end,
    event = "VeryLazy",
}

return { autopairs }
