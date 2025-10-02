local dap = {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
}

local ui = {
    "rcarriga/nvim-dap-ui",
    dependencies = { dap, "nvim-neotest/nvim-nio" },
    event = "VeryLazy",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}

return { dap, ui }
