--[[
- @file nvim-dap.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-09 09:53:53
--]]

local ui = {
    'rcarriga/nvim-dap-ui',
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        dapui.setup {}
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
}

local dap = {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = { ui },
}


return { dap }
