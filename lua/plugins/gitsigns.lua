--[[
- @file gitsigns.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 08:51:22
--]]

local function gitsigns_config()
    require('gitsigns').setup {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']h', function()
                if vim.wo.diff then return ']h' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            map('n', '[h', function()
                if vim.wo.diff then return '[h' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            -- Actions
            map('n', '<leader>ga', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'gitsigns: stage hunk' })
            map('n', '<leader>gr', gs.undo_stage_hunk, { silent = true, desc = 'gitsigns: undo stage hunk' })
            map('n', '<leader>gp', gs.preview_hunk, { silent = true, desc = 'gitsigns: preview hunk' })
            map('n', '<leader>gb', function() gs.blame_line { full = true } end,
                { silent = true, desc = 'gitsigns: blame line' })
        end
    }
end

local gitsigns = {
    'lewis6991/gitsigns.nvim',
    config = gitsigns_config,
    event = 'VeryLazy',
}
return { gitsigns }
