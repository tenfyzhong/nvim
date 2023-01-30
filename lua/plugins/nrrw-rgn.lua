--[[
- @file nrrw-rgn.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 21:42:38
--]]
local nrrw = {
    'chrisbra/NrrwRgn',
    keys = { '<leader>nr', { 'v', '<leader>nr' }, { 'v', '<leader>Nr' } },
    cmd = { 'NR', 'NarrowRegion', 'NW', 'NarrowWindow', 'WR', 'WidenRegion', 'NRV', 'NUD', 'NRPrepare', 'NRP',
        'NRUnprepare', 'NRM', 'NRMulti', 'NRS', 'NRSyncOnWrite', 'NRN', 'NRNoSyncOnWrite', 'NRL', }
}

return { nrrw }
