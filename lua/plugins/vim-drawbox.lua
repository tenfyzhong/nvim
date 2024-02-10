--[[
- @file vim-drawbox.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 08:30:19
--]]

local boxdraw = {
    'tenfyzhong/vim-boxdraw',
    dependencies = { 'tenfyzhong/mode.vim' },
    cmd = { 'BoxdrawEnable', 'BoxdrawDisable', 'BoxdrawToggle' },
}
return { boxdraw }
