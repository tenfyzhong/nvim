--[[
- @file markdown-preview.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 12:16:14
--]]

local markdown = {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_auto_close = 0
        if vim.fn.has('macunix') then
            vim.g.mkdp_path_to_chrome = "open -a Google\\ Chrome"
        end

        local group = vim.api.nvim_create_augroup('markdown_preview_init', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'markdown',
            callback = function()
                vim.keymap.set('n', '<leader>rp', '<Plug>MarkdownPreview',
                    { buffer = true, remap = true, silent = true, desc = 'markdown-preview: markdown preview' })
                vim.keymap.set('n', '<leader>rs', '<Plug>StopMarkdownPreview',
                    { buffer = true, remap = true, silent = true, desc = 'stop markdown preview' })
            end,
        })
    end,
}

return { markdown }
