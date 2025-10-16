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
                    vim.opt.colorcolumn = { 80 }
                    vim.opt.swapfile = false
                    vim.opt.bufhidden = "delete"
                end,
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
