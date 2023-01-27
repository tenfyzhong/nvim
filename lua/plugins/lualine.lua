--[[
- @file lualine.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 18:20:59
--]]

local lualine = {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
        require('lualine').setup()
    end,
}

return { lualine }
