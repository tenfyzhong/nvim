local toc = {
    "richardbizik/nvim-toc",
    config = function()
        require("nvim-toc").setup({
            toc_header = "Table of Contents"
        })
    end,
    cmd = { 'TOC', 'TOCList' },
}

return { toc }
