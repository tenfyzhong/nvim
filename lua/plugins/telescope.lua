-- Fuzzy finder configuration plus custom pickers for marks and worktrees.

-- Helper functions for complex key mappings (extracted to reduce keys block size)
local function fzf_marks_picker()
    local store = os.getenv("FZF_MARKS_FILE")
    if not store then
        store = os.getenv("HOME") .. "/.fzf-marks"
    end

    store = vim.fn.expand(store)

    local ok, handle = pcall(io.open, store, "r")
    if not ok or not handle then
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

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    pickers
        .new({}, {
            prompt_title = "FZF Marks",
            finder = finders.new_table({
                results = lines,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                    if not current_picker then
                        return
                    end
                    local selection = current_picker:get_selection()
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

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function open_worktree(cmd)
        return function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            if not current_picker then
                return
            end
            local selection = current_picker:get_selection()
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

local function bookmarks_picker()
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")

    local edit_fn = function(action)
        return function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            if not current_picker then
                return
            end
            local selection = current_picker:get_selection()
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

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

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

local telescope_config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

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
            aerial = {
                -- Set the width of the first two columns (the second
                -- is relevant only when show_columns is set to 'both')
                col1_width = 4,
                col2_width = 30,
                -- How to format the symbols
                format_symbol = function(symbol_path, filetype)
                    if filetype == "json" or filetype == "yaml" then
                        return table.concat(symbol_path, ".")
                    else
                        return symbol_path[#symbol_path]
                    end
                end,
                -- Available modes: symbols, lines, both
                show_columns = "symbols",
            },
        },
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("zoxide")
    telescope.load_extension("gh")
    telescope.load_extension("undo")
    telescope.load_extension("aerial")

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
        -- zoxide
        "nvim-lua/popup.nvim",
        "jvgrootveld/telescope-zoxide",

        "nvim-telescope/telescope-github.nvim",

        "debugloop/telescope-undo.nvim",
    },
    config = telescope_config,
    keys = {
        -- Lazy load on these keys
        -- Basic file operations
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "telescope: find files",
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "telescope: git files",
        },
        {
            "<leader>fr",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "telescope: live grep",
        },
        {
            "<leader>fb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "telescope: buffers",
        },
        {
            "<leader>fc",
            function()
                require("telescope.builtin").commands()
            end,
            desc = "telescope: commands",
        },
        {
            "<leader>f;",
            function()
                require("telescope.builtin").command_history()
            end,
            desc = "telescope: command history",
        },
        {
            "<leader>f/",
            function()
                require("telescope.builtin").search_history()
            end,
            desc = "telescope: search history",
        },
        {
            "<leader>fm",
            function()
                require("telescope.builtin").marks()
            end,
            desc = "telescope: marks",
        },
        {
            "<leader>fT",
            function()
                require("telescope.builtin").tags()
            end,
            desc = "telescope: tags",
        },
        {
            "<leader>ft",
            function()
                local backends = require("aerial.backends")
                local backend = backends.get()
                if not backend then
                    local builtin = require("telescope.builtin")
                    builtin.current_buffer_fuzzy_find()
                else
                    require("telescope").extensions.aerial.aerial()
                end
            end,
            desc = "telescope: buffer tags",
        },
        -- Custom features
        {
            "<leader>fz",
            function()
                require("telescope").extensions.zoxide.list()
            end,
            desc = "telescope: zoxide",
        },
        {
            "<leader>fs",
            fzf_marks_picker,
            desc = "telescope: fzf-marks",
        },
        {
            "<leader>fw",
            git_worktree_picker,
            desc = "telescope: git worktree",
        },
        {
            "<leader>fM",
            bookmarks_picker,
            desc = "telescope: bookmarks",
        },
        {
            "<leader><leader>",
            function()
                require("telescope.builtin").keymaps()
            end,
            desc = "telescope: keymaps",
            mode = "n",
        },
        {
            "<leader><leader>",
            function()
                require("telescope.builtin").keymaps({ modes = { "v" } })
            end,
            desc = "telescope: keymaps",
            mode = { "v", "x" },
        },
        {
            "<leader>fq",
            function()
                require("telescope.builtin").quickfix()
            end,
            desc = "telescope: quickfix",
        },
        {
            "<leader>ut",
            "<cmd>Telescope undo<cr>",
            desc = "telescope: undo",
        },
        -- LSP related
        {
            "gh",
            function()
                require("telescope.builtin").lsp_references()
            end,
            desc = "telescope: lsp references",
        },
        {
            "<leader>la",
            function()
                local themes = require("telescope.themes")
                require("telescope.builtin").lsp_code_actions(themes.get_cursor({
                    layout_config = {
                        width = 60,
                        height = 10,
                    },
                }))
            end,
            desc = "telescope: lsp code actions",
            mode = { "n", "v" },
        },
        {
            "<leader>re",
            function()
                local new_name = vim.fn.input("New name: ")
                if new_name ~= "" then
                    vim.lsp.buf.rename(new_name)
                end
            end,
            desc = "lsp: rename",
        },
        {
            "gd",
            function()
                require("telescope.builtin").lsp_definitions()
            end,
            desc = "telescope: goto definition",
        },
        {
            "gi",
            function()
                require("telescope.builtin").lsp_implementations()
            end,
            desc = "telescope: goto implementation",
        },
        {
            "<leader>ll",
            function()
                require("telescope.builtin").diagnostics({ bufnr = 0, line_number = true })
            end,
            desc = "telescope: line diagnostics",
        },
        {
            "<leader>lc",
            function()
                require("telescope.builtin").diagnostics({ bufnr = 0 })
            end,
            desc = "telescope: cursor diagnostics",
        },
        {
            "<leader>lb",
            function()
                require("telescope.builtin").diagnostics({ bufnr = nil })
            end,
            desc = "telescope: buffer diagnostics",
        },
        {
            "K",
            function()
                vim.lsp.buf.hover()
            end,
            desc = "lsp: hover",
        },
        {
            "<leader>li",
            function()
                require("telescope.builtin").lsp_incoming_calls()
            end,
            desc = "telescope: incoming calls",
        },
        {
            "<leader>lo",
            function()
                require("telescope.builtin").lsp_outgoing_calls()
            end,
            desc = "telescope: outgoing calls",
        },
    },
}

return { telescope }
