local lazygit = {
    'kdheepak/lazygit.nvim',
    init = function()
        vim.g.lazygit_floating_window_use_plenary = 0
    end,
    config = function()
        vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>', { remap = false, silent = true, desc = 'LazyGit' })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
}

return { lazygit }
