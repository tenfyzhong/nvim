local function ark_adapter()
    return require("codecompanion.adapters").extend("deepseek", {
        url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
        env = {
            api_key = function()
                local key = os.getenv("ARK_API_KEY")
                if not key or key == "" then
                    vim.notify_once("ARK_API_KEY environment variable is not set", vim.log.levels.ERROR)
                    return ""
                end
                return key
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
                default = "kimi-k2-thinking-251104",
                choices = {
                    ["kimi-k2-thinking-251104"] = {
                        formatted_name = "kimi-k2",
                        opts = { has_function_calling = true, has_vision = false, can_reason = true },
                    },
                    ["deepseek-v3-2-251201"] = {
                        formatted_name = "deepseek-v3.2",
                        opts = { has_function_calling = true, has_vision = false, can_reason = true },
                    },
                },
            },
        },
        handlers = {
            parse_message_meta = function(self, data)
                local extra = data.extra
                if not extra then
                    return data
                end

                local reasoning = extra.reasoning_content or extra.reasoning
                if reasoning then
                    data.output.reasoning = { content = reasoning }
                    if data.output.content == "" then
                        data.output.content = nil
                    end
                end
                return data
            end,
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
            prompt_library = {
                markdown = {
                    dirs = {
                        vim.fn.getcwd() .. "/.prompts", -- Can be relative
                        "~/.config/prompts", -- Or absolute paths
                    },
                },
            },
            rules = {
                default = {
                    description = "Collection of common files for all projects",
                    files = {
                        ".clinerules",
                        ".cursorrules",
                        ".goosehints",
                        ".rules",
                        ".windsurfrules",
                        ".github/copilot-instructions.md",
                        "AGENT.md",
                        "AGENTS.md",
                        { path = "CLAUDE.md", parser = "claude" },
                        { path = "CLAUDE.local.md", parser = "claude" },
                        { path = "~/.claude/CLAUDE.md", parser = "claude" },
                    },
                    is_preset = true,
                },
                project_rules = {
                    description = "Rule files for Projects",
                    files = {
                        -- Specify dirs to search in (supports glob patterns and literals)
                        {
                            path = vim.fn.getcwd(),
                            files = { ".clinerules", ".cursorrules" },
                        },
                        {
                            path = "~/.config/rules",
                            files = "*.md",
                        },

                        -- Mix with literal file paths
                        "~/.claude/CLAUDE.md",
                        "CLAUDE.md",
                        "CLAUDE.local.md",
                    },
                },
                opts = {
                    chat = {
                        enabled = true,
                        default_rules = "default", -- The rule groups to load
                        autoload = "project_rules",
                    },
                },
            },
            adapters = {
                acp = {
                    opts = {
                        show_presets = false,
                    },
                    gemini_cli = function()
                        return require("codecompanion.adapters").extend("gemini_cli", {
                            defaults = {
                                auth_method = "oauth-personal",
                            },
                        })
                    end,
                },
                http = {
                    opts = {
                        show_presets = false,
                        show_model_choices = false,
                    },
                    ark = ark_adapter,
                },
            },
            interactions = {
                chat = {
                    adapter = {
                        name = "ark",
                        model = "kimi-k2-thinking-251104",
                    },
                    slash_commands = {
                        ["file"] = {
                            -- Use Telescope as the provider for the /file command
                            opts = {
                                provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                            },
                        },
                    },
                    roles = {
                        llm = function(adapter)
                            local model = adapter.schema.model.default
                            local model_opts = adapter.schema.model.choices[model]
                            local name = model
                            if model_opts then
                                name = model_opts.formatted_name or name
                            end
                            return adapter.formatted_name .. "(" .. name .. ")"
                        end,
                    },
                },
                inline = {
                    adapter = {
                        name = "ark",
                        model = "kimi-k2-thinking-251104",
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
                        model = "kimi-k2-thinking-251104",
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
