--[[
- @file neogit.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2024-04-08 11:16:27
--]]

local neogit = {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    init = function()
        vim.cmd('cab Git Neogit')
    end,
    cmd = { 'Neogit', 'NeogitResetState' },
    keys = {
        { '<leader>gc', ':Neogit commit<CR>', silent = true, remap = false, desc = 'neogit: git commit' },
    }
}

return { neogit }
