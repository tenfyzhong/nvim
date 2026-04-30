-- Dash documentation search commands and keymaps.

local dash = {
    "tenfyzhong/dash.nvim",
    config = function()
        require("dash").setup({
            debounce = 1,
        })
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make install",
    cmd = { "Dash", "DashWord", "DashDirect", "DashDirectWord" },
    keys = {
        { "<leader>ds", ":DashDirectWord<CR>", silent = true, remap = false, desc = "dash: search cword" },
    },
}

return { dash }
