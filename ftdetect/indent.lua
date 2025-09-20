vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "sed" },
    callback = function()
        vim.bo.cindent = false
    end,
})
