local telescope_config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    -- Configure telescope
    telescope.setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-u>"] = actions.results_scrolling_up,
                    ["<C-d>"] = actions.results_scrolling_down,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<Esc>"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-t>"] = actions.select_tab,
                },
                n = {
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["<C-u>"] = actions.results_scrolling_up,
                    ["<C-d>"] = actions.results_scrolling_down,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<CR>"] = actions.select_default,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-t>"] = actions.select_tab,
                    ["q"] = actions.close,
                },
            },
        },
        pickers = {
            find_files = {
                hidden = true,
                follow = true,
            },
            live_grep = {
                additional_args = function()
                    return { "--hidden" }
                end,
            },
            grep_string = {
                additional_args = function()
                    return { "--hidden" }
                end,
            },
            buffers = {
                sort_lastused = true,
                ignore_current_buffer = true,
                mappings = {
                    i = {
                        ["<C-d>"] = actions.delete_buffer,
                    },
                    n = {
                        ["d"] = actions.delete_buffer,
                    },
                },
            },
            lsp_references = {
                theme = "cursor",
                layout_config = {
                    width = 0.8,
                    height = 0.8,
                },
            },
            lsp_definitions = {
                theme = "cursor",
                layout_config = {
                    width = 0.8,
                    height = 0.8,
                },
            },
            lsp_implementations = {
                theme = "cursor",
                layout_config = {
                    width = 0.8,
                    height = 0.8,
                },
            },
            lsp_document_symbols = {
                symbol_width = 60,
            },
            lsp_workspace_symbols = {
                symbol_width = 60,
            },
            diagnostics = {
                theme = "ivy",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })

    -- Load extensions
    telescope.load_extension("fzf")

    -- Key mappings for LSP functionality
    -- Finder (finder - gh)
    vim.keymap.set("n", "gh", function()
        builtin.lsp_references({
            jump_type = "never",
            include_current_line = true,
            show_line = false,
        })
    end, { silent = true, desc = "telescope: lsp references" })

    -- Code actions (code_action - <leader>la)
    vim.keymap.set({ "n", "v" }, "<leader>la", function()
        require("telescope.builtin").lsp_code_actions(themes.get_cursor({
            layout_config = {
                width = 60,
                height = 10,
            },
        }))
    end, { silent = true, desc = "telescope: lsp code actions" })

    -- Rename (rename - <leader>re)
    vim.keymap.set("n", "<leader>re", function()
        local new_name = vim.fn.input("New name: ")
        if new_name ~= "" then
            vim.lsp.buf.rename(new_name)
        end
    end, { silent = true, desc = "lsp: rename" })

    -- Peek definition (peek_definition - gD)
    vim.keymap.set("n", "gD", function()
        builtin.lsp_definitions({
            jump_type = "never",
            show_line = false,
        })
    end, { silent = true, desc = "telescope: peek definition" })

    -- Go to definition (goto_definition - gd)
    vim.keymap.set("n", "gd", function()
        builtin.lsp_definitions({
            show_line = false,
        })
    end, { silent = true, desc = "telescope: goto definition" })

    -- Show line diagnostics (show_line_diagnostics - <leader>ll)
    vim.keymap.set("n", "<leader>ll", function()
        builtin.diagnostics({
            bufnr = 0,
            line_number = true,
        })
    end, { silent = true, desc = "telescope: line diagnostics" })

    -- Show cursor diagnostics (show_cursor_diagnostics - <leader>lc)
    vim.keymap.set("n", "<leader>lc", function()
        builtin.diagnostics({
            bufnr = 0,
        })
    end, { silent = true, desc = "telescope: cursor diagnostics" })

    -- Show buffer diagnostics (show_buf_diagnostics - <leader>lb)
    vim.keymap.set("n", "<leader>lb", function()
        builtin.diagnostics({
            bufnr = nil,
        })
    end, { silent = true, desc = "telescope: buffer diagnostics" })

    -- Toggle outline (outline - <leader>lt)
    -- Using aerial which is already configured
    vim.keymap.set("n", "<leader>lt", "<cmd>AerialToggle!<CR>", { silent = true, desc = "aerial: toggle outline" })

    -- Hover doc (hover_doc - K)
    -- Using built-in LSP hover
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, { silent = true, desc = "lsp: hover" })

    -- Incoming/Outgoing calls (incoming_calls - <leader>li, outgoing_calls - <leader>lo)
    vim.keymap.set("n", "<leader>li", function()
        builtin.lsp_incoming_calls()
    end, { silent = true, desc = "telescope: incoming calls" })

    vim.keymap.set("n", "<leader>lo", function()
        builtin.lsp_outgoing_calls()
    end, { silent = true, desc = "telescope: outgoing calls" })

    -- Additional useful telescope mappings
    -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { silent = true, desc = "telescope: find files" })
    -- vim.keymap.set("n", "<leader>fg", builtin.git_files, { silent = true, desc = "telescope: git files" })
    -- vim.keymap.set("n", "<leader>fr", builtin.live_grep, { silent = true, desc = "telescope: live grep" })
    -- vim.keymap.set("n", "<leader>fb", builtin.buffers, { silent = true, desc = "telescope: buffers" })
    -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { silent = true, desc = "telescope: help tags" })
    -- vim.keymap.set("n", "<leader>fk", builtin.keymaps, { silent = true, desc = "telescope: keymaps" })
    -- vim.keymap.set("n", "<leader>fm", builtin.marks, { silent = true, desc = "telescope: marks" })
    -- vim.keymap.set("n", "<leader>fc", builtin.commands, { silent = true, desc = "telescope: commands" })
    -- vim.keymap.set("n", "<leader>f/", builtin.search_history, { silent = true, desc = "telescope: search history" })
    -- vim.keymap.set("n", "<leader>f;", builtin.command_history, { silent = true, desc = "telescope: command history" })
    -- vim.keymap.set("n", "<leader>ft", builtin.treesitter, { silent = true, desc = "telescope: treesitter symbols" })
    -- vim.keymap.set(
    --     "n",
    --     "<leader>fs",
    --     builtin.lsp_document_symbols,
    --     { silent = true, desc = "telescope: document symbols" }
    -- )
    -- vim.keymap.set(
    --     "n",
    --     "<leader>fS",
    --     builtin.lsp_workspace_symbols,
    --     { silent = true, desc = "telescope: workspace symbols" }
    -- )
    -- vim.keymap.set("n", "<leader>fq", builtin.quickfix, { silent = true, desc = "telescope: quickfix" })
    -- vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { silent = true, desc = "telescope: oldfiles" })
    -- vim.keymap.set("n", "<leader>fw", builtin.grep_string, { silent = true, desc = "telescope: grep under cursor" })

    vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function(args)
            vim.wo.number = true
        end,
    })
