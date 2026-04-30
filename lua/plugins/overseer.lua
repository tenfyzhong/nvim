-- Task runner integration, including ad hoc commands and Go helpers.

local function cur_line_go_pkg()
    local line = vim.fn.line(".")
    local content = vim.fn.getline(line)
    local pkg = string.match(content, '"(.*)"')
    return pkg
end

local function go_get()
    local pkg = cur_line_go_pkg()
    if pkg then
        vim.cmd("OverseerRunCmd go get " .. pkg)
    end
end

local overseer = {
    "stevearc/overseer.nvim",
    dependencies = { "stevearc/dressing.nvim", "nvim-telescope/telescope.nvim" },
    init = function()
        vim.cmd("cnoreabbrev O OverseerRunCmd")
    end,
    config = function()
        require("overseer").setup({
            templates = { "builtin", "custom" },
            task_list = {
                direction = "left",
                bindings = {
                    ["?"] = "ShowHelp",
                    ["g?"] = "ShowHelp",
                    ["<CR>"] = "RunAction",
                    ["<C-e>"] = "Edit",
                    ["o"] = "Open",
                    ["<C-v>"] = "OpenVsplit",
                    ["<C-s>"] = "OpenSplit",
                    ["<C-f>"] = "OpenFloat",
                    ["<C-q>"] = "OpenQuickFix",
                    ["p"] = "TogglePreview",
                    ["+"] = "IncreaseDetail",
                    ["-"] = "DecreaseDetail",
                    ["L"] = "IncreaseAllDetail",
                    ["H"] = "DecreaseAllDetail",
                    ["["] = "DecreaseWidth",
                    ["]"] = "IncreaseWidth",
                    ["{"] = "PrevTask",
                    ["}"] = "NextTask",
                    ["<C-k>"] = "ScrollOutputUp",
                    ["<C-j>"] = "ScrollOutputDown",
                    ["q"] = "Close",
                },
            },
            -- Aliases for bundles of components. Redefine the builtins, or create your own.
            component_aliases = {
                -- Most tasks are initialized with the default components
                default = {
                    { "display_duration", detail_level = 2 },
                    "on_output_summarize",
                    "on_exit_set_status",
                    { "on_complete_notify", system = "always" },
                    { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
                },
                -- Tasks from tasks.json use these components
                default_vscode = {
                    "default",
                    "on_result_diagnostics",
                },
            },
        })
    end,
    cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerSaveBundle",
        "OverseerLoadBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerRun",
        "OverseerInfo",
        "OverseerBuild",
        "OverseerQuickAction",
        "OverseerTaskAction",
        "OverseerClearCache",
    },
    keys = {
        {
            "<leader>ot",
            "<cmd>OverseerToggle<cr>",
            mode = "n",
            silent = true,
            remap = false,
            desc = "OverseerToggle",
        },
        {
            "<leader>or",
            "<cmd>OverseerRun<cr>",
            mode = "n",
            silent = true,
            remap = false,
            desc = "OverseerRun",
        },
        {
            "<leader>oc",
            ":OverseerRunCmd ",
            mode = "n",
            silent = false,
            remap = false,
            desc = "OverseerRunCmd",
        },
        {
            "<leader>rg",
            go_get,
            mode = "n",
            ft = "go",
            silent = false,
            remap = false,
            desc = "go get",
        },
    },
}

return { overseer }
