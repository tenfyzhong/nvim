--[[
- @file command.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2024-04-29 21:00:34
--]]


vim.api.nvim_create_user_command('XXD', function()
        require('feature').xxd()
    end,
    { desc = "Use xxd to edit the current buffer" })
