--[[
- @file rust.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 18:59:21
--]]

local rust = {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
        vim.g.rustfmt_autosave = 0
        vim.g.rustfmt_fail_silently = 1

        local group = vim.api.nvim_create_augroup('rust_init', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'rust',
            callback = function()
                vim.keymap.set('n', '<leader>rr',
                    function()
                        vim.cmd('RustRun')
                    end, { buffer = true, silent = true, remap = false })
            end,
        })
    end
}

return { rust }
