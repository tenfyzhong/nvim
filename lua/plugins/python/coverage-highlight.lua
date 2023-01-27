--[[
- @file coverage-highlight.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 13:30:30
--]]
local highlight = {
    'mgedmin/coverage-highlight.vim',
    config = function()
        local group = vim.api.nvim_create_augroup('coverage_highlight_init', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'python',
            callback = function()
                vim.keymap.set('n', '<leader>rc', ':HighlightCoverage', { silent = true, buffer = true, remap = false })
            end,
        })
    end,
}

return { highlight }
