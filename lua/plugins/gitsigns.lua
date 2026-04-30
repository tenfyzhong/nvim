-- Git hunk signs, staging, and blame helpers.

local function gitsigns_config()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- The definition has been moved to nvim-treesitter
            -- Navigation
            -- map("n", "]h", function()
            --     if vim.wo.diff then
            --         return "]c"
            --     end
            --     vim.schedule(function()
            --         gs.next_hunk()
            --     end)
            --     return "<Ignore>"
            -- end, { expr = true })
            --
            -- map("n", "[h", function()
            --     if vim.wo.diff then
            --         return "[c"
            --     end
            --     vim.schedule(function()
            --         gs.prev_hunk()
            --     end)
            --     return "<Ignore>"
            -- end, { expr = true })

            -- Actions
            map("n", "<leader>ga", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "gitsigns: stage hunk" })
            map(
                "n",
                "<leader>gu",
                ":Gitsigns undo_stage_hunk<CR>",
                { silent = true, desc = "gitsigns: undo stage hunk" }
            )
            map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, desc = "gitsigns: reset stage hunk" })
            map("n", "<leader>gA", ":Gitsigns stage_buffer<CR>", { silent = true, desc = "gitsigns: stage buffer" })
            map(
                "n",
                "<leader>gU",
                ":Gitsigns reset_buffer_index<CR>",
                { silent = true, desc = "gitsigns: reset buffer index" }
            )
            map("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { silent = true, desc = "gitsigns: reset buffer" })
            map("n", "<leader>gp", gs.preview_hunk, { silent = true, desc = "gitsigns: preview hunk" })
            map("n", "<leader>gb", function()
                gs.blame_line({ full = true })
            end, { silent = true, desc = "gitsigns: blame line" })
        end,
    })
end

local gitsigns = {
    "lewis6991/gitsigns.nvim",
    config = gitsigns_config,
    event = "VeryLazy",
}
return { gitsigns }
