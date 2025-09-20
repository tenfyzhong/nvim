local ui = {
    "rcarriga/nvim-dap-ui",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup({})
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end,
}

local dap = {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = { ui, "nvim-neotest/nvim-nio" },
}

return { dap }