end

local telescope = {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "BurntSushi/ripgrep",
        { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
        },
    },
    config = telescope_config,
    keys = {
        -- Lazy load on these keys
        -- { "<leader>ff", desc = "telescope: find files" },
        -- { "<leader>fg", desc = "telescope: git files" },
        -- { "<leader>fr", desc = "telescope: live grep" },
        -- { "<leader>fb", desc = "telescope: buffers" },
        -- { "<leader>fh", desc = "telescope: help tags" },
        -- { "<leader>fk", desc = "telescope: keymaps" },
        -- { "<leader>fm", desc = "telescope: marks" },
        -- { "<leader>fc", desc = "telescope: commands" },
        -- { "<leader>f/", desc = "telescope: search history" },
        -- { "<leader>f;", desc = "telescope: command history" },
        -- { "<leader>ft", desc = "telescope: treesitter symbols" },
        -- { "<leader>fs", desc = "telescope: document symbols" },
        -- { "<leader>fS", desc = "telescope: workspace symbols" },
        -- { "<leader>fq", desc = "telescope: quickfix" },
        -- { "<leader>fo", desc = "telescope: oldfiles" },
        -- { "<leader>fw", desc = "telescope: grep under cursor" },
        -- LSP related
        { "gh", desc = "telescope: lsp references" },
        { "<leader>la", desc = "telescope: lsp code actions" },
        { "<leader>re", desc = "lsp: rename" },
        { "gD", desc = "telescope: peek definition" },
        { "gd", desc = "telescope: goto definition" },
        { "<leader>ll", desc = "telescope: line diagnostics" },
        { "<leader>lc", desc = "telescope: cursor diagnostics" },
        { "<leader>lb", desc = "telescope: buffer diagnostics" },
        { "<leader>lt", desc = "aerial: toggle outline" },
        { "K", desc = "lsp: hover" },
        { "<leader>li", desc = "telescope: incoming calls" },
        { "<leader>lo", desc = "telescope: outgoing calls" },
    },
}

return { telescope }
