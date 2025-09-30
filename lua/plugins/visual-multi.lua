local multi = {
    "mg979/vim-visual-multi",
    config = function()
        vim.g.VM_show_warnings = 0
    end,
    keys = { "<C-n>" },
    cmd = { "VMDebug", "VMClear", "VMRegisters", "VMSearch", "VMLive" },
}

return { multi }
