local table_mode = {
    "dhruvasagar/vim-table-mode",
    config = function()
        vim.g.table_mode_corner = "|"
    end,
    cmd = {
        "TableModeToggle",
        "TableModeEnable",
        "TableModeDisable",
        "Tableize",
        "TableModeRealign",
        "TableAddFormula",
        "TableEvalFormulaLine",
        "TableSort",
    },
}

return { table_mode }
