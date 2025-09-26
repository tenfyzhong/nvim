local fzf = {
    "junegunn/fzf",
    build = ":call fzf#install()",
    lazy = true,
}

local function find_tag()
    local backends = require("aerial.backends")
    local backend = backends.get()
    if not backend then
        require("fzf-lua").blines()
    else
        require("aerial").fzf_lua_picker({
            fzf_opts = {
                ["--layout"] = "reverse",
            },
            keymap = {
                fzf = {
                    load = "top",
                },
            },
        })
    end
end

local fzf_lua = {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons", fzf },
    config = function()
        local fzf_lua = require("fzf-lua")
        fzf_lua.setup({
            "hide",
            actions = {
                files = {
                    true,
                    ["ctrl-x"] = fzf_lua.actions.file_split,
                },
            },
            buffers = {
                actions = {
                    ["ctrl-x"] = fzf_lua.actions.file_split,
                    ["ctrl-d"] = { fn = fzf_lua.actions.buf_del, reload = true },
                },
            },
        })
    end,
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: files",
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: buffers",
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").git_files()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: git_files",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").grep_project()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: grep_project",
        },
        {
            "<leader>f;",
            function()
                require("fzf-lua").command_history()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: command_history",
        },
        {
            "<leader>fc",
            function()
                require("fzf-lua").commands()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: commands",
        },
        {
            "<leader>f/",
            function()
                require("fzf-lua").search_history()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: search_history",
        },
        {
            "<leader>fT",
            function()
                require("fzf-lua").tags()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: tags",
        },
        {
            "<leader>ft",
            function()
                xpcall(find_tag, function()
                    require("fzf-lua").blines()
                end)
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: buffer tags",
        },
        {
            "<leader>fm",
            function()
                require("fzf-lua").marks()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: marks",
        },
        {
            "<leader>fz",
            function()
                require("fzf-lua").zoxide()
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: zoxide",
        },
        {
            "<leader>fs",
            function()
                local store = os.getenv("FZF_MARKS_FILE")
                if not store then
                    store = os.getenv("HOME") .. "/.fzf-marks"
                end
                require("fzf-lua").fzf_exec("cat " .. store, {
                    actions = {
                        ["default"] = function(selected)
                            if not selected then
                                return
                            end

                            local parts = vim.split(selected[1], ":")
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
                        end,
                    },
                })
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: fzf-marks",
        },
        {
            "<leader>fw",
            function()
                local open_fn = function(cmd)
                    return function(selected)
                        if not selected then
                            return
                        end

                        local parts = vim.split(selected[1], " ", { trimempty = true })
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
                require("fzf-lua").fzf_exec(function(fzf_cb)
                    local is_git = vim.trim(vim.fn.system("git rev-parse --is-inside-work-tree"))
                    if is_git ~= "true" then
                        return
                    end

                    local cwd = vim.fn.getcwd()
                    cwd = vim.fn.fnamemodify(cwd, ":p")

                    local data = vim.fn.system("git worktree list")
                    local lines = vim.split(data, "\n")
                    for _, line in ipairs(lines) do
                        if line ~= "" then
                            local parts = vim.split(line, " ", { trimempty = true })
                            if #parts >= 3 and vim.fn.fnamemodify(parts[1], ":p") ~= cwd then
                                fzf_cb(line)
                            end
                        end
                    end

                    fzf_cb()
                end, {
                    actions = {
                        ["default"] = open_fn(),
                        ["ctrl-t"] = open_fn("tabnew"),
                    },
                })
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: git worktree",
        },
        {
            "<leader>fM",
            function()
                local edit_fn = function(action)
                    return function(selected)
                        local items = vim.fn.split(selected[1], ":")
                        if #items < 2 then
                            return
                        end
                        local cmd = string.format("silent %s +%s %s", action, items[2], items[1])
                        vim.cmd(cmd)
                    end
                end
                require("fzf-lua").fzf_exec(function(fzf_cb)
                    local data = require("bookmarks").bookmark_data()
                    local cwd = vim.fn.fnamemodify(vim.loop.cwd(), ":p")
                    local feature = require("feature")
                    for _, d in ipairs(data) do
                        local filename = feature.get_relative_path(d.filename, cwd)
                        fzf_cb(string.format("%s:%s:%s", filename, d.lnum, d.text))
                    end
                    fzf_cb()
                end, {
                    actions = {
                        ["default"] = edit_fn("edit"),
                        ["ctrl-x"] = edit_fn("split"),
                        ["ctrl-v"] = edit_fn("vsplit"),
                        ["ctrl-t"] = edit_fn("tabedit"),
                    },
                    previewer = "builtin",
                })
            end,
            silent = true,
            remap = false,
            desc = "fzf-lua: fzf-marks",
        },
        {
            "<leader><leader>",
            function()
                require("fzf-lua").keymaps({
                    modes = { "n" },
                })
            end,
            mode = "n",
            silent = true,
            remap = false,
            desc = "fzf-lua: keymaps",
        },
        {
            "<leader><leader>",
            function()
                require("fzf-lua").keymaps({
                    modes = { "v" },
                })
            end,
            mode = { "v", "x" },
            silent = true,
            remap = false,
            desc = "fzf-lua: keymaps",
        },
    },
    cmd = { "FzfLua" },
}

return { fzf, fzf_lua }
