--[[
- @file nrrw-rgn.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:42:38
--]]
local nrrw = {
    'chrisbra/NrrwRgn',
    cmd = { "NR", "NW", "WR", "NRV", "NUD", "NRP", "NRM", "NRS", "NRN", "NRL", },
    keys = {
        { '<Leader>nr', mode = 'x' },
    }
}

return { nrrw }
