-- Git diff, history, and review views.

local diffview = {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("diffview").setup({
            view = {
                merge_tool = {
                    -- Config for conflicted files in diff views during a merge or rebase.
                    layout = "diff3_horizontal",
                    disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
                    winbar_info = true, -- See |diffview-config-view.x.winbar_info|
                },
            },
            hooks = {
                view_opened = function(bufnr)
                    -- Change local options in diff buffers
                    vim.opt.wrap = false
                    vim.opt.list = false
                    -- vim.opt.colorcolumn = { vim.o.colorcolumn }
                    vim.opt.swapfile = false
                    vim.opt.bufhidden = "delete"
                end,
            },
            keymaps = {
                view = {
                    ["<leader>nt"] = "<Cmd>DiffviewToggleFiles<CR>",
                },
                file_panel = {
                    ["<leader>nt"] = "<Cmd>DiffviewToggleFiles<CR>",
                },
            },
        })
    end,
    cmd = {
        "DiffviewOpen",
        "DiffviewFileHistory",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewLog",
    },
}

return { diffview }
