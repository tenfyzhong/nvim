local toc = {
    "richardbizik/nvim-toc",
    config = function()
        require("nvim-toc").setup({
            toc_header = "Table of Contents"
        })
    end,
    ft = { "markdown" },
}

return { toc }
