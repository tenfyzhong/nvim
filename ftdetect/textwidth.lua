vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "ejs",
        "markdown",
    },
    callback = function()
        vim.bo.textwidth = 0
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "gitcommit",
        "python",
    },
    callback = function()
        vim.bo.textwidth = 79
    end,
})
