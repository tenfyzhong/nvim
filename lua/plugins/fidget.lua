-- LSP progress notifications.

local fidget = {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({})
    end,
    event = "LspAttach",
}

return { fidget }
