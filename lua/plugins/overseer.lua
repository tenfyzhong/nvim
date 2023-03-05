local function cur_line_go_pkg()
    local line = vim.fn.line('.')
    local content = vim.fn.getline(line)
    local pkg = string.match(content, '"(.*)"')
    return pkg
end

local function go_get()
    local pkg = cur_line_go_pkg()
    vim.cmd('OverseerRunCmd go get ' .. pkg)
end

local overseer = {
    'stevearc/overseer.nvim',
    dependencies = { 'stevearc/dressing.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
        require('overseer').setup()

        vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<cr>',
            { silent = true, remap = false, desc = 'OverseerToggle' })

        local group = vim.api.nvim_create_augroup('overseer_init', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'go',
            callback = function()
                vim.keymap.set('n', '<leader>rg', go_get, { silent = true, remap = false, desc = 'go get' })
            end,
        })
    end,
    event = 'VeryLazy',
}

return { overseer }
