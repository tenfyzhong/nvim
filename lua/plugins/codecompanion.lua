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

local function deepseek_adapter(url, api_key, name, formatted_name, model_id, can_reason)
    return require("codecompanion.adapters").extend("deepseek", {
        url = url,
        env = {
            api_key = api_key,
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

local function xai_adapter(name, formatted_name, model_id, can_reason)
    return require("codecompanion.adapters").extend("xai", {
        env = {
            api_key = os.getenv("CODECOMPANION_XAI_API_KEY")
        },
        handlers = {
            chat_output = chat_output,
        },
        name = name,
        formatted_name = formatted_name,
        schema = {
            model = {
                -- default = "grok-3-beta",
                default = model_id,
                choices = {
                    [model_id] = { opts = { can_reason = can_reason } },
                },
            },
        }
    })
end

local function gemini_adapter()
    return require("codecompanion.adapters").extend("gemini", {
        env = {
            api_key = os.getenv("GEMINI_API_KEY")
        },
        schema = {
            model = {
                default = "gemini-2.0-flash",
            },
        }
    })
end

-- provider: ARK/OPENROUTER
-- model_type: R1/V3
-- can_reason: true/false
local function deepseek_adapter_gen(provider, model_type, can_reason)
    local env_url = provider .. "_DEEPSEEK_API_URL"
    local env_key = provider .. "_DEEPSEEK_API_KEY"
    local env_model = provider .. "_DEEPSEEK_MODEL_ID_" .. model_type
    local url = os.getenv(env_url)
    local key = os.getenv(env_key)
    local model_id = os.getenv(env_model)

    local name = "DeepSeek-" .. model_type
    local formatted_name = provider .. "-DeepSeek-" .. model_type

    return deepseek_adapter(url, key, name, formatted_name, model_id, can_reason)
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
                    show_model_choices = false,
                },
                ark_deepseek_r1 = deepseek_adapter_gen("ARK", "R1", true),
                ark_deepseek_v3 = deepseek_adapter_gen("ARK", "V3", false),
                grok_3 = xai_adapter("XAI-Grok-3", "XAI-Grok-3", "grok-3-beta", false),
                grok_3_mini = xai_adapter("XAI-Grok-mini-3", "XAI-Grok-Mini-3", "grok-3-mini-beta", true),
                gemini = gemini_adapter(),
            },
            strategies = {
                chat = {
                    adapter = "ark_deepseek_v3",
                },
                inline = {
                    adapter = "ark_deepseek_v3",
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
