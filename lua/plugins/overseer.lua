local function cur_line_go_pkg()
    local line = vim.fn.line('.')
    local content = vim.fn.getline(line)
    local pkg = string.match(content, '"(.*)"')
    return pkg
end

local function go_get()
    local pkg = cur_line_go_pkg()
    if pkg then
        vim.cmd('OverseerRunCmd go get ' .. pkg)
    end
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
        { '<leader>ot', '<cmd>OverseerToggle<cr>', mode = 'n', silent = true,  remap = false,  desc = 'OverseerToggle' },
        { '<leader>or', '<cmd>OverseerRun<cr>',    mode = 'n', silent = true,  remap = false,  desc = 'OverseerRun' },
        { '<leader>oc', ':OverseerRunCmd ',        mode = 'n', silent = false, remap = false,  desc = 'OverseerRunCmd' },
        { '<leader>rg', go_get,                    mode = 'n', ft = 'go',      silent = false, remap = false,          desc = 'go get' },
    }
}

return { overseer }
