local function clean_streamed_data(data)
    if type(data) == "table" then
        return data.body
    end
    local find_json_start = string.find(data, "{") or 1
    return string.sub(data, find_json_start)
end

local function handle_chat_output(self, data)
    local output = {}
    if data and data ~= "" then
        local data_mod = clean_streamed_data(data)
        local ok, json = pcall(vim.json.decode, data_mod, { luanil = { object = true } })
        if ok and json.choices and #json.choices > 0 then
            local choice = json.choices[1]
            local delta = (self.opts and self.opts.stream) and choice.delta or choice.message
            if delta then
                output.role = delta.role or nil
                output.content = (delta.reasoning_content or "") .. (delta.content or "")
                return { status = "success", output = output }
            end
        end
    end
end

local function deepseek_adapter(name, formatted_name, model_name)
    return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
            url = os.getenv("DEEPSEEK_API_URL"),
            api_key = os.getenv("DEEPSEEK_API_KEY"),
            chat_url = os.getenv("DEEPSEEK_CHAT_URL"),
        },
        name = name,
        formatted_name = formatted_name,
        handlers = {
            chat_output = handle_chat_output,
        },
        schema = {
            model = {
                default = model_name,
            },
            temperature = {
                order = 2,
                mapping = "parameters",
                type = "number",
                optional = true,
                default = 0.0,
                desc =
                "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
                validate = function(n)
                    return n >= 0 and n <= 2, "Must be between 0 and 2"
                end,
            },
        },
    })
end

local function deepseek_adapter_v3()
    return deepseek_adapter("deepseek_v3", "Deepseek-V3", os.getenv("DEEPSEEK_MODEL_V3_ID"))
end

local function deepseek_adapter_r1()
    return deepseek_adapter("deepseek_r1", "Deepseek-R1", os.getenv("DEEPSEEK_MODEL_R1_ID"))
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
                deepseek_r1 = deepseek_adapter_r1,
                deepseek_v3 = deepseek_adapter_v3,
            },
            strategies = {
                chat = {
                    adapter = "deepseek_r1",
                },
                inline = {
                    adapter = "deepseek_r1",
                },
            },
            opts = {
                language = "Chinese",
            },
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}

return { codecompanion }
