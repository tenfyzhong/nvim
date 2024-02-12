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
        require('overseer').setup({
            templates = { 'builtin', 'custom' },
        })
    end,
    cmd = {
        'OverseerOpen',
        'OverseerClose',
        'OverseerToggle',
        'OverseerSaveBundle',
        'OverseerLoadBundle',
        'OverseerDeleteBundle',
        'OverseerRunCmd',
        'OverseerRun',
        'OverseerInfo',
        'OverseerBuild',
        'OverseerQuickAction',
        'OverseerTaskAction',
        'OverseerClearCache',
    },
    keys = {
        { '<leader>ot', '<cmd>OverseerToggle<cr>', mode = 'n', silent = true, remap = false, desc = 'OverseerToggle' },
        { '<leader>rg', go_get,                    mode = 'n', ft = 'go',     silent = true, remap = false,          desc = 'go get' },
    }
}

return { overseer }
