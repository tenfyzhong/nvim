vim.api.nvim_create_user_command("XXD", function()
    require("feature").xxd()
end, { desc = "Use xxd to edit the current buffer" })
