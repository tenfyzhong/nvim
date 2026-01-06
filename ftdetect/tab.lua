vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "css",
        "ejs",
        "html",
        "htmldjango",
        "htmljanja",
        "jade",
        "pug",
        "javascript",
        "typescript",
        "vue",
        "yaml",
        "json",
        "jsonc",
    },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.expandtab = true
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "make",
        "go",
        "java",
    },
    callback = function()
        vim.bo.expandtab = false
    end,
})
