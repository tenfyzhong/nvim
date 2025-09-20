local undotree = {
    "mbbill/undotree",
    config = function()
        vim.g.undotree_WindowLayout = 3
        vim.g.undotree_DiffpanelHeight = 30
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_ShortIndicators = 1
    end,
    keys = {
        {
            "<leader>ut",
            ":UndotreeToggle<cr>",
            mode = "n",
            remap = false,
            silent = true,
            desc = "undotree: toggle undotree",
        },
    },
}

return { undotree }
