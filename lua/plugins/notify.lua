local notify = {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require('notify')
        notify.setup({
            timeout = 2000,
        })
        vim.notify = notify
    end,
}

return { notify }
