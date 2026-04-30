-- Restore cursor positions when reopening files.

local remember = {
    "vladdoster/remember.nvim",
    config = function()
        require("remember").setup({})
    end,
}

return { remember }
