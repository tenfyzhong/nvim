--[[
- @file nvim-lastplace.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-07 10:24:45
--]]

local lastplace = {
    'ethanholz/nvim-lastplace',
    config = function()
        require 'nvim-lastplace'.setup {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true
        }
    end,
}

return { lastplace }
