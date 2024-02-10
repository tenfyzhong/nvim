--[[
- @file yanky.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-03 12:04:27
--]]

local yanky = {
    'gbprod/yanky.nvim',
    config = function()
        require("yanky").setup {}
    end,
    keys = {
        { "p",   "<Plug>(YankyPutAfter)",      mode = { "n", "x" }, silent = true, remap = true, desc = 'yanky: yank put after' },
        { "P",   "<Plug>(YankyPutBefore)",     mode = { "n", "x" }, silent = true, remap = true, desc = 'yanky: yank put before' },
        { "gp",  "<Plug>(YankyGPutAfter)",     mode = { "n", "x" }, silent = true, remap = true, desc = 'yanky: yank gput after' },
        { "gP",  "<Plug>(YankyGPutBefore)",    mode = { "n", "x" }, silent = true, remap = true, desc = 'yanky: yank gput after' },
        { "'yn", "<Plug>(YankyCycleForward)",  mode = { "n" },      silent = true, remap = true, desc = 'yanky: cycle forward' },
        { "'yp", "<Plug>(YankyCycleBackward)", mode = { "n" },      silent = true, remap = true, desc = 'yanky: cycle backward' },
    },
}

return { yanky }
