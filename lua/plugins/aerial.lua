-- Symbols outline and navigation for the current buffer.

local function aerial_config()
    -- Call the setup function to change the default behavior
    require("aerial").setup({
        -- Priority list of preferred backends for aerial.
        -- This can be a filetype map (see :help aerial-filetype-map)
        backends = {
            ["_"] = { "treesitter", "lsp", "markdown", "man" },
            make = { "treesitter", "lsp" },
            markdown = { "treesitter", "lsp", "markdown" },
            man = { "treesitter", "lsp", "man" },
        },

        -- When true, don't load aerial until a command or function is called
        -- Defaults to true, unless `on_attach` is provided, then it defaults to false
        lazy_load = false,

        -- Highlight the symbol in the source buffer when cursor is in the aerial win
        highlight_on_hover = true,

        -- Show box drawing characters for the tree hierarchy
        show_guides = true,
    })

    vim.keymap.set({ "n" }, "<leader>tb", "<cmd>AerialToggle!<CR>", { silent = true, desc = "aerial: AerialToggle" })
end

local aerial = {
    "stevearc/aerial.nvim",
    config = aerial_config,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

return { aerial }
