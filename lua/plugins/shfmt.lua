local shfmt = {
    'yuchanns/shfmt.nvim',
    config = function()
        require("shfmt").setup({
            -- Default configs
            cmd = "shfmt",
            args = { "-l", "-w" },
            auto_format = true,
        })

        -- local init_group = vim.api.nvim_create_augroup('shfmt_init', {})
        -- vim.api.nvim_create_autocmd('BufWritePre', {
        --     group = init_group,
        --     pattern = '*',
        --     callback = function()
        --         if vim.bo.filetype == 'sh' or vim.bo.filetype == 'bash' then
        --         end
        --     end
        -- })

    end,
    -- event = 'VeryLazy',
    ft = { 'bash', 'sh' }
}

return { shfmt }
