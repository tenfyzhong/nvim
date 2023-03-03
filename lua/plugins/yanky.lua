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
        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
        vim.keymap.set("n", "'yn", "<Plug>(YankyCycleForward)")
        vim.keymap.set("n", "'yp", "<Plug>(YankyCycleBackward)")
    end,
    event = 'VeryLazy',
}

return { yanky }
