local remember = {
    'vladdoster/remember.nvim',
    config = function()
        require("remember").setup {}
    end,
}

return { remember }
