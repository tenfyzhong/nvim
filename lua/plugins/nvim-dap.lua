-- Debug Adapter Protocol core, UI, and virtual text integrations.

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

local virtual = {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
        require("nvim-dap-virtual-text").setup({
            virt_text_pos = "eol",
        })
    end,
    dependencies = { dap },
    event = "VeryLazy",
}

return { dap, ui, virtual }
