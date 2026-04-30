-- Surround text objects with pairs and tags.

local surround = {
    "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({})
    end,
    event = "VeryLazy",
}
return { surround }
