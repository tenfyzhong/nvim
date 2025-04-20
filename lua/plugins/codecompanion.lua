---Output the data from the API ready for insertion into the chat buffer
---@param self CodeCompanion.Adapter
---@param data table The streamed JSON data from the API, also formatted by the format_data handler
---@return { status: string, output: { role: string, content: string, reasoning: string? } } | nil
local function chat_output(self, data)
    local output = {}

    local utils = require("codecompanion.utils.adapters")

    if data and data ~= "" then
        local data_mod = utils.clean_streamed_data(data)
        local ok, json = pcall(vim.json.decode, data_mod, { luanil = { object = true } })

        if ok and json.choices and #json.choices > 0 then
            local choice = json.choices[1]
            local delta = (self.opts and self.opts.stream) and choice.delta or choice.message

            if delta then
                output.role = nil
                if delta.role then
                    output.role = delta.role
                end
                if delta.reasoning_content then
                    output.reasoning = delta.reasoning_content
                end
                if delta.content and delta.content ~= "" then
                    output.content = (output.content or "") .. delta.content
                end
                return {
                    status = "success",
                    output = output,
                }
            end
        end
    end
end

local function deepseek_adapter_ark(name, formatted_name, model_id, can_reason)
    return require("codecompanion.adapters").extend("deepseek", {
        url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
        env = {
            api_key = os.getenv("DEEPSEEK_API_KEY"),
        },
        name = name,
        formatted_name = formatted_name,
        handlers = {
            chat_output = chat_output,
        },
        schema = {
            model = {
                default = model_id,
                choices = {
                    [model_id] = { opts = { can_reason = can_reason } },
                },
            },
        },
    })
end

local function deepseek_adapter_ark_r1()
    return deepseek_adapter_ark("deepseek_r1", "DeepSeek-R1", os.getenv("DEEPSEEK_MODEL_R1_ID"), true)
end

local function deepseek_adapter_ark_v3()
    return deepseek_adapter_ark("deepseek_v3", "DeepSeek-V3", os.getenv("DEEPSEEK_MODEL_V3_ID"), false)
end

local codecompanion = {
    "olimorris/codecompanion.nvim",
    config = function()
        require('codecompanion').setup({
            display = {
                chat = {
                    icons = {
                        pinned_buffer = " ",
                        watched_buffer = "👀 ",
                    },
                },
                token_count = function(tokens, adapter)
                    return " (" .. tokens .. " tokens)"
                end,
            },
            adapters = {
                opts = {
                    show_defaults = false,
                },
                deepseek_r1 = deepseek_adapter_ark_r1,
                deepseek_v3 = deepseek_adapter_ark_v3,
            },
            strategies = {
                chat = {
                    adapter = "deepseek_v3",
                },
                inline = {
                    adapter = "deepseek_v3",
                    keymaps = {
                        accept_change = {
                            modes = { n = "ga" },
                            description = "Accept the suggested change",
                        },
                        reject_change = {
                            modes = { n = "gr" },
                            description = "Reject the suggested change",
                        },
                    },
                },
            },
            -- opts = {
            --     language = "Chinese",
            -- },
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = { 'CodeCompanion', 'CodeCompanionCmd', 'CodeCompanionChat', 'CodeCompanionActions' },
    keys = {
        { '<leader>cc', ':CodeCompanionChat Toggle<cr>', silent = true, remap = false, desc = 'codecompanion: CodeCompanionChat' },
        { '<leader>ca', ':CodeCompanionActions<cr>',     silent = true, remap = false, desc = 'codecompanion: CodeCompanionActions' },
    }
}

return { codecompanion }
