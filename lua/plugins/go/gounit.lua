--[[
- @file gounit.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:54:40
--]]

local function install()
    local config_path = vim.fn.stdpath('config')
    vim.cmd('GoUnitInstallBinaries')
    vim.cmd('GoUnitTemplateAdd ' .. config_path .. '/resource/gounit/gomock')
end

local function config()
    local group = vim.api.nvim_create_augroup('gounit_local', {})
    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'go',
        callback = function()
            vim.keymap.set('n', '<leader>rtg', ':normal vaf<cr>:GoUnit<cr>', {
                remap = false,
                buffer = true,
                desc = 'gounit: GoUnit'
            })
        end,
    })
end

local gounit = {
    'hexdigest/gounit-vim',
    run = install,
    config = config,
    ft = 'go',
}

return { gounit }
