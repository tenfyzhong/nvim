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
        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)",
            { silent = true, remap = true, desc = 'yanky: yank put after' })
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)",
            { silent = true, remap = true, desc = 'yanky: yank put before' })
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)",
            { silent = true, remap = true, desc = 'yanky: yank gput after' })
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)",
            { silent = true, remap = true, desc = 'yanky: yank gput after' })
        vim.keymap.set("n", "'yn", "<Plug>(YankyCycleForward)",
            { silent = true, remap = true, desc = 'yanky: cycle forward' })
        vim.keymap.set("n", "'yp", "<Plug>(YankyCycleBackward)",
            { silent = true, remap = true, desc = 'yanky: cycle backward' })
    end,
    event = 'VeryLazy',
}

return { yanky }
