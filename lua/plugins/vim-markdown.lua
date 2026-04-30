-- Markdown syntax and editing enhancements.

local markdown = {
    "tpope/vim-markdown",
    config = function()
        vim.g.vim_markdown_folding_disabled = 1
    end,
    ft = { "markdown" },
}

return { markdown }
