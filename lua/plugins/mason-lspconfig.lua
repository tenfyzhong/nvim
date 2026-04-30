-- Mason-to-lspconfig bridge for installed language servers.

local lsp = {
    "neovim/nvim-lspconfig",
}

local mason_lspconfig = {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({})
    end,
    dependencies = {
        "williamboman/mason.nvim",
        lsp,
    },
}

return { mason_lspconfig }
