--[[
- @file godoctor.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 11:56:31
--]]

local godoctor = {
    'godoctor/godoctor.vim',
    run = function()
        vim.cmd('GoDoctorInstall')
    end
}

return { godoctor }
