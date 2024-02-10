--[[
- @file vim-table-mode.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:14:29
--]]

local table_mode = {
    'dhruvasagar/vim-table-mode',
    config = function()
        vim.g.table_mode_corner = '|'
    end,
    cmd = {
        'TableModeToggle',
        'TableModeEnable',
        'TableModeDisable',
        'Tableize',
        'TableModeRealign',
        'TableAddFormula',
        'TableEvalFormulaLine',
        'TableSort',
    },
}

return { table_mode }
