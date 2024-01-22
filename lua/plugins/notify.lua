local notify = {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require('notify')
        notify.setup({
            timeout = 1000,
            render = 'wrapped-compact',
            level = 2,
        })
        vim.notify = notify
    end,
}

return { notify }
