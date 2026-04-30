-- Display code coverage markers inside buffers.

local highlight = {
    "mgedmin/coverage-highlight.vim",
    config = function() end,
    cmd = { "HighlightCoverage" },
    keys = {
        {
            "<leader>rc",
            ":HighlightCoverage",
            mode = { "n" },
            ft = "python",
            silent = true,
            buffer = true,
            remap = false,
        },
    },
}

return { highlight }
