--[[
- @file dash.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:54:20
--]]
if not vim.fn.has('mac') then
    return
end

local dash = {
    'rizzatti/dash.vim',
    config = function()
        vim.keymap.set('n', '<leader>ds', '<Plug>DashSearch', { silent = true, remap = true })
    end,
    cmd = { 'Dash', 'DashKeywords' },
    keys = { '<leader>ds' },
}

return { dash }
