local function ark_adapter()
    return require("codecompanion.adapters").extend("openai", {
        url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
        env = {
            api_key = function()
                return os.getenv("ARK_API_KEY")
            end,
        },
        name = "ark",
        formatted_name = "ARK",
        schema = {
            model = {
                order = 1,
                mapping = "parameters",
                type = "enum",
                desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
                default = "deepseek-v3-2-251201",
                choices = {
                    ["deepseek-v3-2-251201"] = {
                        formatted_name = "deepseek-v3.2",
                        opts = { has_function_calling = true, has_vision = false, can_reason = true },
                    },
                },
            },
        },
    })
end

local codecompanion = {
    "olimorris/codecompanion.nvim",
    config = function()
        require("codecompanion").setup({
            display = {
                chat = {
                    icons = {
                        chat_context = "📎️", -- You can also apply an icon to the fold
                        chat_fold = " ",
                    },
                    fold_context = true,
                    fold_reasoning = true,
                    show_reasoning = true,
                },
            },
            adapters = {
                acp = {
                    gemini_cli = function()
                        return require("codecompanion.adapters").extend("gemini_cli", {
                            opts = {
                                show_presets = false,
                            },
                            defaults = {
                                auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
                            },
                        })
                    end,
                },
                http = {
                    opts = {
                        show_presets = false,
                        show_model_choices = true,
                    },
                    ark = ark_adapter,
                },
            },
            interactions = {
                chat = {
                    adapter = {
                        name = "ark",
                        model = "deepseek-v3-2-251201",
                    },
                    slash_commands = {
                        ["file"] = {
                            -- Use Telescope as the provider for the /file command
                            opts = {
                                provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                            },
                        },
                    },
                },
                inline = {
                    adapter = {
                        name = "ark",
                        model = "deepseek-v3-2-251201",
                    },
                    keymaps = {
                        accept_change = {
                            modes = { n = "gda" }, -- Remember this as DiffAccept
                        },
                        reject_change = {
                            modes = { n = "gdr" }, -- Remember this as DiffReject
                        },
                        always_accept = {
                            modes = { n = "gdy" }, -- Remember this as DiffYolo
                        },
                    },
                },
                cmd = {
                    adapter = {
                        name = "ark",
                        model = "deepseek-v3-2-251201",
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
    cmd = { "CodeCompanion", "CodeCompanionCmd", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
        {
            "<leader>cc",
            ":CodeCompanionChat Toggle<cr>",
            silent = true,
            remap = false,
            desc = "codecompanion: CodeCompanionChat",
        },
        {
            "<leader>ca",
            ":CodeCompanionActions<cr>",
            silent = true,
            remap = false,
            desc = "codecompanion: CodeCompanionActions",
        },
    },
}

return { codecompanion }
