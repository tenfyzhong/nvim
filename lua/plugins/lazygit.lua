local lazygit = {
    'kdheepak/lazygit.nvim',
    init = function()
        vim.g.lazygit_floating_window_use_plenary = 0
    end,
    config = function()
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>lg', '<cmd>LazyGit<CR>', remap = false, silent = true, desc = 'LazyGit' },
    },
    cmd = { 'LazyGit' },
}

return { lazygit }
