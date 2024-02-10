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
    end,
    keys = {
        { '<leader>rp', '<Plug>MarkdownPreview',     mode = { 'n' }, ft = 'markdown', remap = true, silent = true, desc = 'markdown-preview: markdown preview' },
        { '<leader>rs', '<Plug>StopMarkdownPreview', mode = { 'n' }, ft = 'markdown', remap = true, silent = true, desc = 'stop markdown preview' },
    },
}

return { markdown }
