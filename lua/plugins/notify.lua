-- Enhanced notification UI for `vim.notify`.

local notify = {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            timeout = 3000,
            render = "wrapped-compact",
            level = vim.log.levels.INFO,
        })
        vim.notify = notify
    end,
    event = "VeryLazy",
}

return { notify }
