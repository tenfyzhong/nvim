--[[
- @file asyncrun.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:07:59
--]]

local asyncrun = {
    'skywind3000/asyncrun.vim',
    setup = function()
        local group = vim.api.nvim_create_augroup('asyncrun_init', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'AsyncRunStop',
            callback = function()
                vim.fn['asyncrun#quickfix_toggle'](8)
            end,
        })
    end,
}

return { asyncrun }
