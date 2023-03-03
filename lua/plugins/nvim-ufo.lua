--[[
- @file nvim-ufo.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-03 15:24:32
--]]
-- local statuscol = {
--     "luukvbaal/statuscol.nvim",
--     config = function()
--         require("statuscol").setup {
--             foldfunc = "builtin",
--             setopt = true,
--         }
--     end,
-- }

local ufo = {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
        vim.o.foldcolumn = '0'
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        })
    end,
    event = 'VeryLazy',
}

return { ufo }
