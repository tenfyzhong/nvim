--[[
- @file diffview.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-22 20:17:50
--]]

local diffview = {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
        require('diffview').setup {
            view = {
                merge_tool = {
                    -- Config for conflicted files in diff views during a merge or rebase.
                    layout = 'diff3_mixed',
                    disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
                    winbar_info = true, -- See |diffview-config-view.x.winbar_info|
                },
            }
        }
    end,
}

return { diffview }
