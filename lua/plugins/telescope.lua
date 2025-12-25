local telescope_config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local action_state = require("telescope.actions.state")

    -- Helper function for buffer tags with aerial integration
    local function find_tag()
        local backends = require("aerial.backends")
        local backend = backends.get()
        if not backend then
            builtin.current_buffer_fuzzy_find()
        else
            builtin.lsp_document_symbols()
        end
    end

    -- Helper function for zoxide integration
    local function zoxide_picker()
        local handle = io.popen("zoxide query -l")
        if not handle then
            vim.notify("zoxide not available", vim.log.levels.WARN)
            return
        end

        local result = handle:read("*a")
        handle:close()

        local lines = vim.split(result, "\n", { trimempty = true })
        if #lines == 0 then
            vim.notify("No zoxide entries found", vim.log.levels.INFO)
            return
        end

        pickers
            .new({}, {
                prompt_title = "Zoxide",
                finder = finders.new_table({
                    results = lines,
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        local selection = action_state.get_current_entry()
                        if selection then
                            actions.close(prompt_bufnr)
                            local path = selection.value
                            vim.fn.chdir(path)
                            require("neo-tree.command").execute({
                                action = "focus",
                            })
                            local msg = string.format("pwd: %s", path)
                            vim.notify(msg, vim.log.levels.INFO)
                        end
                    end)
                    return true
                end,
            })
            :find()
    end

    -- Helper function for fzf-marks integration
    local function fzf_marks_picker()
        local store = os.getenv("FZF_MARKS_FILE")
        if not store then
            store = os.getenv("HOME") .. "/.fzf-marks"
        end

        local handle = io.popen("cat " .. store)
        if not handle then
            vim.notify("fzf-marks file not found", vim.log.levels.WARN)
            return
        end

        local result = handle:read("*a")
        handle:close()

        local lines = vim.split(result, "\n", { trimempty = true })
        if #lines == 0 then
            vim.notify("No fzf-marks found", vim.log.levels.INFO)
            return
        end

        pickers
            .new({}, {
                prompt_title = "FZF Marks",
                finder = finders.new_table({
                    results = lines,
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        local selection = action_state.get_current_entry()
                        if selection then
                            actions.close(prompt_bufnr)
                            local parts = vim.split(selection.value, ":")
                            if #parts < 2 then
                                return
                            end
                            local path = vim.fn.expand(parts[2])
                            vim.fn.chdir(path)
                            require("neo-tree.command").execute({
                                action = "focus",
                            })
                            local msg = string.format("pwd: %s", path)
                            vim.notify(msg, vim.log.levels.INFO)
                        end
                    end)
                    return true
                end,
            })
            :find()
    end

    -- Helper function for git worktree integration
    local function git_worktree_picker()
        local is_git = vim.trim(vim.fn.system("git rev-parse --is-inside-work-tree"))
        if is_git ~= "true" then
            vim.notify("Not inside a git repository", vim.log.levels.WARN)
            return
        end

        local cwd = vim.fn.getcwd()
        cwd = vim.fn.fnamemodify(cwd, ":p")

        local data = vim.fn.system("git worktree list")
        local lines = vim.split(data, "\n")
        local worktrees = {}
        for _, line in ipairs(lines) do
            if line ~= "" then
                local parts = vim.split(line, " ", { trimempty = true })
                if #parts >= 3 and vim.fn.fnamemodify(parts[1], ":p") ~= cwd then
                    table.insert(worktrees, line)
                end
            end
        end

        if #worktrees == 0 then
            vim.notify("No other worktrees found", vim.log.levels.INFO)
            return
        end

        local function open_worktree(cmd)
            return function(prompt_bufnr)
                local selection = action_state.get_current_entry()
                if selection then
                    actions.close(prompt_bufnr)
                    local parts = vim.split(selection.value, " ", { trimempty = true })
                    if #parts < 3 then
                        return
                    end
                    if cmd then
                        vim.cmd(cmd)
                    end
                    local path = vim.fn.expand(parts[1])
                    vim.fn.chdir(path)
                    require("neo-tree.command").execute({
                        action = "focus",
                    })
                    local msg = string.format("pwd: %s", path)
                    vim.notify(msg, vim.log.levels.INFO)
                end
            end
        end

        pickers
            .new({}, {
                prompt_title = "Git Worktrees",
                finder = finders.new_table({
                    results = worktrees,
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(open_worktree())
                    map("i", "<c-t>", open_worktree("tabnew"))
                    map("n", "<c-t>", open_worktree("tabnew"))
                    return true
                end,
            })
            :find()
    end

    -- Helper function for bookmarks integration
    local function bookmarks_picker()
        local edit_fn = function(action)
            return function(prompt_bufnr)
                local selection = action_state.get_current_entry()
                if selection then
                    actions.close(prompt_bufnr)
                    local items = vim.fn.split(selection.value, ":")
                    if #items < 2 then
                        return
                    end
                    local cmd = string.format("silent %s +%s %s", action, items[2], items[1])
                    vim.cmd(cmd)
                end
            end
        end

        local data = require("bookmarks").bookmark_data()
        local cwd = vim.fn.fnamemodify(vim.uv.cwd(), ":p")
        local feature = require("feature")
        local bookmark_lines = {}
        for _, d in ipairs(data) do
            local filename = feature.get_relative_path(d.filename, cwd)
            table.insert(bookmark_lines, string.format("%s:%s:%s", filename, d.lnum, d.text))
        end

        if #bookmark_lines == 0 then
            vim.notify("No bookmarks found", vim.log.levels.INFO)
            return
        end

        pickers
            .new({}, {
                prompt_title = "Bookmarks",
                finder = finders.new_table({
                    results = bookmark_lines,
                }),
                sorter = conf.generic_sorter({}),
                previewer = conf.generic_previewer({}),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(edit_fn("edit"))
                    map("i", "<c-x>", edit_fn("split"))
                    map("i", "<c-v>", edit_fn("vsplit"))
                    map("i", "<c-t>", edit_fn("tabedit"))
                    map("n", "<c-x>", edit_fn("split"))
                    map("n", "<c-v>", edit_fn("vsplit"))
                    map("n", "<c-t>", edit_fn("tabedit"))
                    return true
                end,
            })
            :find()
    end

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
                include_current_line = true,
                show_line = false,
            },
            lsp_definitions = {
                show_line = false,
            },
            lsp_implementations = {
                -- theme = "cursor",
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
                -- theme = "ivy",
            },
            command_history = {},
            commands = {},
            search_history = {},
            tags = {},
            marks = {},
            keymaps = {
                modes = { "n" },
            },
            quickfix = {},
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
        builtin.lsp_references()
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

    -- Go to definition (goto_definition - gd)
    vim.keymap.set("n", "gd", function()
        builtin.lsp_definitions()
    end, { silent = true, desc = "telescope: goto definition" })

    vim.keymap.set("n", "gi", function()
        builtin.lsp_implementations()
    end, { silent = true, desc = "telescope: goto implementation" })

    -- Show line diagnostics (show_line_diagnostics - <leader>ll)
    vim.keymap.set("n", "<leader>ll", function()
        builtin.diagnostics({ bufnr = 0, line_number = true })
    end, { silent = true, desc = "telescope: line diagnostics" })

    -- Show cursor diagnostics (show_cursor_diagnostics - <leader>lc)
    vim.keymap.set("n", "<leader>lc", function()
        builtin.diagnostics({ bufnr = 0 })
    end, { silent = true, desc = "telescope: cursor diagnostics" })

    -- Show buffer diagnostics (show_buf_diagnostics - <leader>lb)
    vim.keymap.set("n", "<leader>lb", function()
        builtin.diagnostics({ bufnr = nil })
    end, { silent = true, desc = "telescope: buffer diagnostics" })

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

    -- Files (files)
    vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files()
    end, { silent = true, desc = "telescope: find files" })

    -- Buffers (buffers)
    vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers()
    end, { silent = true, desc = "telescope: buffers" })

    -- Git files (git_files)
    vim.keymap.set("n", "<leader>fg", function()
        builtin.git_files()
    end, { silent = true, desc = "telescope: git files" })

    -- Grep project (grep_project)
    vim.keymap.set("n", "<leader>fr", function()
        builtin.live_grep()
    end, { silent = true, desc = "telescope: live grep" })

    -- Command history (command_history)
    vim.keymap.set("n", "<leader>f;", function()
        builtin.command_history()
    end, { silent = true, desc = "telescope: command history" })

    -- Commands (commands)
    vim.keymap.set("n", "<leader>fc", function()
        builtin.commands()
    end, { silent = true, desc = "telescope: commands" })

    -- Search history (search_history)
    vim.keymap.set("n", "<leader>f/", function()
        builtin.search_history()
    end, { silent = true, desc = "telescope: search history" })

    -- Tags (tags)
    vim.keymap.set("n", "<leader>fT", function()
        builtin.tags()
    end, { silent = true, desc = "telescope: tags" })

    -- Buffer tags with aerial integration (buffer tags)
    vim.keymap.set("n", "<leader>ft", function()
        xpcall(find_tag, function()
            builtin.current_buffer_fuzzy_find()
        end)
    end, { silent = true, desc = "telescope: buffer tags" })

    -- Marks (marks)
    vim.keymap.set("n", "<leader>fm", function()
        builtin.marks()
    end, { silent = true, desc = "telescope: marks" })

    -- Zoxide (zoxide)
    vim.keymap.set("n", "<leader>fz", function()
        zoxide_picker()
    end, { silent = true, desc = "telescope: zoxide" })

    -- FZF marks (fzf-marks)
    vim.keymap.set("n", "<leader>fs", function()
        fzf_marks_picker()
    end, { silent = true, desc = "telescope: fzf-marks" })

    -- Git worktree (git worktree)
    vim.keymap.set("n", "<leader>fw", function()
        git_worktree_picker()
    end, { silent = true, desc = "telescope: git worktree" })

    -- Bookmarks (bookmarks)
    vim.keymap.set("n", "<leader>fM", function()
        bookmarks_picker()
    end, { silent = true, desc = "telescope: bookmarks" })

    -- Keymaps (keymaps) - already exists in telescope
    vim.keymap.set("n", "<leader><leader>", function()
        builtin.keymaps()
    end, { silent = true, desc = "telescope: keymaps" })

    vim.keymap.set({ "v", "x" }, "<leader><leader>", function()
        builtin.keymaps({ modes = { "v" } })
    end, { silent = true, desc = "telescope: keymaps" })

    vim.keymap.set("n", "<leader>fq", builtin.quickfix, { silent = true, desc = "telescope: quickfix" })

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
        -- Required for custom features
        "stevearc/aerial.nvim", -- For buffer tags integration
        "tenfyzhong/bookmarks.nvim",
    },
    config = telescope_config,
    keys = {
        -- Lazy load on these keys
        -- Basic file operations
        { "<leader>ff", desc = "telescope: find files" },
        { "<leader>fg", desc = "telescope: git files" },
        { "<leader>fr", desc = "telescope: live grep" },
        { "<leader>fb", desc = "telescope: buffers" },
        { "<leader>fc", desc = "telescope: commands" },
        { "<leader>f;", desc = "telescope: command history" },
        { "<leader>f/", desc = "telescope: search history" },
        { "<leader>fm", desc = "telescope: marks" },
        { "<leader>fT", desc = "telescope: tags" },
        { "<leader>ft", desc = "telescope: buffer tags" },
        -- Custom features
        { "<leader>fz", desc = "telescope: zoxide" },
        { "<leader>fs", desc = "telescope: fzf-marks" },
        { "<leader>fw", desc = "telescope: git worktree" },
        { "<leader>fM", desc = "telescope: bookmarks" },
        { "<leader><leader>", desc = "telescope: keymaps" },
        -- LSP related
        { "gh", desc = "telescope: lsp references" },
        { "<leader>la", desc = "telescope: lsp code actions" },
        { "<leader>re", desc = "lsp: rename" },
        { "gd", desc = "telescope: goto definition" },
        { "gi", desc = "telescope: goto implementation" },
        { "<leader>ll", desc = "telescope: line diagnostics" },
        { "<leader>lc", desc = "telescope: cursor diagnostics" },
        { "<leader>lb", desc = "telescope: buffer diagnostics" },
        { "<leader>tb", desc = "aerial: toggle outline" },
        { "K", desc = "lsp: hover" },
        { "<leader>li", desc = "telescope: incoming calls" },
        { "<leader>lo", desc = "telescope: outgoing calls" },
    },
}

return { telescope }
