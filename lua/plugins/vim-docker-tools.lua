--[[
- @file vim-docker-tools.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 19:16:07
--]]
local docker = {
    'kkvh/vim-docker-tools',
    config = function()
        vim.g.dockertools_default_all = 0
    end
}

return { docker }
