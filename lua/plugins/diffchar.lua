local diffchar = {
    "rickhowe/diffchar.vim",
    config = function()
        vim.g.DiffPairVisible = 0
    end,
    keys = {
        { "<leader>dg", "<Plug>GetDiffCharPair", remap = true },
        { "<leader>dp", "<Plug>PutDiffCharPair", remap = true },
    },
}

return { diffchar }
